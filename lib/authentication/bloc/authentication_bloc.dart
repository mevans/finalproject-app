import 'dart:async';

import 'package:app/models/auth_data.dart';
import 'package:app/models/bloc_event.dart';
import 'package:app/models/bloc_state.dart';
import 'package:app/models/nullable.dart';
import 'package:app/models/patient.dart';
import 'package:app/repositories/token_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:meta/meta.dart';

import '../authentication_interceptor.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final TokenRepository tokenRepository;
  final UserRepository userRepository;
  final AuthenticationInterceptor authenticationInterceptor;
  final GlobalKey<NavigatorState> navigator;

  AuthenticationBloc({
    @required this.userRepository,
    @required this.tokenRepository,
    @required this.authenticationInterceptor,
    @required this.navigator,
  }) : super(AuthenticationState.initial) {
    this.authenticationInterceptor.initialise(this);
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final authData = await tokenRepository.read();

      if (authData.access != null && authData.refresh != null) {
        yield state.copyWith(
          authData: Nullable(authData),
          status: AuthenticationStatus.authenticated,
        );
      } else {
        yield state.copyWith(
          authData: Nullable(null),
          status: AuthenticationStatus.unauthenticated,
          initialising: false,
        );
      }
    }

    if (event is LoggedIn) {
      await tokenRepository.write(event.authData);
      yield state.copyWith(
        authData: Nullable(event.authData),
        status: AuthenticationStatus.authenticated,
      );
    }

    if (event is LoggedOut || event is RefreshTokenFailure) {
      await tokenRepository.delete();
      yield state.copyWith(
        authData: Nullable(null),
        user: Nullable(null),
        status: AuthenticationStatus.unauthenticated,
      );
    }

    if (event is GetUser) {
      final user = await userRepository.getUser();
      yield state.copyWith(
        user: Nullable(user),
        initialising: false,
      );
    }

    if (event is RefreshTokenSuccess) {
      final refreshedData = AuthData(
        access: event.access,
        refresh: state.authData.refresh,
      );
      await tokenRepository.write(refreshedData);
      yield state.copyWith(
        authData: Nullable(refreshedData),
      );
    }
  }

  @override
  void onTransition(
      Transition<AuthenticationEvent, AuthenticationState> transition) {
    if (transition.currentState.status != AuthenticationStatus.authenticated &&
        transition.nextState.status == AuthenticationStatus.authenticated) {
      add(GetUser());
      navigator.currentState
          .pushNamedAndRemoveUntil('/report', (route) => false);
    }
    if (transition.currentState.status != AuthenticationStatus.unauthenticated &&
        transition.nextState.status == AuthenticationStatus.unauthenticated) {
      navigator.currentState
          .pushNamedAndRemoveUntil('/login', (route) => false);
    }
    super.onTransition(transition);
  }
}
