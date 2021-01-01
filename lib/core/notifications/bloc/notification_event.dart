part of 'notification_bloc.dart';

abstract class NotificationEvent extends BlocEvent {
  NotificationEvent([props]) : super(props: props);
}

class NotificationInitialiseEvent extends NotificationEvent {}

class NotificationUninitialiseEvent extends NotificationEvent {}

class NotificationTokenRefreshEvent extends NotificationEvent {
  final String newToken;

  NotificationTokenRefreshEvent(this.newToken) : super([newToken]);
}
