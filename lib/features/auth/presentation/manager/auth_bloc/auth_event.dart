part of 'auth_bloc.dart';

class OnLogin extends BaseEvent {
  OnLogin({required this.email, required this.passw});
  final String email;
  final String passw;
  @override
  List<Object> get props => [email, passw];
}

class OnRegister extends BaseEvent {
  OnRegister({required this.email, required this.passw});
  final String email;
  final String passw;
  @override
  List<Object> get props => [email, passw];
}
