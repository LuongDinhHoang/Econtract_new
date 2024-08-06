import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/repository.dart';
import 'package:e_contract/view_model/bloc_state.dart';

///Bkav DucLQ khi vao ung dung xe check cac trang thai xac thuc cua tai khoan de
class AuthenticationState extends BlocState {

  @override
  List<Object?> get props => [status, userInfo];

  final AuthenticationStatus status;
  final UserInfo? userInfo;

  AuthenticationState._({this.status = AuthenticationStatus.unknown, this.userInfo});

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(UserInfo userInfo) : this._(status: AuthenticationStatus.authenticated, userInfo: userInfo);

  AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

}

