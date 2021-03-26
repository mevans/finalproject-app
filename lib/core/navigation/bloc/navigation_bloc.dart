import 'dart:async';

import 'package:tracker/core/navigation/constants/routes.dart';
import 'package:tracker/core/root_bloc/root_bloc.dart';
import 'package:tracker/shared/models/bloc_event.dart';
import 'package:tracker/shared/models/bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final Locator read;
  final GlobalKey<NavigatorState> navigator;
  RootBloc rootBloc;

  NavigationBloc({
    @required this.read,
    @required this.navigator,
  }) : super(NavigationState.initial) {
    rootBloc = read<RootBloc>();

    rootBloc.registerRootEvent(NavigationToRoot, this);
    rootBloc.registerRootEvent(NavigationPush, this);
    rootBloc.registerRootEvent(NavigationPop, this);

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
      navigator.currentState.pushNamed(event.route, arguments: event.data);
    }
    if (event is NavigationPop) {
      navigator.currentState.pop(event.result);
    }
  }
}
