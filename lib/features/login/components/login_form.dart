import 'package:app/authentication/bloc/authentication_bloc.dart';
import 'package:app/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  const LoginForm({
    Key key,
    this.loginBloc,
    this.authenticationBloc,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController(text: 'testpatient@gmail.com');
  final _passwordController = TextEditingController(text: 'Power12345');

  LoginBloc get _loginBloc => widget.loginBloc;

  _onLoginButtonPressed() {
    _loginBloc.add(LoginButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  _togglePasswordVisibility() {
    _loginBloc.add(LoginTogglePasswordVisibility());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      cubit: _loginBloc,
      builder: (ctx, state) {
        return Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                controller: _emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(state.passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                controller: _passwordController,
                obscureText: !state.passwordVisible,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onLoginButtonPressed,
                child: !state.submitting
                    ? Text('Login')
                    : CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
              ),
              TextButton(
                child: Text("Click here to accept an invite"),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              )
            ],
          ),
        );
      },
    );
  }
}
