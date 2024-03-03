part of 'auth_bloc.dart';

class OnLogin extends BaseEvent {
  OnLogin({required this.authParams});
  final AuthParams authParams;
  @override
  List<Object> get props => [authParams];
}

class OnRegister extends BaseEvent {
  OnRegister({required this.email, required this.passw});
  final String email;
  final String passw;
  @override
  List<Object> get props => [email, passw];
}
