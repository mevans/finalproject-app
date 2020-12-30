part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  List<Object> get props => [];
}

class SignupChangeEvent extends SignupEvent {
  final String token, email, password, password2;

  SignupChangeEvent({
    this.token,
    this.email,
    this.password,
    this.password2,
  });

  List<Object> get props => [token, email, password, password2];
}

class SignupVerifyTokenEvent extends SignupEvent {}

class SignupSubmitEvent extends SignupEvent {
  final VoidCallback onSuccess;

  SignupSubmitEvent(this.onSuccess);

  List<Object> get props => [onSuccess];
}
