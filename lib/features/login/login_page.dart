import 'package:app/authentication/authentication_bloc.dart';
import 'package:app/features/login/bloc/login_bloc.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key key, this.userRepository}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = context.read<AuthenticationBloc>();
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
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
