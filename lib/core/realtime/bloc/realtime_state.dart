part of 'realtime_bloc.dart';

class RealtimeState extends BlocState {
  final RealtimeStatus status;
  final String patientChannel;

  RealtimeState({
    @required this.status,
    @required this.patientChannel,
  }) : super([status, patientChannel]);

  static final initial = RealtimeState(
    status: RealtimeStatus.Disconnected,
    patientChannel: null,
  );

  @override
  copyWith({
    RealtimeStatus status,
    Nullable<String> patientChannel,
  }) {
    return RealtimeState(
      status: status ?? this.status,
      patientChannel:
          patientChannel == null ? this.patientChannel : patientChannel.value,
    );
  }
}

enum RealtimeStatus {
  Connected,
  Disconnected,
}
