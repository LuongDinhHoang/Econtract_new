import 'dart:io';

import 'package:e_contract/data/repository.dart';
import 'package:e_contract/utils/constants/shared_preferences_key.dart';
import 'package:e_contract/utils/form_submission_status.dart';
import 'package:e_contract/utils/preference_utils.dart';
import 'package:e_contract/utils/widgets/dialog_manager.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

///HoangLD bloc cho setting
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final Repository repository;
  final bool showFace;
  final bool showFigure;

  SettingBloc(
      {required this.repository,
      required this.showFigure,
      required this.showFace})
      : super(SettingState()) {
    on<FingerprintLoginChanged>(_fingerprintLoginChanged);
    on<FaceIDLoginChanged>(_facIDintLoginChanged);
    on<CheckFormLogin>(_checkFormLogin);
    on<LogoutEvent>(_logout);

    add(FaceIDLoginChanged(showFace));
    add(FingerprintLoginChanged(showFigure));
  }

  void _fingerprintLoginChanged(
      FingerprintLoginChanged event, Emitter<SettingState> emit) {
    emit(state.copyWith(
        isFingerprint: event.isFingerprintLogin,
        formStatus: const InitialFormStatus()));
  }

  void _checkFormLogin(CheckFormLogin event, Emitter<SettingState> emit) async {
    if (event.biometricType == BiometricType.face) {
    } else if (event.biometricType == BiometricType.fingerprint) {
      if(Platform.isAndroid)
        {
          DiaLogManager.displayLoadingFiDialog(event.context);
        }
    }
  }

  void _facIDintLoginChanged(
      FaceIDLoginChanged event, Emitter<SettingState> emit) {
    emit(state.copyWith(
        isFaceID: event.isFaceIDLogin, formStatus: const InitialFormStatus()));
  }

  void _logout(LogoutEvent event, Emitter<SettingState> emit) async {
    // chuyen màn hình trước r mới đăng xuất - luôn luôn đăng xuất
    emit(state.copyWith(
        isFaceID: showFace,
        isFingerprint: showFigure,
        formStatus: SubmissionSuccess()));
    await repository.logout();
    //Bkav HoangLD logout thì xoá tokenHSM
    //final pref = await SharedPreferences.getInstance();
    var tokenHSM = (await SharedPrefs.instance()).getString(SharedPreferencesKey.tokenHSM);
    if(tokenHSM != null){
      (await SharedPrefs.instance()).setString(SharedPreferencesKey.tokenHSM,"");
    }

  }
}

class SettingEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class FingerprintLoginChanged extends SettingEvent {
  final bool isFingerprintLogin;

  FingerprintLoginChanged(this.isFingerprintLogin);

  @override
  List<Object?> get props => [isFingerprintLogin];
}

class CheckFormLogin extends SettingEvent {
  final BiometricType biometricType;
  final BuildContext context;

  CheckFormLogin(this.biometricType,this.context);

  @override
  List<Object?> get props => [biometricType,context];
}

class FaceIDLoginChanged extends SettingEvent {
  final bool isFaceIDLogin;

  FaceIDLoginChanged(this.isFaceIDLogin);

  @override
  List<Object?> get props => [isFaceIDLogin];
}

class LogoutEvent extends SettingEvent {
  LogoutEvent();

  @override
  List<Object?> get props => [];
}

class SettingState extends BlocState {
  @override
  List<Object?> get props => [isFingerprintLogin, isFaceIDLogin, formStatus];

  final bool isFingerprintLogin;
  final bool isFaceIDLogin;
  final FormSubmissionStatus formStatus;

  SettingState({
    this.isFingerprintLogin = false,
    this.isFaceIDLogin = false,
    this.formStatus = const InitialFormStatus(),
  });

  SettingState copyWith({
    bool? isFingerprint,
    bool? isFaceID,
    FormSubmissionStatus? formStatus,
  }) {
    return SettingState(
        isFingerprintLogin: isFingerprint ?? isFingerprintLogin,
        isFaceIDLogin: isFaceID ?? isFaceIDLogin,
        formStatus: formStatus ?? this.formStatus);
  }
}
