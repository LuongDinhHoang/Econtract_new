
import 'package:e_contract/data/entity/user_info.dart';
import 'package:e_contract/data/local_data/contract_db.dart';
import 'package:e_contract/view_model/bloc_event.dart';
import 'package:e_contract/view_model/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Bkav HoangLD Bloc chọn các tài khoản đã đăng nhập
class LoginUsersBloc extends Bloc<LoginUsersEvent, LoginUsersState> {
  LoginUsersBloc() : super(LoginUsersState()) {
    on<StartLoginUsers>(_startLoginUsers);
    add(StartLoginUsers());

  }
  void _startLoginUsers(
      StartLoginUsers event, Emitter<LoginUsersState> emit) async {
    List<UserInfo> list = await EContractDb.instance.allUserEntries;
    emit(state.copyWith(list));
  }
}
class StartLoginUsers extends LoginUsersEvent {}

class LoginUsersEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}
class LoginUsersState extends BlocState {
  final List<UserInfo> usersList;


  LoginUsersState({this.usersList=const []});

LoginUsersState copyWith(List<UserInfo> list) {
    return LoginUsersState(
      usersList: list
    );
  }
  @override
  List<Object?> get props => [usersList];
}
