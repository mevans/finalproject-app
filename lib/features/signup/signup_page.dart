import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/signup/bloc/signup_bloc.dart';
import 'package:app/features/signup/components/signup_form.dart';
import 'package:app/features/signup/components/verify_token_form.dart';
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
      userRepository: context.read<UserRepository>(),
      authenticationBloc: context.read<AuthenticationBloc>(),
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
            child: BlocBuilder<SignupBloc, SignupState>(
              cubit: _signupBloc,
              builder: (ctx, state) {
                if (!state.tokenVerified) {
                  return VerifyTokenForm(
                    token: state.token,
                    onTokenChanged: (t) => _signupBloc.add(
                      SignupChangeEvent(token: t),
                    ),
                    onVerify: () => _signupBloc.add(
                      SignupVerifyTokenEvent(),
                    ),
                  );
                }
                if (state.tokenVerified) {
                  return SignupForm(
                    email: state.email,
                    password: state.password,
                    password2: state.password2,
                    onEmailChanged: (e) =>
                        _signupBloc.add(SignupChangeEvent(email: e)),
                    onPasswordChanged: (p) =>
                        _signupBloc.add(SignupChangeEvent(password: p)),
                    onPassword2Changed: (p) =>
                        _signupBloc.add(SignupChangeEvent(password2: p)),
                    onSignup: () => _signupBloc.add(SignupSubmitEvent(() => {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => ReportPage()))
                        })),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _signupBloc.close();
    super.dispose();
  }
}
