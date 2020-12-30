part of 'login_bloc.dart';

class LoginState extends BlocState<LoginState> {
  final bool submitting;

  LoginState({
    @required this.submitting,
  }) : super([submitting]);

  static final initial = LoginState(
    submitting: false,
  );

  LoginState copyWith({
    bool submitting,
  }) =>
      LoginState(
        submitting: submitting ?? this.submitting,
      );
}
