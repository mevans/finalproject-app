import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/signup/bloc/signup_bloc.dart';
import 'package:app/features/signup/components/signup_form.dart';
import 'package:app/features/signup/components/verify_token_form.dart';
import 'package:app/shared/components/auth_page.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupBloc _signupBloc;

  @override
  void initState() {
    _signupBloc = SignupBloc(
      rootBloc: context.read<RootBloc>(),
      userRepository: context.read<UserRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: BlocBuilder<SignupBloc, SignupState>(
        cubit: _signupBloc,
        builder: (ctx, state) {
          return state.verifiedToken == null
              ? VerifyTokenForm(
                  onSubmit: (token) =>
                      _signupBloc.add(SignupVerifyTokenEvent(token)),
                )
              : SignupForm(
                  name: state.firstName,
                  onSubmit: (email, password, password2) => _signupBloc.add(
                    SignupSubmitEvent(
                        email,
                        password,
                        password2,
                        () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => ReportPage()))),
                  ),
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    _signupBloc.close();
    super.dispose();
  }
}
