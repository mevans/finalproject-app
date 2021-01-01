import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/features/login/bloc/login_bloc.dart';
import 'package:app/shared/components/auth_page.dart';
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

  @override
  void initState() {
    _loginBloc = LoginBloc(
      rootBloc: context.read<RootBloc>(),
      userRepository: context.read<UserRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: BlocBuilder<LoginBloc, LoginState>(
        cubit: _loginBloc,
        builder: (ctx, state) => LoginForm(
          onSubmit: (email, password) => _loginBloc.add(
            LoginSubmit(email, password),
          ),
          onSignup: () => Navigator.pushNamed(context, '/signup'),
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
