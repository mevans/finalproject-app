part of 'authentication_bloc.dart';

class AuthenticationState extends BlocState {
  final AuthenticationStatus status;
  final AuthData authData;
  final Patient user;
  final bool initialising;
  final UserPreferences preferences;

  AuthenticationState({
    @required this.authData,
    @required this.status,
    @required this.user,
    @required this.initialising,
    @required this.preferences,
  }) : super([status, authData, user, initialising, preferences]);

  static final initial = AuthenticationState(
    authData: null,
    status: AuthenticationStatus.initial,
    user: null,
    initialising: true,
    preferences: null,
  );

  AuthenticationState copyWith({
    AuthenticationStatus status,
    Nullable<AuthData> authData,
    Nullable<Patient> user,
    bool initialising,
    Nullable<UserPreferences> preferences,
  }) =>
      AuthenticationState(
        status: status ?? this.status,
        authData: authData == null ? this.authData : authData.value,
        user: user == null ? this.user : user.value,
        initialising: initialising ?? this.initialising,
        preferences: preferences == null ? this.preferences : preferences.value,
      );
}
