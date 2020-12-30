part of 'signup_bloc.dart';

abstract class SignupEvent extends BlocEvent {
  SignupEvent([props]) : super(props: props);
}

class SignupVerifyTokenEvent extends SignupEvent {
  final String token;

  SignupVerifyTokenEvent(this.token) : super([token]);
}

class SignupSubmitEvent extends SignupEvent {
  final String email, password, password2;
  final VoidCallback onSuccess;

  SignupSubmitEvent(
    this.email,
    this.password,
    this.password2,
    this.onSuccess,
  ) : super([email, password, password2, onSuccess]);
}
