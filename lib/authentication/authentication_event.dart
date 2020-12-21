part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final AuthData authData;

  LoggedIn({@required this.authData});

  @override
  List<Object> get props => [authData];
}

class LoggedOut extends AuthenticationEvent {}

class GetUser extends AuthenticationEvent {}

class RefreshTokenSuccess extends AuthenticationEvent {
  final String access;

  RefreshTokenSuccess({@required this.access});

  @override
  List<Object> get props => [access];
}

class RefreshTokenFailure extends AuthenticationEvent {}
