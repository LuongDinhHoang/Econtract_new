import 'dart:async';

import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/view_model/account/authentication/authentication_event.dart';
import 'package:e_contract/view_model/account/authentication/authentication_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required Repository repository})
      : _repository = repository,
        super(AuthenticationState.unknown()) {
    // Dang ky de xu ly cac event, khi nhan event thi goi ham de xu ly
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    // Thuc hien xu ly de lang nghe status luon ngay khi vao app, sau khi nhan duoc
    // status tu repository thi emit event AuthenticationStatusChanged voi data = status
    _authenticationStatusSubscription = _repository.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }

  final Repository _repository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        final userInfo = await _getUserinfo();
        return emit(userInfo != null
            ? AuthenticationState.authenticated(userInfo)
            : AuthenticationState.unauthenticated());
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated());
      default:
        return emit(AuthenticationState.unknown());
    }
  }

  @override
  Future<void> close() {
    //Huy dang ky steam
    _authenticationStatusSubscription.cancel();
    _repository.dispose();
    return super.close();
  }

  Future<UserInfo?> _getUserinfo() async {
    try {
      return _repository.getUserInfo();
    } catch (_) {
      return null;
    }
  }
}
