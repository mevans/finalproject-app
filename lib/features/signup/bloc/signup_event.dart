part of 'signup_bloc.dart';

abstract class SignupEvent extends BlocEvent {
  SignupEvent([props]) : super(props: props);
}

class SignupVerifyCodeEvent extends SignupEvent {
  final String code;

  SignupVerifyCodeEvent(this.code) : super([code]);
}

class SignupSubmitEvent extends SignupEvent {
  final String email, password, password2;

  SignupSubmitEvent(
    this.email,
    this.password,
    this.password2,
  ) : super([email, password, password2]);
}
