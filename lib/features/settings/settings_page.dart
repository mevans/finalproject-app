import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/shared/services/alert_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = context.read<AuthenticationBloc>();
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
    print("here");
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
              onTap: () {},
            ),
            Divider(height: 0),
            ListTile(
              title: Text("Colour Theme"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
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
