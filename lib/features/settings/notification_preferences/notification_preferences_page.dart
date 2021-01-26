import 'package:app/features/settings/notification_preferences/bloc/notification_preferences_bloc.dart';
import 'package:app/shared/models/variable_notification_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rrule/rrule.dart';

class NotificationPreferencesPage extends StatefulWidget {
  @override
  _NotificationPreferencesPageState createState() =>
      _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState
    extends State<NotificationPreferencesPage> {
  NotificationPreferencesBloc _notificationPreferencesBloc;

  @override
  void initState() {
    _notificationPreferencesBloc = NotificationPreferencesBloc(
      read: context.read,
    );
    _notificationPreferencesBloc.add(NotificationPreferencesEnterPageEvent());
    super.initState();
  }

  void handlePreferenceTimeChange(
    VariableNotificationPreference preference,
  ) async {
    final time =
        await showTimePicker(context: context, initialTime: preference.time);
    if (time == null) return;
    _notificationPreferencesBloc.add(NotificationPreferencesUpdateTime(
      preference.id,
      time,
    ));
  }

  String getSubtitle(VariableNotificationPreference preference) {
    return "${preference.time.format(context)} (${preference.instance.schedule.toText(l10n: context.read<RruleL10nEn>())})";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationPreferencesBloc,
        NotificationPreferencesState>(
      cubit: _notificationPreferencesBloc,
      builder: (ctx, state) => Scaffold(
        appBar: AppBar(
          title: Text("Notification Preferences"),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => _notificationPreferencesBloc
                  .add(NotificationPreferencesSaveEvent()),
            )
          ],
        ),
        body: state.initialising
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (ctx, index) {
                  final preference = state.preferences[index];
                  return ListTile(
                    title: Text(preference.instance.variable.name),
                    subtitle: preference.enabled
                        ? Text(getSubtitle(preference))
                        : null,
                    trailing: Switch(
                      value: preference.enabled,
                      onChanged: (enabled) => _notificationPreferencesBloc.add(
                        NotificationPreferencesToggleEvent(
                            preference.id, enabled),
                      ),
                    ),
                    onTap: preference.enabled
                        ? () => handlePreferenceTimeChange(preference)
                        : null,
                  );
                },
                itemCount: state.preferences.length,
                separatorBuilder: (ctx, index) => Divider(),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _notificationPreferencesBloc.close();
    super.dispose();
  }
}
