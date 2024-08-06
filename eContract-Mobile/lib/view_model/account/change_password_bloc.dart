import 'dart:async';
import 'dart:convert';

import 'package:e_contract/data/entity/change_password_info.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/generated/l10n.dart';
import 'package:e_contract/utils/change_password_status.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:e_contract/utils/validator.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final Repository repository;


  ForgetPasswordBloc(
      {required this.repository})
      : super(ForgetPasswordState()) {
    on<SubmissionChangePassword>(_submissionChangePassword);
    on<ValidatePassNew>(_validatePass);
    on<Logout>(_logout);
  }

  void _submissionChangePassword(
      SubmissionChangePassword event, Emitter<ForgetPasswordState> emit) async {
    ChangePasswordInfo changePasswordInfo = await repository.changePassword(event.passwordOld, event.passwordNew);
    if(changePasswordInfo.isOk)
      {
        // repository.savePassLogin(SharedPreferencesKey.passwordOld.toLowerCase(), event.passwordOld);
        // repository.savePassLogin(SharedPreferencesKey.passwordNew.toLowerCase(), event.passwordNew);

        // xoa cache mat khau cua username hien tai
        //final pref = await SharedPreferences.getInstance();
        String userName = (await SharedPrefs.instance()).getString(SharedPreferencesKey.userName) ?? "";
        repository.removePassLogin(userName);
        // reset lai cai dat faceId, touch id = false
        (await SharedPrefs.instance()).setString(userName.toLowerCase(),
            jsonEncode(SettingSharePref.toJson(false, false)));
      }
    emit(state.copyWith(
        formStatus: changePasswordInfo.isOk
            ? ChangePasswordSuccess()
            : ChangePasswordFailed(changePasswordInfo.reasonError)));
  }

  FutureOr<void> _validatePass(
      ValidatePassNew event, Emitter<ForgetPasswordState> emit) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String errorPassNew = "";
    String errorConfirmPassNew = "";
    if (event.passNew == event.passCurrent) {
      errorPassNew = S.of(event.context).pass_duplicate;
    }
    if (Validator.validateFormatPass(event.passNew) == false) {
      if (Validator.validateFormatPass(event.passNew) == false) {
        if (Validator.validatePassLength(event.passNew) == false) {
          errorPassNew = S.of(event.context).error_pass_length;
        } else if (event.passNew
                .contains((await SharedPrefs.instance()).getString(SharedPreferencesKey.userName)!) ==
            true) {
          errorPassNew = S.of(event.context).error_pass_contain_space_info;
        } else {
          errorPassNew = S.of(event.context).pass_format_wrong;
        }
      }
    }
    if (event.passNewConfirm.isNotEmpty && event.passNewConfirm != event.passNew) {
      errorConfirmPassNew = S.of(event.context).pass_not_same_new_pass;
    }
    emit(state.copyWith(
          formStatus: ValidatePassFail("", errorPassNew, errorConfirmPassNew)));
    if (errorPassNew == "" && errorConfirmPassNew == "" && event.submit==true && event.passNewConfirm.isNotEmpty) {
        add(SubmissionChangePassword(event.passCurrent, event.passNew));
    }

  }

  FutureOr<void> _logout(
      Logout event, Emitter<ForgetPasswordState> emit) async {
    await repository.logout();
  }
}

class ForgetPasswordEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class SubmissionChangePassword extends ForgetPasswordEvent {
  final String passwordOld;
  final String passwordNew;

  SubmissionChangePassword(this.passwordOld, this.passwordNew);

  @override
  List<Object?> get props => [];
}

class Logout extends ForgetPasswordEvent {}

class ValidatePassNew extends ForgetPasswordEvent {
  final String passCurrent;
  final String passNew;
  final String passNewConfirm;
  final bool submit;
  BuildContext context;

  ValidatePassNew(
      {required this.passCurrent,
      required this.passNew,
      required this.passNewConfirm,
        this.submit= false,
      required this.context});

  @override
  List<Object?> get props => [];
}

class ForgetPasswordState extends BlocState {
  @override
  List<Object?> get props => [formStatus];

  final FormChangePasswordStatus formStatus;

  ForgetPasswordState({this.formStatus = const ChangeFormStatus()});

  ForgetPasswordState copyWith({
    FormChangePasswordStatus? formStatus,
  }) {
    return ForgetPasswordState(formStatus: formStatus ?? this.formStatus);
  }
}
