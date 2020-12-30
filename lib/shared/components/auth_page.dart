import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final Widget child;

  const AuthPage({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: child,
          ),
        ),
      ),
    );
  }
}
