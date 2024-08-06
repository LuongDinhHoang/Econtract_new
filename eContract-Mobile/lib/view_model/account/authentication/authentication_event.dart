import 'package:e_contract/data/repository.dart';
import 'package:e_contract/view_model/bloc_event.dart';

///
class AuthenticationEvent extends BlocEvent {

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {

  final AuthenticationStatus status;

  AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}





