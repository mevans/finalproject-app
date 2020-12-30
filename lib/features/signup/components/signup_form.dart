import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final String email, password, password2;
  final ValueChanged<String> onEmailChanged,
      onPasswordChanged,
      onPassword2Changed;
  final VoidCallback onSignup;

  const SignupForm({
    Key key,
    this.email,
    this.password,
    this.password2,
    this.onSignup,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.onPassword2Changed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: email,
          onChanged: onEmailChanged,
          decoration: InputDecoration(hintText: "Email"),
        ),
        SizedBox(height: 20),
        TextFormField(
          initialValue: password,
          onChanged: onPasswordChanged,
          decoration: InputDecoration(hintText: "Password"),
        ),
        SizedBox(height: 20),
        TextFormField(
          initialValue: password2,
          onChanged: onPassword2Changed,
          decoration: InputDecoration(hintText: "Confirm Password"),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text("Register"),
          onPressed: onSignup,
        ),
      ],
    );
  }
}
