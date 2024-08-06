import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_contract/data/entity/sign_contract.dart';
import 'package:e_contract/data/entity/sign_hsm.dart';
import 'package:e_contract/data/entity/text_detail.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/lifecycle_manager.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/download_status.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/sign_otp_status.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final Repository repository;
  final String profileGuid;//Bkav Nhungltk: objectGuid cua ho so
  final String objectGuid;//objectGuid cua ProfileTextDetail
  final bool isSignDocumentPage;
  final int openSignTo;
  final String titleFile;
  final int indexSelected;
  Map<String, Uint8List> pdfCache = {}; // cache pdf de khong bi giat khi vuot

  StreamSubscription<List<TextDetail>>? _listTextDetailSubscription;

  DocumentBloc(
      {required this.repository,
        required this.profileGuid,
      required this.objectGuid,
      this.isSignDocumentPage= false,
      this.openSignTo= -1,
      required this.titleFile,
      this.indexSelected= -1})
      : super(DocumentState(bytes: const {})) {
    on<ShowDocumentEvent>(_showDocument);
    on<SignDocumentEvent>(signDocument);
    on<RefreshDocumentEvent>(_refreshDocument);
    on<ConfirmOTP>(_confirmSignOTP);
    on<DownloadDoccumentEvent>(_downloadDoccument);
    on<ShareDocumentEvent>(_shareDocument);
    on<SendingOTPEvent>(_sendingOTP);
    on<CountTimer>(_countTimer);
    on<SignHSMDocumentEvent>(_signHSMDocument);
    isSignDocumentPage
        ? add(ShowDocumentEvent(profileGuid, objectGuid, "",
            indexSelected, false)) //) // giao dien ky k can title
        : add(ShowDocumentEvent(
            profileGuid, objectGuid, titleFile, indexSelected, false));

    // lang nghe vong doi
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () async => !super.isClosed? add(ShowDocumentEvent(profileGuid, objectGuid, titleFile, indexSelected, false)): null));
  }


  FutureOr<void> _shareDocument(ShareDocumentEvent event, Emitter<DocumentState> emit) async{
    String base = await repository.getDocumentContent(
        event.profileGuid);
    Uint8List bytes = base64.decode(base);
    final Size size = MediaQuery.of(event.context).size;
    Get.back();
    await Share.shareXFiles(
      [
        XFile.fromData(
          bytes,
          name: event.fileName,
          mimeType: 'pdf',
        ),
      ],
      text:event.fileName,
      subject:event.fileName,
      sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2)
    );
    // await Share.file(
    //     "Share file", "${event.fileName}.pdf", bytes, '*/*');
  }

  FutureOr<void> _showDocument(
      ShowDocumentEvent event, Emitter<DocumentState> emit) async {
    // Bkav HanhNTHe: cap nhat truoc xem co bi giat nua khong
    emit(state.copyWith(title: event.titleFile, index: event.currentIndex));
    // if (pdfCache.isNotEmpty && pdfCache.length > event.currentIndex) {
    //   debugPrint(" 40000 -----------------  ${event.currentIndex}");
    //   emit(state.copyWith(
    //       byte: base64.decode(pdfCache[event.currentIndex]),
    //       title: event.titleFile,
    //       index: event.currentIndex));
    // }
    // final pref = await SharedPreferences.getInstance();
    // String baseSharePref = pref.getString(event.objectGuid) ?? "";
    if (!pdfCache.containsKey(event.objectGuid) || event.isSignSuccess) {
      // if(baseSharePref != ""&& event.isSignSucces== false){
      //   Logger.loggerDebug("Nhungltk _showDocument");
      //   Uint8List bytes = base64.decode(baseSharePref);
      //   emit(state.copyWith(
      //       byte: bytes, title: event.titleFile, index: event.currentIndex));
      // }
      // Bkav HanhNTHe: end
      String base = await repository.getDocumentContent(event.objectGuid);
      // pref.setString(event.objectGuid, base);
      // them vao cache

/*      debugPrint(
          '_showDocument ${event.objectGuid} ${event.titleFile} - ---- ${event.currentIndex}');*/
      Uint8List bytes = base64.decode(base);
      // (state.bytes ?? {}).putIfAbsent(event.objectGuid, () => bytes);
      // HanhNTHe: phai push lai rong de giao dien update
      emit(state.copyWith(
          byte: {"test" : Uint8List(0)},
          title: event.titleFile,
          index: event.currentIndex,
          signSelect: false));
      if(event.isSignSuccess){
        // delay de load lai ho so
        await Future.delayed(Duration(milliseconds: 500));
      }
      pdfCache.putIfAbsent(event.objectGuid, () => bytes);
      pdfCache[event.objectGuid] = bytes;
      emit(state.copyWith(
          byte: pdfCache,
          title: event.titleFile,
          index: event.currentIndex,
          signSelect: false));
    }
  }

  //Bkav Nhungltk: send OTP
  void signDocument(SignDocumentEvent event, Emitter<DocumentState> emit) async{
    //Bkav HoangLD hàm này vẫn sử dụng ,hôm em chuyển code bị nhầm ạ
    emit(state.copyWith(signOtpStatuss: const SendOtp(), signSelect: true));
    SignContractInfo signContractInfo=await repository.sendOTP(event.profileGui ,event.typeSign);
    Logger.loggerDebug("nhungltk sendOTP: ${signContractInfo.errorMessage}, ${event.profileGui}, sdt: ${signContractInfo.phoneNumber}");
    if(signContractInfo.phoneNumber!=""){
      emit(state.copyWith(signOtpStatuss: SendOtpSuccess(), signContractInfoo: signContractInfo));
    }else if(signContractInfo.errorMessage!=""){
      emit(state.copyWith(signOtpStatuss: const SendOtpFail(), signContractInfoo: signContractInfo));
    }
  }
  //Bkav HoangLD : signHSM
  void _signHSMDocument(SignHSMDocumentEvent event, Emitter<DocumentState> emit) async{
    SignHSMContractInfo signHSMContractInfo = await repository.signHSM(event.objectGuid);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    if(signHSMContractInfo.isOk){
      DiaLogManager.showDialogSignSucces(event.context,"","","");
      emit(state.copyWith(statusSignDoc: false));
    }else{
      if(signHSMContractInfo.status == -5){
        DiaLogManager.displayDialog(
            event.context,
            signHSMContractInfo.reasonError,
            "", () async {
          // HoangLD chuyển đến trang đăng ký
          Get.back();
        }, () {
          Get.back();
        }, S.of(event.context).cancel, S.of(event.context).extend_cks);
    }else if(signHSMContractInfo.status == -6){
        DiaLogManager.displayDialog(
            event.context,
            signHSMContractInfo.reasonError,
            "", () async {
              // HoangLD chuyển đến trang gia hạn
          Get.back();
        }, () {
          Get.back();
        }, S.of(event.context).cancel, S.of(event.context).register_cks);
      }
    }
  }

  void _refreshDocument(
      RefreshDocumentEvent event, Emitter<DocumentState> emit) {
    isSignDocumentPage
        ? add(ShowDocumentEvent(profileGuid, objectGuid, "",
        event.indexSelected, false)) //) // giao dien ky k can title
        : add(ShowDocumentEvent(
        profileGuid, objectGuid, event.titleName, event.indexSelected, false));
  }

  @override
  Future<void> close() async{
    repository.dispose();
    if (_listTextDetailSubscription != null) {
      _listTextDetailSubscription!.cancel();
    }
    return super.close();
  }

  FutureOr<void> _confirmSignOTP(ConfirmOTP event, Emitter<DocumentState> emit) async{
    emit(state.copyWith(signOtpStatuss: ConfirmOTPStatus()));
    if(event.checkEKYC){
      ContractSignInfo contractSignInfo = await repository.confirmOTPEKYC(event.profileGuid, event.otp);
      //BLAV HoangLD cái này em dùng luôn code cũ nên gán cho tokenHSM = tokenEKYC
      if(contractSignInfo.tokenHSM!= ""){
        (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenEKYC,contractSignInfo.tokenHSM);
        emit(state.copyWith(signOtpStatuss: ConfirmOtpSuccess(), contractSignInfoo:contractSignInfo));
      }else{
        emit(state.copyWith(signOtpStatuss: ConfirmOtpFail(), contractSignInfoo:contractSignInfo));
      }
    }else{
      ContractSignInfo contractSignInfo = await repository.confirmOTP(event.profileGuid, event.otp, event.isFrom, event.typeSign);
      Logger.loggerDebug("nhungtlk contractSign: ${contractSignInfo.signDate}, ${event.profileGuid}, ${event.otp}, ${contractSignInfo.errorMessage}");
      if(contractSignInfo.signDate!= ""){
        if(event.typeSign == ContractConstants.hsmSign){
          //final pref = await SharedPreferences.getInstance();
          (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenHSM,contractSignInfo.tokenHSM);
        }
        emit(state.copyWith(signOtpStatuss: ConfirmOtpSuccess(), contractSignInfoo:contractSignInfo));
      }else{
        emit(state.copyWith(signOtpStatuss: ConfirmOtpFail(), contractSignInfoo:contractSignInfo));
      }
    }

  }

  FutureOr<void> _downloadDoccument(DownloadDoccumentEvent event, Emitter<DocumentState> emit) async{
    String base = await repository.getDocumentContent(
        event.profileGuid);
    Uint8List bytes = base64.decode(base);

    Directory folderDownload = Directory(
        "/storage/emulated/0/Download/eContract");
    if(event.cancel==false) {
        if (Platform.isAndroid) {
          while (!folderDownload.existsSync()) {
            try {
              await folderDownload.create();
              if (folderDownload.existsSync()) {
                File file = File(
                    "${folderDownload.path}/${event.fileName.toLowerCase()
                        .trim()}.pdf");
                while(!file.existsSync()){
                  try{
                    await file.create();
                  }catch(e){
                    Logger.logError("_downloadDoccument: cannot create file ${event.fileName} exception (${e.toString()})");
                    emit(state.copyWith(downloadStatuss: DownloadFailStatus()));
                    break;
                  }
                }
                int n = 0;
                while (await file.exists()) {
                  if (file
                      .readAsBytesSync()
                      .isEmpty) {
                    emit(state.copyWith(downloadStatuss: DownloadingStatus()));
                    try {
                      writeTofile(file, bytes);
                    }catch(e){
                      Logger.logError("_downloadDoccument cannot write to file ${event.fileName} exception (${e.toString()})");
                      emit(state.copyWith(downloadStatuss: DownloadFailStatus()));
                      break;
                    }
                    emit(state.copyWith(
                        downloadStatuss: DownloadCompleteStatus(basename(file.path))));
                    break;
                  } else {
                    n++;
                    file = File(
                        "${folderDownload.path}/${event.fileName}_$n.pdf");
                    while (!await file.exists()) {
                      try {
                        await file.create();
                      } catch (e) {
                        Logger.logError("_downloadDoccument cannot create file ${event.fileName}_$n exception (${e.toString()})");
                        emit(state.copyWith(downloadStatuss: DownloadFailStatus()));
                        break;
                      }
                    }
                  }
                }
              }

            } catch (e) {
              Logger.logError("_downloadDoccument: cannot create folder download exception (${e.toString()})");
              emit(state.copyWith(downloadStatuss: DownloadFailStatus()));
              break;
            }
          }
          File file = File(
              "${folderDownload.path}/${event.fileName.toLowerCase()
                  .trim()}.pdf");
          emit(state.copyWith(downloadStatuss: DownloadingStatus()));
          try {
            writeTofile(file, bytes);
            emit(state.copyWith(
                downloadStatuss: DownloadCompleteStatus(basename(file.path))));
          }catch(e){
            Logger.logError("_downloadDoccument cannot write to file ${event.fileName} exception (${e.toString()})");
            emit(state.copyWith(downloadStatuss: DownloadFailStatus()));
          }
        }
    }else{
      if (folderDownload.existsSync()) {
        File file = File(
            "${folderDownload.path}/${event.fileName.toLowerCase()
                .trim()}.pdf");
        while(file.existsSync()){
          try{
            await file.delete();
          }catch(e){
            Logger.logError("_downloadDoccument: cannot cancel download exception (${e.toString()})");
            break;
          }
        }
      }
/*
      emit(state.copyWith(downloadStatuss: DownloadCancelStatus("Tải file không thành công.")));
*/
    }
  }

  Future<void> writeTofile(File file, Uint8List bytes) async{
    await file.writeAsBytes(bytes);
  }

  FutureOr<void> _sendingOTP(SendingOTPEvent event, Emitter<DocumentState> emit) {
    emit(state.copyWith(signSelect: event.selectSign));
  }

  FutureOr<void> _countTimer(CountTimer event, Emitter<DocumentState> emit) async {
      emit(state.copyWith(countTimeDown: event.countTime));
  }
}

extension ExtendList<T> on List<T> {
  void extend(int newLength, T defaultValue) {
    assert(newLength >= 0);

    final lengthDifference = newLength - length;
    if (lengthDifference <= 0) {
      return;
    }

    addAll(List.filled(lengthDifference, defaultValue));
  }
}

class DocumentEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class ShareDocumentEvent extends DocumentEvent{

  final String profileGuid;
  final String fileName;
  final bool cancel;
  final BuildContext context;
  ShareDocumentEvent(this.profileGuid, this.fileName, this.cancel, this.context);

  @override
  List<Object?> get props => [profileGuid, fileName, cancel, context];
}


class ShowDocumentEvent extends DocumentEvent {
  final String objectGuid;// objectGuid cua ProfileTextDetail
  final String profileGuid;// objectGuid cua ho so
  final String titleFile; // cai ma se show tren title
  final int currentIndex;// cai ma index cua trang show hien tai
  final bool isSignSuccess;

  ShowDocumentEvent(this.profileGuid, this.objectGuid, this.titleFile, this.currentIndex, this.isSignSuccess);

  @override
  List<Object?> get props => [profileGuid, objectGuid, titleFile, currentIndex, isSignSuccess];
}

class CountTimer extends DocumentEvent{
  final bool countTime;
  CountTimer({required this.countTime});
}

class DownloadDoccumentEvent extends DocumentEvent{
  final String profileGuid;
  final String fileName;
  final bool cancel;
  DownloadDoccumentEvent(this.profileGuid, this.fileName, this.cancel);

  @override
  List<Object?> get props => [profileGuid, fileName, cancel];
}

class RefreshDocumentEvent extends DocumentEvent {
  final String titleName;
  final int indexSelected;
  RefreshDocumentEvent(this.titleName, this.indexSelected);

  @override
  List<Object?> get props => [titleName, indexSelected];
}

class SendingOTPEvent extends DocumentEvent{
  final bool selectSign;
  SendingOTPEvent({required this.selectSign});
  @override
  List<Object?> get props => [selectSign];
}

class SignDocumentEvent extends DocumentEvent {
  final String profileGui;
  final String profileName;
  final BuildContext context;
  final int typeSign;
  SignDocumentEvent(this.profileGui, this.context, this.profileName, this.typeSign);

  @override
  List<Object?> get props => [profileGui, profileName];
}
class SignHSMDocumentEvent extends DocumentEvent {
  final String objectGuid;
  final BuildContext context;
  SignHSMDocumentEvent(this.objectGuid, this.context);

  @override
  List<Object?> get props => [objectGuid];
}

class ConfirmOTP extends DocumentEvent{
  final String profileGuid;
  final String otp;
  final bool isFrom;
  final int typeSign;
  final bool checkEKYC;

  ConfirmOTP({required this.profileGuid, required this.otp, required this.isFrom, required this.typeSign, required this.checkEKYC});

  @override
  List<Object?> get props => [profileGuid, otp, isFrom, typeSign, checkEKYC];
}

class DocumentState extends BlocState {

  Map<String,Uint8List>? bytes;
  final String titleFile; // hien thi title tuong ung voi file trong phan show
  final int indexSelected; // dung de hien thi 2 nut next va previous
  final SignOtpStatus signOtpStatus;
  final ContractSignInfo? contractSignInfo;
  final SignContractInfo? signContractInfo;
  final DownloadStatus downloadStatus;
  final bool selectSign;
  final bool countTime;
  final bool statusSign;

  DocumentState(
      {this.bytes,
      this.titleFile = "",
      this.indexSelected = -1,
      this.signOtpStatus= const SendOtp(),
      this.contractSignInfo,
      this.signContractInfo,
      this.downloadStatus = const DownloadInitial(),
      this.selectSign= false,
      this.countTime= false,
      this.statusSign= true});

  DocumentState copyWith(
      {Map<String, Uint8List>? byte,
      String? title,
      int? index,
      SignOtpStatus? signOtpStatuss,
      ContractSignInfo? contractSignInfoo,
      SignContractInfo? signContractInfoo,
      DownloadStatus downloadStatuss = const DownloadInitial(),
      bool? signSelect,
      bool countTimeDown = true,
      bool statusSignDoc = true}) {
    return DocumentState(
        bytes: byte ?? bytes,
        titleFile: title ?? "",
        indexSelected: index ?? indexSelected,
        signOtpStatus: signOtpStatuss ?? signOtpStatus,
        contractSignInfo: contractSignInfoo ?? contractSignInfo,
        signContractInfo: signContractInfoo ?? signContractInfo,
        downloadStatus: downloadStatuss,
        selectSign: signSelect ?? this.selectSign,
        countTime: countTimeDown,
        statusSign: statusSignDoc);
  }

  @override
  List<Object?> get props => [bytes,titleFile, indexSelected, signOtpStatus,
    contractSignInfo, signContractInfo, downloadStatus, selectSign, countTime,statusSign];

}
