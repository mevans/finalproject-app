import 'package:app/shared/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final Map<String, List<ValueChanged<RootEvent>>> listeners = new Map();
  final Map<String, Bloc> rootEvents = new Map();

  RootBloc() : super(RootState.initial);

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {}

  // Register root event handler
  registerRootEvent<Event, State>(Type event, Bloc<Event, State> bloc) {
    rootEvents[event.toString()] = bloc;
  }

  // Map global event to local event
  addEventListener<T extends RootEvent>(Type event, ValueChanged<T> onEvent) {
    final eventType = event.toString();
    final currentListeners = listeners[eventType];
    listeners[eventType] = currentListeners == null
        ? [onEvent]
        : [...listeners[eventType], onEvent];
  }

  @override
  void onEvent(RootEvent event) {
    super.onEvent(event);
    rootEvents[event.runtimeType.toString()]?.add(event);
    (listeners[event.runtimeType.toString()] ?? []).forEach((cb) => cb(event));
  }
}
