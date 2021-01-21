import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VerifyCodeForm extends StatelessWidget {
  final Function(String code) onSubmit;

  const VerifyCodeForm({
    Key key,
    this.onSubmit,
  }) : super(key: key);

  _onSubmit(FormGroup form) {
    onSubmit(form.control('code').value);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => FormGroup({
        'code': FormControl(
          validators: [Validators.minLength(5), Validators.maxLength(5)],
        ),
      }),
      builder: (ctx, form, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReactiveTextField(
            formControlName: 'code',
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
