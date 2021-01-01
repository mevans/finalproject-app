import 'dart:async';

import 'package:app/core/navigation/constants/routes.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final RootBloc rootBloc;
  final GlobalKey<NavigatorState> navigator;

  NavigationBloc({
    this.rootBloc,
    this.navigator,
  }) : super(NavigationState.initial) {
    rootBloc.addEventListener(
        AuthenticatedEvent, (e) => add(NavigationToRoot(Routes.report)));
    rootBloc.addEventListener(
        UnauthenticatedEvent, (e) => add(NavigationToRoot(Routes.login)));
  }

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    yield state.copyWith(
      navigationId: state.navigationId + 1,
    );
  }

  @override
  void onEvent(NavigationEvent event) {
    super.onEvent(event);
    if (event is NavigationToRoot) {
      navigator.currentState.pushNamedAndRemoveUntil(
        event.route,
        (route) => false,
      );
    }
    if (event is NavigationPush) {
      navigator.currentState.pushNamed(event.route);
    }
    if (event is NavigationPop) {
      navigator.currentState.pop(event.result);
    }
  }
}
