part of 'snackbar_bloc.dart';

abstract class SnackbarState extends Equatable {
  const SnackbarState();
}

class SnackbarInitial extends SnackbarState {
  @override
  List<Object> get props => [];
}
