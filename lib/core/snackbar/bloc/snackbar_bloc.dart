import 'dart:async';

import 'package:tracker/core/root_bloc/root_bloc.dart';
import 'package:tracker/core/snackbar/enums/snackbar_type.dart';
import 'package:tracker/shared/models/bloc_event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'snackbar_event.dart';
part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  final Locator read;
  final GlobalKey<NavigatorState> navigator;
  RootBloc rootBloc;

  SnackbarBloc({
    @required this.read,
    @required this.navigator,
  }) : super(SnackbarInitial()) {
    rootBloc = read<RootBloc>();

    rootBloc.registerRootEvent(ShowSnackbarEvent, this);
    rootBloc.registerRootEvent(ShowErrorSnackbar, this);
    rootBloc.registerRootEvent(ShowInfoSnackbar, this);
  }

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {}

  @override
  void onEvent(SnackbarEvent event) {
    super.onEvent(event);
    if (event is ShowSnackbarEvent) {
      ScaffoldMessenger.of(navigator.currentContext).showSnackBar(
        SnackBar(
          backgroundColor: getSnackbarColor(event.type),
          content: Text(event.text),
        ),
      );
    }
  }

  Color getSnackbarColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.Success:
        return Colors.green;
        break;
      case SnackbarType.Error:
        return Colors.red;
        break;
      case SnackbarType.Info:
      default:
        return null;
    }
  }
}
