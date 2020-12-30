import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/models/nullable.dart';
import 'package:app/shared/repositories/user_repository.dart';
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
    if (event is SignupVerifyTokenEvent) {
      final token = event.token;
      try {
        final validToken = await userRepository.verifySignupToken(token: token);
        yield state.copyWith(
          verifiedToken: Nullable(token),
          firstName: validToken.firstName,
        );
      } catch (e) {
        yield state.copyWith(verifiedToken: Nullable(null));
      }
    }
    if (event is SignupSubmitEvent) {
      try {
        final authData = await userRepository.register(
          email: event.email,
          password: event.password,
          password2: event.password2,
          token: state.verifiedToken,
        );

        authenticationBloc.add(LoggedIn(authData: authData));

        event.onSuccess();
      } catch (e) {
        print(e);
      }
    }
  }
}
