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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async {
              final confirm = await context.read<AlertService>().confirmation(
                    context,
                    confirmText: "Logout",
                    text:
                        "Are you sure you want to log out? You will stop receiving notifications.",
                  );
              if (!confirm) return;
              _authenticationBloc.add(LoggedOut());
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
