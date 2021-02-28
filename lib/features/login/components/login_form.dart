import 'package:app/shared/components/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatelessWidget {
  final bool submitting;
  final Function(String email, String password) onSubmit;
  final VoidCallback onSignup;

  const LoginForm({
    Key key,
    this.submitting,
    this.onSubmit,
    this.onSignup,
  }) : super(key: key);

  _onSubmit(FormGroup form) {
    onSubmit(form.control('email').value, form.control('password').value);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => FormGroup({
        'email': FormControl(
          value: '',
          validators: [Validators.required, Validators.email],
        ),
        'password': FormControl(
          value: '',
          validators: [Validators.required],
        )
      }),
      builder: (ctx, form, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Login",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ReactiveTextField(
            formControlName: 'email',
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email"),
          ),
          SizedBox(height: 20),
          PasswordField(
            formControlName: 'password',
          ),
          SizedBox(height: 20),
          ReactiveFormConsumer(
            builder: (ctx, form, child) => ElevatedButton(
              child: Text("Log In"),
              onPressed: form.valid ? () => _onSubmit(form) : null,
            ),
          ),
          TextButton(
            child: Text("Click here to accept an invite"),
            onPressed: onSignup,
          ),
        ],
      ),
    );
  }
}
