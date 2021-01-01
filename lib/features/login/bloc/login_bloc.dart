import 'dart:async';

import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Locator read;
  RootBloc rootBloc;
  UserRepository userRepository;

  LoginBloc({
    @required this.read,
  }) : super(LoginState.initial) {
    rootBloc = read<RootBloc>();
    userRepository = read<UserRepository>();
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmit) {
      yield state.copyWith(
        submitting: true,
      );
      try {
        final authData = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        rootBloc.add(AuthenticateEvent(authData));
      } catch (error) {} finally {
        yield state.copyWith(
          submitting: false,
        );
      }
    }
  }
}
