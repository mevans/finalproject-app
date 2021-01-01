part of 'root_bloc.dart';

abstract class RootEvent {}

class AuthenticatedEvent extends RootEvent {}

class UnauthenticatedEvent extends RootEvent {}
