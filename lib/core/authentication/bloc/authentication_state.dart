part of 'authentication_bloc.dart';

class AuthenticationState extends BlocState {
  final AuthenticationStatus status;
  final AuthData authData;
  final Patient user;
  final bool initialising;

  AuthenticationState({
    @required this.authData,
    @required this.status,
    @required this.user,
    @required this.initialising,
  }) : super([status, authData, user, initialising]);

  static final initial = AuthenticationState(
    authData: null,
    status: AuthenticationStatus.initial,
    user: null,
    initialising: true,
  );

  AuthenticationState copyWith({
    AuthenticationStatus status,
    Nullable<AuthData> authData,
    Nullable<Patient> user,
    bool initialising,
  }) =>
      AuthenticationState(
        status: status ?? this.status,
        authData: authData == null ? this.authData : authData.value,
        user: user == null ? this.user : user.value,
        initialising: initialising ?? this.initialising,
      );
}
