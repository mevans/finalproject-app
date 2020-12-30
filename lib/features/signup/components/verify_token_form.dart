import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VerifyTokenForm extends StatelessWidget {
  final Function(String token) onSubmit;

  const VerifyTokenForm({
    Key key,
    this.onSubmit,
  }) : super(key: key);

  _onSubmit(FormGroup form) {
    onSubmit(form.control('token').value);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => FormGroup({
        'token': FormControl(
          validators: [Validators.minLength(5), Validators.maxLength(5)],
        ),
      }),
      builder: (ctx, form, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReactiveTextField(
            formControlName: 'token',
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: "Invite Code",
            ),
          ),
          SizedBox(height: 20),
          ReactiveFormConsumer(
            builder: (ctx, form, child) => ElevatedButton(
              child: Text("Accept Invite"),
              onPressed: form.valid ? () => _onSubmit(form) : null,
            ),
          ),
        ],
      ),
    );
  }
}
