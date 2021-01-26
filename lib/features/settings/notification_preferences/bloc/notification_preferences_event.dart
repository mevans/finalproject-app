part of 'notification_preferences_bloc.dart';

abstract class NotificationPreferencesEvent extends BlocEvent {
  NotificationPreferencesEvent([props]) : super(props: props);
}

class NotificationPreferencesEnterPageEvent
    extends NotificationPreferencesEvent {
  NotificationPreferencesEnterPageEvent() : super([]);
}

class NotificationPreferencesSaveEvent extends NotificationPreferencesEvent {
  NotificationPreferencesSaveEvent() : super([]);
}

class NotificationPreferencesToggleEvent extends NotificationPreferencesEvent {
  final int id;
  final bool enabled;

  NotificationPreferencesToggleEvent(
    this.id,
    this.enabled,
  ) : super([id, enabled]);
}

class NotificationPreferencesUpdateTime extends NotificationPreferencesEvent {
  final int id;
  final TimeOfDay time;

  NotificationPreferencesUpdateTime(
    this.id,
    this.time,
  ) : super([id, time]);
}
