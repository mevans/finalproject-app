import 'package:app/shared/models/auth_data.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final Map<String, List<ValueChanged<RootEvent>>> listeners = new Map();

  RootBloc() : super(RootState.initial);

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {}

  addEventListener<T extends RootEvent>(Type event, ValueChanged<T> onEvent) {
    final eventType = event.toString();
    final currentListeners = listeners[event.runtimeType];
    listeners[eventType] = currentListeners == null
        ? [onEvent]
        : [...listeners[eventType], onEvent];
  }

  @override
  void onEvent(RootEvent event) {
    super.onEvent(event);
    (listeners[event.runtimeType.toString()] ?? []).forEach((cb) => cb(event));
  }
}
