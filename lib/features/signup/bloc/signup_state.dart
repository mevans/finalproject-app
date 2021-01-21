part of 'signup_bloc.dart';

class SignupState extends BlocState {
  final ValidInvite validInvite;

  SignupState({
    this.validInvite,
  }) : super([
          validInvite,
        ]);

  static final initial = (ValidInvite invite) => SignupState(
        validInvite: invite,
      );

  SignupState copyWith({
    Nullable<ValidInvite> validInvite,
  }) =>
      SignupState(
        validInvite: validInvite == null ? this.validInvite : validInvite.value,
      );
}
