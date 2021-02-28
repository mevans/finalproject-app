import 'dart:async';

import 'package:app/core/notifications/token_interceptor.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/models/nullable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final Locator read;
  RootBloc rootBloc;
  TokenInterceptor tokenInterceptor;

  final List<StreamSubscription> notificationSubscriptions = [];

  NotificationBloc({
    @required this.read,
  }) : super(NotificationState.initial) {
    rootBloc = read<RootBloc>();
    tokenInterceptor = read<TokenInterceptor>();

    rootBloc.addEventListener(
        AuthenticatedEvent, (e) => add(NotificationInitialiseEvent()));
    rootBloc.addEventListener(
        UnauthenticatedEvent, (e) => add(NotificationUninitialiseEvent()));

    tokenInterceptor.initialise(this);
  }

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NotificationInitialiseEvent) {
      yield state.copyWith(
        initialised: false,
        active: false,
        token: Nullable(null),
      );
      final permissionSettings =
          await FirebaseMessaging.instance.requestPermission();
      if (permissionSettings.authorizationStatus == AuthorizationStatus.denied)
        return;

      final token = await FirebaseMessaging.instance.getToken();
      notificationSubscriptions.add(
        FirebaseMessaging.instance.onTokenRefresh.skip(1).listen(
              (newToken) => add(NotificationTokenRefreshEvent(newToken)),
            ),
      );

      notificationSubscriptions.add(FirebaseMessaging.onMessage
          .listen((message) => print("Normal message: $message")));
      notificationSubscriptions.add(FirebaseMessaging.onMessageOpenedApp
          .listen((message) => print("Message opened app: $message")));

      yield state.copyWith(
        initialised: true,
        active: true,
        token: Nullable(token),
      );
    }
    if (event is NotificationUninitialiseEvent) {
      await Future.wait(notificationSubscriptions.map((s) => s.cancel()));
      await FirebaseMessaging.instance.deleteToken();
      yield state.copyWith(
        initialised: true,
        active: false,
        token: Nullable(null),
      );
    }
    if (event is NotificationTokenRefreshEvent) {
      yield state.copyWith(
        token: Nullable(event.newToken),
      );
    }
  }
}
