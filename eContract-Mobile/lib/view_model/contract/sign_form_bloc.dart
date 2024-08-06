import 'dart:async';

import 'package:e_contract/data/entity/initAccessToken.dart';
import 'package:e_contract/data/entity/remote_signing_success.dart';
import 'package:e_contract/data/entity/select_sign.dart';
import 'package:e_contract/data/entity/sign_contract.dart';
import 'package:e_contract/data/entity/sign_hsm.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/constants/api_constains.dart';
import 'package:e_contract/utils/constants/contract_constants.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/download_status.dart';
import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/sign_otp_status.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:e_contract/view_model/contract/show_dcument_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Bkav HoangLD Bloc
class SignFormBloc extends Bloc<SignFormEvent, SignFormState> {
  final Repository repository;
  final String objectGuid;
  final BuildContext context;
  Timer? _timer;

  SignFormBloc(this.context,
      {required this.repository, required this.objectGuid})
      : super(SignFormState()) {
    on<StartSignForm>(_startSignType);
    on<RadioChangeEvent>(_onRadioChange);
    on<SignHSMDocumentEvent>(_signHSMDocument);
    on<RemoteSigningSubmitEvent>(_remoteSigningSubmit);
    on<RemoteSigningCancelSignEvent>(_remoteSigningCancel);
    on<RemoteSigningFinishEvent>(_remoteSigningSuccessEvent);
    on<SendingOTPEvent>(_sendingOTP);
    on<SignDocumentEvent>(signDocument);
    on<SignEKYC>(_signEKYC);

    add(StartSignForm());
  }

  void _startSignType(StartSignForm event, Emitter<SignFormState> emit) async {
    List<SelectSign> list = await repository.getListTypeSignApp(objectGuid);
    List<bool> listClick = [];
    int typeSign = 0;
    listClick.addAll(List<bool>.generate(list.length, (i) => false));
    for (var i = 0; i < list.length; i++) {
      if (!list[i].isDisable) {
        typeSign = list[i].id;
        listClick[i] = true;
        break;
      }
    }
    emit(state.copyWith(
        list: list,
        checkSignBut: false,
        typeSignBut: typeSign,
        checklist: listClick,
        isSignSuccess: false));
  }
  void _signEKYC(SignEKYC event, Emitter<SignFormState> emit) async {
    //BKAV HoangLD nếu đã có token thì thực hiện kịch bản này
    var tokenEKYC = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenEKYC)??"";
    DiaLogManager.displayLoadingDialog(context);
    InitAccessToken init = await repository.getAccessTokenEKYC(objectGuid, tokenEKYC);
    if(init.accessTokenEKYC !=""){
      String transactionIdBack = await Utils.callNativeEKYC(init.accessTokenEKYC,init.typeEKYC.toString());
      if(transactionIdBack != ""){
        ContractSignInfo signContractInfo = await repository.signEKYC(event.profileGui, transactionIdBack);
        if(signContractInfo.signDate != ""){
          emit(state.copyWith(
              signOtpStatuss: SendTokenHsmSuccess(),
              contractSignInfoo: signContractInfo));
        }
      }
    }else{
      //BKAV HoangLD lấy tokenEKYC
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      emit(state.copyWith(signOtpStatuss: const SendOtp(), sendingOTP: true));
      SignContractInfo signContractInfo = await repository.sendOTP(event.profileGui, ContractConstants.radioEKYC);
      Logger.loggerDebug(
          "nhungltk sendOTP: ${signContractInfo.errorMessage}, ${event.profileGui}, sdt: ${signContractInfo.phoneNumber}");
      if (signContractInfo.phoneNumber != "") {
        emit(state.copyWith(
            signOtpStatuss: SendOtpEKYCSuccess(),
            signContractInfoo: signContractInfo,
            typeSignBut: ContractConstants.radioEKYC));
      } else if (signContractInfo.errorMessage != "") {
        emit(state.copyWith(
            signOtpStatuss: const SendOtpFail(),
            signContractInfoo: signContractInfo));
      }
    }
  }
  //Bkav HoangLD : signHSM
  void _signHSMDocument(
      SignHSMDocumentEvent event, Emitter<SignFormState> emit) async {
    SignHSMContractInfo signHSMContractInfo =
        await repository.signHSM(event.objectGuid);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    if (signHSMContractInfo.isOk) {
      DiaLogManager.showDialogSignSucces(context, "", "", "");
    } else {
      if (signHSMContractInfo.status == -5) {
        DiaLogManager.displayDialog(
            context, signHSMContractInfo.reasonError, "", () async {
          // HoangLD chuyển đến trang đăng ký
          Get.back();
        }, () {
          Get.back();
        }, S.of(context).cancel, S.of(context).extend_cks);
      } else if (signHSMContractInfo.status == -6) {
        DiaLogManager.displayDialog(
            context, signHSMContractInfo.reasonError, "", () async {
          // HoangLD chuyển đến trang gia hạn
          Get.back();
        }, () {
          Get.back();
        }, S.of(context).cancel, S.of(context).register_cks);
      }
    }
  }

  FutureOr<void> _onRadioChange(
      RadioChangeEvent event, Emitter<SignFormState> emit) async {
    emit(state.copyWith(
        checkSignBut: false,
        typeSignBut: event.index,
        checklist: event.list,
        isSignSuccess: false));
  }

  FutureOr<void> _remoteSigningSubmit(
      RemoteSigningSubmitEvent event, Emitter<SignFormState> emit) async {
    // lay thong tin thoi gian de hien thi giao dien
    int rsTime = await repository.getTimeCallRS();
    if (rsTime != -1) {
      emit(state.copyWith(isSignSuccess: true, time: rsTime));
    } else {
      add(RemoteSigningFinishEvent());
      return;
    }
    if (!ApiConstants.switchRemoteSigningOk) {
      // emit(state.copyWith(isSignSuccess: true));
      RemoteSigningSuccess? remoteSigningSuccess =
          await repository.signRemoteSigningTemp(event.objectGuid);
      if (remoteSigningSuccess == null) {
        add(RemoteSigningFinishEvent());
      } else if (remoteSigningSuccess.transactionRemoteSignStatus == 5) {
        add(RemoteSigningFinishEvent());
        //Bkav HoangLD fix bug không đóng dialog đếm giây
        Get.back();
        // trường hợp huy ky ( huy xac thuc ) hiển thị dialog huy thanh cong
        DiaLogManager.displayCancelRemoteSigningDialog(context, false, () {
          // ky lai thi goi lai api ky remote signing
          Navigator.pop(context);
          add(RemoteSigningSubmitEvent(event.objectGuid));
        });
      } else if (remoteSigningSuccess.transactionRemoteSignStatus == 6) {
        add(RemoteSigningFinishEvent());
        Get.back();
        // trường hợp hết hạn
        DiaLogManager.displayCancelRemoteSigningDialog(context, true, () {
          // ky lai thi goi lai api ky remote signing
          Navigator.pop(context);
          add(RemoteSigningSubmitEvent(event.objectGuid));
        });
      } else {
        if (remoteSigningSuccess.signerName != "") {
          emit(state.copyWith(
              signDa: remoteSigningSuccess.signDate,
              profileCo: remoteSigningSuccess.profileCode,
              signerNa: remoteSigningSuccess.signerName,
              isSignSuccess: false));
        }
      }
      return;
    }
    String transactionGuid =
        await repository.signRemoteSigning(event.objectGuid);
    emit(state.copyWith(isSignSuccess: true, transactionId: transactionGuid));
    // call api thuc hien lang nghe ket qua, 3s call 1 lan
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      RemoteSigningSuccess? remoteSigningSuccess =
          await repository.getResultRemoteSigning(transactionGuid);
      if (remoteSigningSuccess == null) {
        add(RemoteSigningFinishEvent());
        return;
      }
      // debugPrint("HanhNHT e transactionId ${remoteSigningSuccess.transactionRemoteSignStatus}  -- ${remoteSigningSuccess.signDate}");
      if (remoteSigningSuccess.transactionRemoteSignStatus ==
          ContractConstants.authenticated) {
        // trường hợp đã ký ok ( đã xác thực) hiển thị dialog thành công
        add(RemoteSigningFinishEvent());
        DiaLogManager.showDialogSignSucces(
            context,
            remoteSigningSuccess.profileCode,
            remoteSigningSuccess.signerName,
            remoteSigningSuccess.signDate);
      } else if (remoteSigningSuccess.transactionRemoteSignStatus ==
          ContractConstants.cancelAuthentication) {
        add(RemoteSigningFinishEvent());
        // trường hợp huy ky ( huy xac thuc ) hiển thị dialog huy thanh cong
        DiaLogManager.displayCancelRemoteSigningDialog(context, true, () {
          // ky lai thi goi lai api ky remote signing
          add(RemoteSigningSubmitEvent(event.objectGuid));
        });
      }
    });
  }

  FutureOr<void> _remoteSigningCancel(
      RemoteSigningCancelSignEvent event, Emitter<SignFormState> emit) async {
    int transactionId1 =
        await repository.cancelRemoteSigning(event.transactionGuid);
    // debugPrint("HanhNHT e transactionId  transactionId1 $transactionId1");
  }

  FutureOr<void> _remoteSigningSuccessEvent(
      RemoteSigningFinishEvent event, Emitter<SignFormState> emit) {
    if (_timer != null) {
      _timer!.cancel();
    }
    emit(state.copyWith(isSignSuccess: false));
  }

  FutureOr<void> _sendingOTP(
      SendingOTPEvent event, Emitter<SignFormState> emit) {
    emit(state.copyWith(sendingOTP: event.sendingOTP));
  }

  //Bkav Nhungltk: send OTP
  void signDocument(
      SignDocumentEvent event, Emitter<SignFormState> emit) async {
    if(event.checkSign == ContractConstants.radioOTP){
      emit(state.copyWith(signOtpStatuss: const SendOtp(), sendingOTP: true));
      SignContractInfo signContractInfo = await repository.sendOTP(event.profileGui, ContractConstants.radioOTP);
      Logger.loggerDebug(
          "nhungltk sendOTP: ${signContractInfo.errorMessage}, ${event.profileGui}, sdt: ${signContractInfo.phoneNumber}");
      if (signContractInfo.phoneNumber != "") {
        emit(state.copyWith(
            signOtpStatuss: SendOtpSuccess(),
            signContractInfoo: signContractInfo,
            typeSignBut: ContractConstants.radioOTP));
      } else if (signContractInfo.errorMessage != "") {
        emit(state.copyWith(
            signOtpStatuss: const SendOtpFail(),
            signContractInfoo: signContractInfo));
      }
    }else if(event.checkSign == ContractConstants.radioHSM){
      //Bkav HoangLD trường hợp ký hsm phải kiểm tra tokenHSM trước theo kịch bản
      //final pref = await SharedPreferences.getInstance();
      var tokenHSM = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenHSM)??"";
      if(tokenHSM == ""){
        emit(state.copyWith(signOtpStatuss: const SendOtp(), sendingOTP: true));
        SignContractInfo signContractInfo = await repository.sendOTP(event.profileGui, ContractConstants.radioHSM);
        Logger.loggerDebug(
            "nhungltk sendOTP: ${signContractInfo.errorMessage}, ${event.profileGui}, sdt: ${signContractInfo.phoneNumber}");
        if (signContractInfo.phoneNumber != "") {
          emit(state.copyWith(
              signOtpStatuss: SendOtpSuccess(),
              signContractInfoo: signContractInfo,
              typeSignBut: ContractConstants.radioHSM));
        } else if (signContractInfo.errorMessage != "") {
          emit(state.copyWith(
              signOtpStatuss: const SendOtpFail(),
              signContractInfoo: signContractInfo));
        }
      }else{
        ContractSignInfo signContractInfo = await repository.sendOtpByTokenHsm(event.profileGui, tokenHSM);
        if(signContractInfo.signDate != ""){
          emit(state.copyWith(
              signOtpStatuss: SendTokenHsmSuccess(),
              contractSignInfoo: signContractInfo));
        }else if (signContractInfo.errorMessage != "") {
          //Bkav HoangLD nếu tokenHSM không thể sử dụng thì reset tokenHSM và load lại kịch bản
          (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenHSM,"");
          add(SignDocumentEvent(event.profileGui, context,
              event.profileName,ContractConstants.radioHSM));
        }

      }
    }else if(event.checkSign == ContractConstants.radioEKYC){
      var tokenEKYC = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenEKYC)??"";
      if(tokenEKYC == ""){
        //BKAV HoangLD lấy tokenEKYC
        emit(state.copyWith(signOtpStatuss: const SendOtp(), sendingOTP: true));
        SignContractInfo signContractInfo = await repository.sendOTP(event.profileGui, ContractConstants.radioEKYC);
        Logger.loggerDebug(
            "nhungltk sendOTP: ${signContractInfo.errorMessage}, ${event.profileGui}, sdt: ${signContractInfo.phoneNumber}");
        if (signContractInfo.phoneNumber != "") {
          emit(state.copyWith(
              signOtpStatuss: SendOtpEKYCSuccess(),
              signContractInfoo: signContractInfo,
              typeSignBut: ContractConstants.radioEKYC));
        } else if (signContractInfo.errorMessage != "") {
          emit(state.copyWith(
              signOtpStatuss: const SendOtpFail(),
              signContractInfoo: signContractInfo));
        }
      }else{
        add(SignEKYC(event.profileGui));
        //BKAV HoangLD nếu đã có token thì thực hiện kịch bản này
        /*DiaLogManager.displayLoadingDialog(context);
        InitAccessToken init = await repository.getAccessTokenEKYC(objectGuid, tokenEKYC);
        if(init.accessTokenEKYC !=""){
          String transactionIdBack = await Utils.callNativeEKYC(init.accessTokenEKYC,init.typeEKYC.toString());
          if(transactionIdBack != ""){
            ContractSignInfo signContractInfo = await repository.signEKYC(event.profileGui, transactionIdBack);
            if(signContractInfo.signDate != ""){
              emit(state.copyWith(
                  signOtpStatuss: SendTokenHsmSuccess(),
                  contractSignInfoo: signContractInfo));
            }
          }
        }*/
      }

    }
  }
}

class StartSignForm extends SignFormEvent {}

class SignFormEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}
class SignEKYC extends SignFormEvent {
  final String profileGui;

  SignEKYC(this.profileGui);
  @override
  List<Object?> get props => [profileGui];
}


class SendingOTPEvent extends SignFormEvent {
  final bool sendingOTP;

  SendingOTPEvent({required this.sendingOTP});

  @override
  List<Object?> get props => [sendingOTP];
}

class RadioChangeEvent extends SignFormEvent {
  RadioChangeEvent(this.index, this.list);

  final int index;
  final List<bool> list;
}

class SignHSMDocumentEvent extends SignFormEvent {
  final String objectGuid;

  SignHSMDocumentEvent(this.objectGuid);

  @override
  List<Object?> get props => [objectGuid];
}

class RemoteSigningSubmitEvent extends SignFormEvent {
  final String objectGuid;

  RemoteSigningSubmitEvent(this.objectGuid);

  @override
  List<Object?> get props => [objectGuid];
}

class SignDocumentEvent extends SignFormEvent {
  final String profileGui;
  final String profileName;
  final BuildContext context;
  final int checkSign;

  SignDocumentEvent(this.profileGui, this.context, this.profileName,this.checkSign);

  @override
  List<Object?> get props => [profileGui, profileName,checkSign];
}

class RemoteSigningCancelSignEvent extends SignFormEvent {
  final String transactionGuid;

  RemoteSigningCancelSignEvent(this.transactionGuid);

  @override
  List<Object?> get props => [transactionGuid];
}

class RemoteSigningFinishEvent extends SignFormEvent {
  RemoteSigningFinishEvent();

  @override
  List<Object?> get props => [];
}

class SignFormState extends BlocState {
  final List<SelectSign> usersList;
  final List<bool> clickList;
  final bool checkSign;
  final int typeSign;
  final bool isSignRemoteSuccess;
  final String transactionGuid;
  final String profileCode;
  final String signerName;
  final String signDate;
  final SignOtpStatus signOtpStatus;
  final ContractSignInfo? contractSignInfo;
  final SignContractInfo? signContractInfo;
  final DownloadStatus downloadStatus;
  final bool sendingOTP;
  final bool countTime;
  final bool statusSign;
  final int timeSignRS;

  SignFormState(
      {this.usersList = const [],
      this.checkSign = false,
      this.typeSign = 0,
      this.clickList = const [],
      this.isSignRemoteSuccess = false,
      this.transactionGuid = "",
      this.signDate = "",
      this.profileCode = "",
      this.signerName = "",
      this.signOtpStatus = const SendOtp(),
      this.contractSignInfo,
      this.signContractInfo,
      this.downloadStatus = const DownloadInitial(),
      this.sendingOTP = false,
      this.countTime = false,
      this.statusSign = true,
      this.timeSignRS = 0});

  SignFormState copyWith(
      {List<SelectSign>? list,
      bool? checkSignBut,
      int? typeSignBut,
      List<bool>? checklist,
      bool? isSignSuccess,
      String? transactionId,
      String? profileCo,
      String? signerNa,
      String? signDa,
      SignOtpStatus? signOtpStatuss,
      ContractSignInfo? contractSignInfoo,
      SignContractInfo? signContractInfoo,
      DownloadStatus downloadStatuss = const DownloadInitial(),
      bool? sendingOTP,
      bool countTimeDown = true,
      bool statusSignDoc = true,
      int? time}) {
    return SignFormState(
        usersList: list ?? usersList,
        checkSign: checkSignBut ?? checkSign,
        typeSign: typeSignBut ?? typeSign,
        clickList: checklist ?? clickList,
        isSignRemoteSuccess: isSignSuccess ?? isSignRemoteSuccess,
        transactionGuid: transactionId ?? transactionGuid,
        signerName: signerNa ?? signerName,
        signDate: signDa ?? signDate,
        profileCode: profileCo ?? profileCode,
        signOtpStatus: signOtpStatuss ?? signOtpStatus,
        contractSignInfo: contractSignInfoo ?? contractSignInfo,
        signContractInfo: signContractInfoo ?? signContractInfo,
        downloadStatus: downloadStatuss,
        sendingOTP: sendingOTP ?? this.sendingOTP,
        countTime: countTimeDown,
        statusSign: statusSignDoc,
        timeSignRS: time ?? timeSignRS);
  }

  @override
  List<Object?> get props => [
        usersList,
        checkSign,
        typeSign,
        clickList,
        isSignRemoteSuccess,
        transactionGuid,
        profileCode,
        signDate,
        signerName,
        signOtpStatus,
        contractSignInfo,
        signContractInfo,
        downloadStatus,
        sendingOTP,
        countTime,
        statusSign,
        timeSignRS
      ];
}
