import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:e_contract/data/entity/log_info.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/send_log_status.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SendLogBloc extends Bloc<LogEvent, SendLogState>{
  final Repository repository;
  final bool viewLog;
  SendLogBloc({required this.repository, required this.viewLog}) : super(SendLogState()){
    on<SendLogEvent>(_sendLogEvent);
    on<ViewLogEvent>(_viewLogEvent);
    if(viewLog){
      add(ViewLogEvent());
    }
  }


  FutureOr<void> _sendLogEvent(SendLogEvent event, Emitter<SendLogState> emit) async{
    Directory? directory;
    if(Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    }else if(Platform.isIOS){
      directory= await getApplicationSupportDirectory();
    }
    File fileLogError= File("${directory?.path}/${Logger.pathFileLogError}");
    File fileLogActivity= File("${directory?.path}/${Logger.pathFileLogActivity}");
    File fileLogOther= File("${directory?.path}/${Logger.pathFileLogOther}");
    bool sendLogSuccess= false;
    if(!fileLogError.existsSync()){
      fileLogError.createSync();
    }
    if(!fileLogActivity.existsSync()){
      fileLogActivity.createSync();
    }
    if(!fileLogOther.existsSync()){
      fileLogOther.createSync();
    }/*
    List<LogInfo> logInfoError= await EContractDb.instance.selectLog(Logger.subtagLogError).get();
    List<LogInfo> logInfoActivity= await EContractDb.instance.selectLog(Logger.subtagLogActivity).get();
    List<LogInfo> logInfoOther= await EContractDb.instance.selectLog(Logger.subtagLogOther).get();
    String logError= S.of(event.context).log_error_string;
    String logActivity="";
    String logOther= S.of(event.context).log_other_string;
    for(var logInfo in logInfoError){
      logError+= "[${logInfo.timeLog}]: ${logInfo.logContent}\n--------------------------------------------------\n";
    }
    for(var logInfo in logInfoActivity){
      logActivity+= "[${logInfo.timeLog}]: ${logInfo.logContent}\n--------------------------------------------------\n";
    }
    for(var logInfo in logInfoOther){
      logOther += "[${logInfo.timeLog}] :${logInfo.logContent}\n--------------------------------------------------\n";
    }*/
    String logError="";
    String logActivity="";
    String logOther="";
    //await compute(partSQL,"");
    var receivePortError = ReceivePort();
    final isolateError = await Isolate.spawn(partSQL, [receivePortError.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogError).get()]);

    var receivePortActivity = ReceivePort();
    final isolateActivity = await Isolate.spawn(partSQL, [receivePortActivity.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogActivity).get()]);

    var receivePortOther = ReceivePort();
    final isolateOther = await Isolate.spawn(partSQL, [receivePortOther.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogOther).get()]);

    logError = await receivePortError.first;
    logActivity = await receivePortActivity.first;
    logOther = await receivePortOther.first;

    isolateError.kill(priority: Isolate.immediate);
    isolateActivity.kill(priority: Isolate.immediate);
    isolateOther.kill(priority: Isolate.immediate);
    try {
    await fileLogError.writeAsString(logError, mode: FileMode.append);
    await fileLogActivity.writeAsString(logActivity, mode: FileMode.append);
    await fileLogOther.writeAsString(logOther, mode: FileMode.append);
    }catch(e){
    Logger.logError("write log to file error ($e)");
    }
    sendLogSuccess= await repository.sendLogApp(fileLogError, fileLogActivity, fileLogOther);
    emit(state.copyWith(sendLogStatus: sendLogSuccess? SendLogSuccess(): SendLogFail()));
  }

  FutureOr<void> _viewLogEvent(ViewLogEvent event, Emitter<SendLogState> emit) async{
    Directory? directory;
    emit(state.copyWith(isShowProgressbar: true));
    if(Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    }else if(Platform.isIOS){
      directory= await getApplicationSupportDirectory();
    }
    String logError="";
    String logActivity="";
    String logOther="";
    //await compute(partSQL,"");
    var receivePortError = ReceivePort();
    final isolateError = await Isolate.spawn(partSQL, [receivePortError.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogError).get()]);

    var receivePortActivity = ReceivePort();
    final isolateActivity = await Isolate.spawn(partSQL, [receivePortActivity.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogActivity).get()]);

    var receivePortOther = ReceivePort();
    final isolateOther = await Isolate.spawn(partSQL, [receivePortOther.sendPort, await EContractDb.instance.selectLog(Logger.subtagLogOther).get()]);

    logError = await receivePortError.first;
    logActivity = await receivePortActivity.first;
    logOther = await receivePortOther.first;

    isolateError.kill(priority: Isolate.immediate);
    isolateActivity.kill(priority: Isolate.immediate);
    isolateOther.kill(priority: Isolate.immediate);
    // List<LogInfo> logInfoActivity= await EContractDb.instance.selectLog(Logger.subtagLogActivity).get();
    // List<LogInfo> logInfoOther= await EContractDb.instance.selectLog(Logger.subtagLogOther).get();
    //
    // for(var logInfo in logInfoActivity){
    //   logActivity+= "[${logInfo.timeLog}]: ${logInfo.logContent}\n--------------------------------------------------\n";
    // }
    // for(var logInfo in logInfoOther){
    //   logOther += "[${logInfo.timeLog}]: ${logInfo.logContent}\n--------------------------------------------------\n";
    // }
    emit(state.copyWith(logError: logError,
        logActivity: logActivity,
    logOther: logOther,isShowProgressbar: false));
  }
  static void partSQL(List<dynamic> args) async {
      var sendPort = args[0] as SendPort;
      String logApp="";
      List<LogInfo> logInfoError= args[1] as List<LogInfo>;
    for(var logInfo in logInfoError){
      logApp+= "[${logInfo.timeLog}]: ${logInfo.logContent}\n--------------------------------------------------\n";
    }
    sendPort.send(logApp);
    //  Isolate.exit(sendPort, logApp);
  }
}

class LogEvent extends BlocEvent{
  @override
  List<Object?> get props => [];
}

class SendLogEvent extends LogEvent{
  final BuildContext context;
  SendLogEvent(this.context);

  @override
  List<Object?> get props => [context];
}

class ViewLogEvent extends LogEvent{}

class SendLogState extends BlocState{
  final SendLogStatus sendLogStatus;
  final String logError;
  final String logActivity;
  final String logOther;
  final bool isShowProgress;

  SendLogState({this.sendLogStatus= const InitialSensLogStatus(), this.logError="", this.logActivity="", this.logOther="", this.isShowProgress = false});

  SendLogState copyWith({
  SendLogStatus sendLogStatus= const InitialSensLogStatus(),
    String logError= "",
    String logActivity="",
    String logOther= "",
    bool isShowProgressbar = true
  }){
    return SendLogState(sendLogStatus: sendLogStatus, logError: logError, logActivity: logActivity, logOther: logOther, isShowProgress: isShowProgressbar);
  }

  @override
  List<Object?> get props => [sendLogStatus, logError, logActivity, logOther, isShowProgress];
}