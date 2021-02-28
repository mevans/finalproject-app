part of 'realtime_bloc.dart';

abstract class RealtimeEvent extends BlocEvent {
  RealtimeEvent([props]) : super(props: props);
}

class ConnectRealtimeEvent extends RealtimeEvent {
  final int patientId;

  ConnectRealtimeEvent(this.patientId) : super([patientId]);
}

class DisconnectRealtimeEvent extends RealtimeEvent {}
