import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordField extends StatefulWidget {
  final String formControlName;

  const PasswordField({Key key, this.formControlName}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = false;

  _toggleVisibility() => setState(() => this.isVisible = !this.isVisible);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: widget.formControlName,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: Icon(
              this.isVisible ? Icons.visibility_off : Icons.visibility,
              key: ValueKey(this.isVisible),
            ),
          ),
        ),
      ),
      obscureText: !isVisible,
    );
  }
}
