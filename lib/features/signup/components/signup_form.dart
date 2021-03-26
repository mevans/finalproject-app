import 'package:tracker/shared/models/valid_invite.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignupForm extends StatelessWidget {
  final ValidInvite validInvite;
  final Function(String email, String password, String password2) onSubmit;

  const SignupForm({
    Key key,
    this.validInvite,
    this.onSubmit,
  }) : super(key: key);

  _onSubmit(FormGroup form) {
    onSubmit(
      form.control('email').value,
      form.control('password').value,
      form.control('password2').value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => FormGroup({
        'email': FormControl(
          value: validInvite?.email ?? "",
          validators: [Validators.required, Validators.email],
        ),
        'password': FormControl(validators: [Validators.required]),
        'password2': FormControl(validators: [Validators.required]),
      }),
      builder: (ctx, form, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hi there ${validInvite.firstName}, create some account details to complete the registration",
          ),
          SizedBox(height: 20),
          ReactiveTextField(
            formControlName: 'email',
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Email"),
          ),
          SizedBox(height: 20),
          ReactiveTextField(
            formControlName: 'password',
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(height: 20),
          ReactiveTextField(
            formControlName: 'password2',
            decoration: InputDecoration(hintText: "Confirm Password"),
          ),
          SizedBox(height: 20),
          ReactiveFormConsumer(
            builder: (ctx, form, child) => ElevatedButton(
              child: Text("Register"),
              onPressed: form.valid ? () => _onSubmit(form) : null,
            ),
          ),
        ],
      ),
    );
  }
}
