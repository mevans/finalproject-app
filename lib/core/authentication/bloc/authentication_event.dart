part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends BlocEvent {
  AuthenticationEvent([props]) : super(props: props);
}

class AppStarted extends AuthenticationEvent {}

class AuthenticateEvent extends AuthenticationEvent {
  final AuthData authData;

  AuthenticateEvent(this.authData) : super([authData]);
}

class LoggedOut extends AuthenticationEvent {}

class GetUser extends AuthenticationEvent {}

class RefreshTokenSuccess extends AuthenticationEvent {
  final String access;

  RefreshTokenSuccess({@required this.access}) : super([access]);
}

class RefreshTokenFailure extends AuthenticationEvent {}
