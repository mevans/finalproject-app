import 'dart:async';

import 'package:app/core/navigation/bloc/navigation_bloc.dart';
import 'package:app/core/navigation/constants/routes.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/core/snackbar/bloc/snackbar_bloc.dart';
import 'package:app/shared/models/auth_data.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/models/nullable.dart';
import 'package:app/shared/models/patient.dart';
import 'package:app/shared/models/user_preferences.dart';
import 'package:app/shared/models/user_theme.enum.dart';
import 'package:app/shared/repositories/token_repository.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:app/shared/services/dynamic_link_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../authentication_interceptor.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Locator read;
  RootBloc rootBloc;
  TokenRepository tokenRepository;
  UserRepository userRepository;
  AuthenticationInterceptor authenticationInterceptor;
  DynamicLinkService dynamicLinkService;

  AuthenticationBloc({
    @required this.read,
  }) : super(AuthenticationState.initial) {
    rootBloc = read<RootBloc>();
    tokenRepository = read<TokenRepository>();
    userRepository = read<UserRepository>();
    authenticationInterceptor = read<AuthenticationInterceptor>();
    dynamicLinkService = read<DynamicLinkService>();

    this.authenticationInterceptor.initialise(this);
    this.rootBloc.registerRootEvent(AuthenticateEvent, this);
    this.dynamicLinkService.initialise((uri) => this.add(OpenDynamicLink(uri)));
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

    if (event is AuthenticateEvent) {
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
      final userData = await Future.wait([
        userRepository.getUser(),
        userRepository.getPreferences(),
      ]);
      yield state.copyWith(
        user: Nullable(userData[0]),
        preferences: Nullable(userData[1]),
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

    if (event is OpenDynamicLink) {
      if (state.status == AuthenticationStatus.authenticated) {
        this.rootBloc.add(ShowErrorSnackbar(
            "Cannot accept invite as you're already authenticated"));
      } else {
        final token = event.uri.queryParameters['token'];
        try {
          final invite = await userRepository.verifyInviteToken(token: token);
          this.rootBloc.add(NavigationPush(Routes.signup, data: invite));
        } catch (e) {
          this
              .rootBloc
              .add(ShowErrorSnackbar("Invalid invite. It may have expired."));
        }
      }
    }

    if (event is ToggleTheme) {
      final preferencesUpdate = state.preferences.copyWith(
        userTheme: state.preferences.userTheme == UserTheme.LIGHT
            ? UserTheme.DARK
            : UserTheme.LIGHT,
      );
      yield state.copyWith(
        preferences: Nullable(preferencesUpdate),
      );
      await userRepository.updatePreferences(preferencesUpdate);
    }
  }

  @override
  void onTransition(
    Transition<AuthenticationEvent, AuthenticationState> transition,
  ) {
    super.onTransition(transition);
    if (statusTransitions(transition, AuthenticationStatus.authenticated)) {
      add(GetUser());
      rootBloc.add(AuthenticatedEvent());
    }
    if (statusTransitions(transition, AuthenticationStatus.unauthenticated)) {
      rootBloc.add(UnauthenticatedEvent());
    }
    if (transition.currentState.user == null &&
        transition.nextState.user != null) {
      rootBloc.add(PatientAuthenticatedEvent(transition.nextState.user));
    }
  }

  bool statusTransitions(
    Transition<AuthenticationEvent, AuthenticationState> transition,
    AuthenticationStatus status,
  ) {
    return transition.currentState.status != status &&
        transition.nextState.status == status;
  }
}
