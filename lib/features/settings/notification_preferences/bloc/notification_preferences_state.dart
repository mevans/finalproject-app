part of 'notification_preferences_bloc.dart';

class NotificationPreferencesState extends BlocState {
  final bool initialising;
  final List<VariableNotificationPreference> preferences;

  NotificationPreferencesState({
    this.initialising,
    this.preferences,
  }) : super([initialising, preferences]);

  static final initial = NotificationPreferencesState(
    initialising: true,
    preferences: [],
  );

  @override
  copyWith({
    bool initialising,
    List<VariableNotificationPreference> preferences,
  }) {
    return NotificationPreferencesState(
      initialising: initialising ?? this.initialising,
      preferences: preferences ?? this.preferences,
    );
  }
}
