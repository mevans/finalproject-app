part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String token, email, password, password2;
  final bool tokenVerified;

  SignupState({
    @required this.token,
    @required this.email,
    @required this.password,
    @required this.password2,
    @required this.tokenVerified,
  });

  List<Object> get props => [token, email, password, password2, tokenVerified];

  static SignupState initial = SignupState(
    token: "",
    email: "",
    password: "",
    password2: "",
    tokenVerified: false,
  );

  SignupState copyWith({
    String token,
    String email,
    String password,
    String password2,
    bool tokenVerified,
    bool tokenInvalid,
  }) =>
      SignupState(
        token: token ?? this.token,
        email: email ?? this.email,
        password: password ?? this.password,
        password2: password2 ?? this.password2,
        tokenVerified: tokenVerified ?? this.tokenVerified,
      );
}
