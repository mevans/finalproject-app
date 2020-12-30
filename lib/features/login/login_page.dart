import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/features/login/bloc/login_bloc.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = context.read<AuthenticationBloc>();
    _loginBloc = LoginBloc(
      userRepository: context.read<UserRepository>(),
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: LoginForm(
              authenticationBloc: _authenticationBloc,
              loginBloc: _loginBloc,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
