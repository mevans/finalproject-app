part of 'root_bloc.dart';

abstract class RootEvent extends BlocEvent {
  RootEvent([props]) : super(props: props);
}

class AuthenticatedEvent extends RootEvent {}

class UnauthenticatedEvent extends RootEvent {}

class LoggedInEvent extends RootEvent {
  final AuthData authData;

  LoggedInEvent(this.authData) : super([authData]);
}
