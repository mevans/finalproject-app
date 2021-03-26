import 'package:tracker/core/authentication/bloc/authentication_bloc.dart';
import 'package:tracker/core/navigation/bloc/navigation_bloc.dart';
import 'package:tracker/core/navigation/constants/routes.dart';
import 'package:tracker/shared/models/user_theme.enum.dart';
import 'package:tracker/shared/services/alert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthenticationBloc _authenticationBloc;
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    _authenticationBloc = context.read<AuthenticationBloc>();
    _navigationBloc = context.read<NavigationBloc>();
    super.initState();
  }

  _onLogout() async {
    final confirm = await context.read<AlertService>().confirmation(
          context,
          confirmText: "Logout",
          text:
              "Are you sure you want to log out? You will stop receiving notifications.",
        );
    if (!confirm) return;
    _authenticationBloc.add(LoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => ListView(
          children: [
            ListTile(
              title: Text("${state.user.firstName} ${state.user.lastName}"),
              subtitle: Text(state.user.email),
            ),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.assignment_ind),
              title: Text(
                  "${state.user.doctor.firstName} ${state.user.doctor.lastName}"),
              subtitle: Text(state.user.doctor.email),
            ),
            Divider(height: 0),
            SizedBox(height: 32),
            Divider(height: 0),
            ListTile(
              title: Text("Notifications"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => _navigationBloc
                  .add(NavigationPush(Routes.notificationPreferences)),
            ),
            Divider(height: 0),
            SwitchListTile(
              title: Text("Dark Mode"),
              onChanged: (b) => _authenticationBloc.add(ToggleTheme()),
              value: state.preferences.userTheme == UserTheme.DARK,
            ),
            Divider(height: 0),
            SizedBox(height: 32),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: _onLogout,
            ),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
