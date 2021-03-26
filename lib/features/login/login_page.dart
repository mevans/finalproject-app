import 'package:tracker/core/navigation/bloc/navigation_bloc.dart';
import 'package:tracker/core/navigation/constants/routes.dart';
import 'package:tracker/features/login/bloc/login_bloc.dart';
import 'package:tracker/shared/components/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(read: context.read);
    _navigationBloc = context.read<NavigationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (ctx, state) => LoginForm(
          onSubmit: (email, password) => _loginBloc.add(
            LoginSubmit(email, password),
          ),
          onSignup: () => _navigationBloc.add(NavigationPush(Routes.signup)),
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
