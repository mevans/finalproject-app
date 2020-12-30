import 'package:flutter/material.dart';

class VerifyTokenForm extends StatelessWidget {
  final String token;
  final ValueChanged<String> onTokenChanged;
  final VoidCallback onVerify;

  const VerifyTokenForm({
    Key key,
    this.token,
    this.onTokenChanged,
    this.onVerify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: token,
          decoration: InputDecoration(
            hintText: "Invite Code",
          ),
          textAlign: TextAlign.center,
          onChanged: onTokenChanged,
          textCapitalization: TextCapitalization.characters,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text("Accept Invite"),
          onPressed: onVerify,
        )
      ],
    );
  }
}
