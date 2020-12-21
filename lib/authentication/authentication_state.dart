part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthData authData;
  final Patient user;

  const AuthenticationState({
    @required this.authData,
    @required this.status,
    @required this.user,
  });

  @override
  List<Object> get props => [status, authData, user];

  static const initial = AuthenticationState(
    authData: null,
    status: AuthenticationStatus.initial,
    user: null,
  );

  AuthenticationState copyWith({
    AuthenticationStatus status,
    Nullable<AuthData> authData,
    Nullable<Patient> user,
  }) =>
      AuthenticationState(
        status: status ?? this.status,
        authData: authData == null ? this.authData : authData.value,
        user: user == null ? this.user : user.value,
      );
}
