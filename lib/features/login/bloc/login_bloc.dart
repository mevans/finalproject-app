import 'dart:async';

import 'package:app/authentication/bloc/authentication_bloc.dart';
import 'package:app/models/bloc_event.dart';
import 'package:app/models/bloc_state.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    this.userRepository,
    this.authenticationBloc,
  }) : super(LoginState.initial);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield state.copyWith(
        submitting: true,
      );
      try {
        final authData = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(authData: authData));
      } catch (error) {} finally {
        yield state.copyWith(
          submitting: false,
        );
      }
    }

    if (event is LoginTogglePasswordVisibility) {
      yield state.copyWith(
        passwordVisible: !state.passwordVisible,
      );
    }
  }
}
