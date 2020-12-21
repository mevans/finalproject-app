part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthData authData;
  final Patient user;
  final bool initialising;

  const AuthenticationState({
    @required this.authData,
    @required this.status,
    @required this.user,
    @required this.initialising,
  });

  @override
  List<Object> get props => [status, authData, user];

  static const initial = AuthenticationState(
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
        initialising: initialising == null ? this.initialising : initialising,
      );
}
