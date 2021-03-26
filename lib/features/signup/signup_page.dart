import 'package:tracker/features/signup/bloc/signup_bloc.dart';
import 'package:tracker/features/signup/components/signup_form.dart';
import 'package:tracker/features/signup/components/verify_code_form.dart';
import 'package:tracker/shared/components/auth_page.dart';
import 'package:tracker/shared/models/valid_invite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  final ValidInvite invite;

  const SignupPage({Key key, this.invite}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupBloc _signupBloc;

  @override
  void initState() {
    _signupBloc = SignupBloc(
      read: context.read,
      invite: widget.invite,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: BlocBuilder<SignupBloc, SignupState>(
        bloc: _signupBloc,
        builder: (ctx, state) {
          return state.validInvite == null
              ? VerifyCodeForm(
                  onSubmit: (code) =>
                      _signupBloc.add(SignupVerifyCodeEvent(code)),
                )
              : SignupForm(
                  validInvite: state.validInvite,
                  onSubmit: (email, password, password2) => _signupBloc.add(
                    SignupSubmitEvent(
                      email,
                      password,
                      password2,
                    ),
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
