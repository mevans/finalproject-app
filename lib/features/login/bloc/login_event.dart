part of 'login_bloc.dart';

abstract class LoginEvent extends BlocEvent {
  LoginEvent([props]) : super(props: props);
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    this.email,
    this.password,
  }) : super([email, password]);
}

class LoginTogglePasswordVisibility extends LoginEvent {}
