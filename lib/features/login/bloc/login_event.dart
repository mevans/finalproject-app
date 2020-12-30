part of 'login_bloc.dart';

abstract class LoginEvent extends BlocEvent {
  LoginEvent([props]) : super(props: props);
}

class LoginSubmit extends LoginEvent {
  final String email;
  final String password;

  LoginSubmit(this.email, this.password) : super([email, password]);
}
