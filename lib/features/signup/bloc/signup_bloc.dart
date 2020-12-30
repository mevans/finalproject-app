import 'package:app/authentication/authentication_bloc.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SignupBloc({
    this.userRepository,
    this.authenticationBloc,
  }) : super(SignupState.initial);

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupChangeEvent) {
      yield state.copyWith(
        token: event.token,
        email: event.email,
        password: event.password,
        password2: event.password2,
      );
    }
    if (event is SignupVerifyTokenEvent) {
      final token = state.token;
      try {
        await userRepository.verifySignupToken(token: token);
        yield state.copyWith(tokenVerified: true);
      } catch (e) {
        yield state.copyWith(tokenInvalid: true);
      }
    }
    if (event is SignupSubmitEvent) {
      try {
        final authData = await userRepository.register(email: state.email, password: state.password, password2: state.password2, token: state.token);

        authenticationBloc.add(LoggedIn(authData: authData));

        event.onSuccess();
      } catch (e) {
        print(e);
      }
    }
  }
}
