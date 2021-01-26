import 'package:app/core/navigation/bloc/navigation_bloc.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/core/snackbar/bloc/snackbar_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/models/variable_notification_preference.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part 'notification_preferences_event.dart';

part 'notification_preferences_state.dart';

class NotificationPreferencesBloc
    extends Bloc<NotificationPreferencesEvent, NotificationPreferencesState> {
  final Locator read;
  UserRepository userRepository;
  RootBloc rootBloc;

  NotificationPreferencesBloc({
    @required this.read,
  }) : super(NotificationPreferencesState.initial) {
    userRepository = read<UserRepository>();
    rootBloc = read<RootBloc>();
  }

  @override
  Stream<NotificationPreferencesState> mapEventToState(
      NotificationPreferencesEvent event) async* {
    if (event is NotificationPreferencesEnterPageEvent) {
      final preferences =
          await this.userRepository.getNotificationPreferences();
      yield state.copyWith(
        initialising: false,
        preferences: preferences,
      );
    }
    if (event is NotificationPreferencesToggleEvent) {
      final preferences = [...state.preferences];
      final index = preferences.indexWhere((p) => p.id == event.id);
      final preference = preferences[index];
      preferences[index] = VariableNotificationPreference(
        enabled: event.enabled,
        id: preference.id,
        instance: preference.instance,
        time: preference.time,
      );
      yield state.copyWith(
        preferences: preferences,
      );
    }
    if (event is NotificationPreferencesUpdateTime) {
      final preferences = [...state.preferences];
      final index = preferences.indexWhere((p) => p.id == event.id);
      final preference = preferences[index];
      preferences[index] = VariableNotificationPreference(
        enabled: preference.enabled,
        id: preference.id,
        instance: preference.instance,
        time: event.time,
      );
      yield state.copyWith(
        preferences: preferences,
      );
    }
    if (event is NotificationPreferencesSaveEvent) {
      await userRepository.updateNotificationPreferences(state.preferences);
      rootBloc.add(NavigationPop());
      rootBloc.add(ShowInfoSnackbar("Preferences Saved"));
    }
    yield state;
  }
}
