part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool submitting;
  final bool passwordVisible;

  const LoginState({
    @required this.submitting,
    @required this.passwordVisible,
  });

  @override
  List<Object> get props => [submitting, passwordVisible];

  static const initial = LoginState(
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
