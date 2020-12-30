part of 'login_bloc.dart';

class LoginState extends BlocState<LoginState> {
  final bool submitting;
  final bool passwordVisible;

  LoginState({
    @required this.submitting,
    @required this.passwordVisible,
  }) : super([submitting, passwordVisible]);

  static final initial = LoginState(
    submitting: false,
    passwordVisible: false,
  );

  LoginState copyWith({
    bool submitting,
    bool passwordVisible,
  }) =>
      LoginState(
        submitting: submitting ?? this.submitting,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
