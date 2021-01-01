part of 'snackbar_bloc.dart';

abstract class SnackbarEvent extends BlocEvent {
  SnackbarEvent([props]) : super(props: props);
}

abstract class ShowSnackbarEvent extends SnackbarEvent with RootEvent {
  final SnackbarType type;
  final String text;

  ShowSnackbarEvent(this.type, this.text) : super([type, text]);
}

class ShowSuccessSnackbar extends ShowSnackbarEvent with RootEvent {
  ShowSuccessSnackbar(String text) : super(SnackbarType.Success, text);
}

class ShowErrorSnackbar extends ShowSnackbarEvent with RootEvent {
  ShowErrorSnackbar(String text) : super(SnackbarType.Error, text);
}

class ShowInfoSnackbar extends ShowSnackbarEvent with RootEvent {
  ShowInfoSnackbar(String text) : super(SnackbarType.Info, text);
}
