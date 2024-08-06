import 'dart:convert';
import 'dart:io';

import 'package:e_contract/data/entity/list_sign_info.dart';
import 'package:e_contract/data/entity/unit_user_info.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/validator.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view/home/home_page.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final bool isFaceId;
  final bool isFingerprint;
  final String lastUserName;
  final BuildContext context;
  final bool isChangeBiometric;

  LoginBloc(this.isFaceId, this.isFingerprint, this.lastUserName, this.context, this.isChangeBiometric, {required this.repository}) : super(LoginState()) {
    //on<LoginUserNameChanged>(_loginUsernameChanged);
    //on<LoginPasswordChanged>(_loginPasswordChanged);
    on<LoginSubmitted>(_loginSubmitted);
    on<RememberLoginChanged>(_rememberLoginChanged);
    on<LoginBiometric>(_loginBiometric);
    on<EventFocusTextField>(_eventFocusTextField);
    on<NotClickBiometric>(_notClickBiometric);
    //HoangLD check da bat van tay hoac faceid thi hien dialog luon de dang nhap
    //HoangLD kịch bản thay đổi nên tạm thời tắt autofocus biometric
/*    if(isFaceId){
      add(LoginBiometric(lastUserName, BiometricType.face, context,isChangeBiometric));
    }else if(isFingerprint){
      add(LoginBiometric(lastUserName, BiometricType.fingerprint, context,isChangeBiometric));
    }*/
  }
  void _notClickBiometric(NotClickBiometric event, Emitter<LoginState> emit){
    if(event.biometricType == BiometricType.fingerprint){
      emit(state.copyWith(
          formStatus: SubmissionBiometricFailed(
              S.of(event.context).error_title_fingerprint)));
    }else{
      emit(state.copyWith(
          formStatus: SubmissionBiometricFailed(
              S.of(event.context).error_title_face_id)));
    }
  }

  void _eventFocusTextField(EventFocusTextField event, Emitter<LoginState> emit){
    emit(state.copyWith(formStatus: const InitialFormStatus()));
  }
  void _rememberLoginChanged(
      RememberLoginChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        isRemember: event.isRememberLogin, formStatus: const InitialFormStatus()));
  }

  void _loginBiometric (LoginBiometric event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(username: event.username));
    if(event.isChange){
      if(event.biometricType == BiometricType.fingerprint){
        DiaLogManager.displayDialog(
            context,
            S.of(context).change_touch,
            S.of(context).change_touch_title, () async {
          Get.back();
        }, () {
        }, "", S.of(context).agree,dialogBiometric: true,biometricFaceID: false);
      }else if(event.biometricType == BiometricType.face){
        DiaLogManager.displayDialog(
            context,
            S.of(context).change_face,
            S.of(context).change_face_title, () async {
          Get.back();
        }, () {
        }, "", S.of(context).agree,dialogBiometric: true,biometricFaceID: true);
      }
    }else{
      String? password = await repository.getPassLogin(event.username, event.biometricType, event.context);
      if(password == null || password.isEmpty){
        // emitter(state.copyWith(
        //     formStatus: SubmissionFailed(
        //         "Khong the dang nhap ")));
      }else if(password == "${GetPasswordBiometricStatus.moreThan3}"){
        //final SharedPreferences prefs = await SharedPreferences.getInstance();
        (await SharedPrefs.instance()).setBool("${event.username}_${SharedPreferencesKey.isBiometricLogin}", false);
        //HoangLD neu nhap sai biometric qua 3 lan thi hien thi loi
        if(event.biometricType == BiometricType.fingerprint){
          emitter(state.copyWith(
              formStatus: SubmissionBiometricFailed(
                  S.of(event.context).error_title_fingerprint)));
        }else{
          emitter(state.copyWith(
              formStatus: SubmissionBiometricFailed(
                  S.of(event.context).error_title_face_id)));
        }
      }
      else{
        // if(await checkDisable()){
        add(LoginSubmitted(event.username, password,true, event.biometricType,event.isChange, event.context));
        // }else{
        //   if(event.biometricType == BiometricType.fingerprint){
        //     emitter(state.copyWith(
        //         formStatus: SubmissionBiometricFailed(
        //             S.of(event.context).fingerprint_error)));
        //   }else{
        //     emitter(state.copyWith(
        //         formStatus: SubmissionBiometricFailed(
        //             S.of(event.context).face_id_error)));
        //   }
        // }
      }
    }

  }
  //check trang thai moi doi password
  // static Future<bool> checkDisable() async{
  //   const storage = FlutterSecureStorage();
  //
  //   String? passwordOld = await storage.read(
  //       key: SharedPreferencesKey.passwordOld.toLowerCase(),
  //       aOptions: const AndroidOptions(
  //         encryptedSharedPreferences: true,),
  //       iOptions: IOSOptions(
  //           accountName: SharedPreferencesKey.passwordOld.toLowerCase(), accessibility: IOSAccessibility.unlocked));
  //   String? passwordNew = await storage.read(
  //       key: SharedPreferencesKey.passwordNew.toLowerCase(),
  //       aOptions: const AndroidOptions(
  //         encryptedSharedPreferences: true,),
  //       iOptions: IOSOptions(
  //           accountName: SharedPreferencesKey.passwordNew.toLowerCase(), accessibility: IOSAccessibility.unlocked));
  //   if(passwordOld==passwordNew)
  //     {
  //       return true;
  //     }else{
  //     return false;
  //   }
  // }
  // void _deleteAllSecureStorage(){
  //   const storage = FlutterSecureStorage();
  //   storage.deleteAll(
  //       aOptions: const AndroidOptions(
  //         encryptedSharedPreferences: true,),
  //       iOptions: IOSOptions(
  //           accountName: SharedPreferencesKey.passwordNew.toLowerCase(), accessibility: IOSAccessibility.unlocked));
  //   storage.deleteAll(
  //       aOptions: const AndroidOptions(
  //         encryptedSharedPreferences: true,),
  //       iOptions: IOSOptions(
  //           accountName: SharedPreferencesKey.passwordOld.toLowerCase(), accessibility: IOSAccessibility.unlocked));
  // }


  void _loginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emitter) async {
      emitter(state.copyWith(username: event.username, password: event.password, formStatus: FormSubmitting()));
      FocusManager.instance.primaryFocus?.unfocus();
    try {
      // if(!await checkDisable())
      //   {
      //     _deleteAllSecureStorage();
      //     final prefs = await SharedPreferences.getInstance();
      //     String uid = prefs.getString(SharedPreferencesKey.userName) ?? "-1";
      //     prefs.setString(uid.toLowerCase(),
      //         jsonEncode(SettingSharePref.toJson(false, false)));
      //   }
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      final reponse =
          await repository.loginWithPassword(state.username, state.password, state.isRememberLogin, context ,"");
      if (reponse.isOk) {
        if(reponse.status == 0)
          {

            emitter(state.copyWith(formStatus: SubmissionSuccess()));
            //HoangLD fix bug sau khi đăng nhập vẫn hiển thị snackbar đăng xuất
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //Bkav HoangLD khi đăng nhập thành công thì lưu trạng thái là đã có user từng đăng nhập
            (await SharedPrefs.instance()).setBool(SharedPreferencesKey.checkUsers, true);
            (await SharedPrefs.instance()).setBool("${event.username}_${SharedPreferencesKey.isBiometricLogin}", true);
            (await SharedPrefs.instance()).setString(SharedPreferencesKey.userNameUnit,event.username);
            if(event.isChange){
              if(Platform.isAndroid){
                Utils.resetBiometricAndroid();
              }
              //final prefs = await SharedPreferences.getInstance();
              String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
              (await SharedPrefs.instance()).setString(uid.toLowerCase(),
                  jsonEncode(SettingSharePref.toJson(false, false)));
            }
          }
      } else {
        if(reponse.status ==3){
          UnitUserInfo userInfo = UnitUserInfo.fromJson((reponse.object));
          emitter(state.copyWith(formStatus: SubmissionFailed("")));
          String unitGuid = await DiaLogManager.displaySelectUnit(state.username,event.context,userInfo.unitList??[]);
          if(unitGuid != ""){
            emitter(state.copyWith(username: event.username, password: event.password, formStatus: FormSubmitting()));
            final reponseUnit =
            await repository.loginWithPassword(state.username, state.password, state.isRememberLogin, context ,unitGuid);
            if (reponseUnit.isOk) {
              if(reponseUnit.status == 0)
              {
                //Bkav HoangLD fix bug BECM-572 do bug này em chưa có giải pháp tối ưu nhất do bug hơi dj ạ
                // emitter(state.copyWith(formStatus: SubmissionSuccess()));
                Navigator.of(event.context).pushAndRemoveUntil<void>(
                    await HomePage.route(), (route) => false);
                //HoangLD fix bug sau khi đăng nhập vẫn hiển thị snackbar đăng xuất
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //Bkav HoangLD khi đăng nhập thành công thì lưu trạng thái là đã có user từng đăng nhập
                (await SharedPrefs.instance()).setBool(SharedPreferencesKey.checkUsers, true);
                (await SharedPrefs.instance()).setString("${state.username}${SharedPreferencesKey.locationUnitUser}",unitGuid);
                (await SharedPrefs.instance()).setString(SharedPreferencesKey.userNameUnit,"${event.username}_$unitGuid");
                if(event.isChange){
                  if(Platform.isAndroid){
                    Utils.resetBiometricAndroid();
                  }
                  //final prefs = await SharedPreferences.getInstance();
                  String uid = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "-1";
                  (await SharedPrefs.instance()).setString(uid.toLowerCase(),
                      jsonEncode(SettingSharePref.toJson(false, false)));
                }
              }
            }else{
              emitter(state.copyWith(
                  formStatus: SubmissionFailed(
                      reponseUnit.object)));
            }
          }

        }else{
          emitter(state.copyWith(
              formStatus: SubmissionFailed(
                  reponse.object)));
          }
        }
    } catch (e) {
      emitter(state.copyWith(formStatus: SubmissionFailed(e.toString())));
    }
  }
}
List<UnitUserInfo> parseListContractsTo(String data) {
  final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
  return parsed
      .map<UnitUserInfo>((json) => UnitUserInfo.fromJson(json))
      .toList();
}
class LoginEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class NotClickBiometric extends LoginEvent {
  final BiometricType biometricType;
  final BuildContext context;

  NotClickBiometric(this.biometricType, this.context);
  @override
  List<Object?> get props => [biometricType,context];
}

class LoginUserNameChanged extends LoginEvent {
  final String userName;

  LoginUserNameChanged(this.userName);

  @override
  List<Object?> get props => [userName];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class RememberLoginChanged extends LoginEvent {
  final bool isRememberLogin;

  RememberLoginChanged(this.isRememberLogin);

  @override
  List<Object?> get props => [isRememberLogin];
}

/*class ClearTextInput extends LoginEvent {
  final bool isUserName;

  ClearTextInput(this.isUserName);

  @override
  List<Object?> get props => [isUserName];
}*/

class LoginSubmitted extends LoginEvent {
  //Bkav Nhungltk: lay thong tin dang nhap tu event
  final String username;
  final String password;
  final bool biometric;
  final BiometricType biometricType;
  final bool isChange;
  final BuildContext context;
  LoginSubmitted(this.username, this.password, this.biometric, this.biometricType, this.isChange, this.context);
}

class LoginBiometric extends LoginEvent {
  final String username;
  final BiometricType biometricType;
  final BuildContext context;
  final bool isChange;
  LoginBiometric(this.username, this.biometricType, this.context, this.isChange);
}

class EventFocusTextField extends LoginEvent {
  EventFocusTextField();
}


class LoginState extends BlocState {
  @override
  List<Object?> get props => [username, password, formStatus, isRememberLogin];

  final String username;

  String get isValidUsername => Validator.emailValidator(username);

  final String password;

  String get isValidPassword => Validator.passwordValidator(password);

  final FormSubmissionStatus formStatus;
  final bool isRememberLogin;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isRememberLogin = false
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isRemember
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      isRememberLogin: isRemember ?? isRememberLogin
    );
  }
}
