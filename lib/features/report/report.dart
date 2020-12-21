import 'package:app/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(LoggedOut());
                },
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Currently logged in as:${state.user?.firstName}${state.user?.lastName}"),
                RaisedButton(
                  child: Text("Check User"),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(GetUser());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
