part of 'signup_bloc.dart';

class SignupState extends BlocState {
  final String verifiedToken;
  final String firstName;

  SignupState({
    this.verifiedToken,
    this.firstName,
  }) : super([verifiedToken, firstName]);

  static final initial = SignupState(
    verifiedToken: null,
    firstName: null,
  );

  SignupState copyWith({
    Nullable<String> verifiedToken,
    String firstName,
  }) =>
      SignupState(
        verifiedToken:
            verifiedToken == null ? this.verifiedToken : verifiedToken.value,
        firstName: firstName ?? this.firstName,
      );
}
