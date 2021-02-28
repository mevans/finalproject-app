import 'dart:async';

import 'package:app/core/realtime/services/realtime_service.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/models/nullable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part 'realtime_event.dart';

part 'realtime_state.dart';

class RealtimeBloc extends Bloc<RealtimeEvent, RealtimeState> {
  final Locator read;
  RootBloc rootBloc;
  RealtimeService realtimeService;

  RealtimeBloc({
    @required this.read,
  }) : super(RealtimeState.initial) {
    rootBloc = read<RootBloc>();
    realtimeService = read<RealtimeService>();

    rootBloc.addEventListener(PatientAuthenticatedEvent,
        (e) => add(ConnectRealtimeEvent(e.patient.id)));
    rootBloc.addEventListener(
        UnauthenticatedEvent, (e) => add(DisconnectRealtimeEvent()));
  }

  @override
  Stream<RealtimeState> mapEventToState(RealtimeEvent event) async* {
    if (event is ConnectRealtimeEvent) {
      final channelName = 'patient:${event.patientId}';
      await realtimeService.connectToChannel(channelName);
      yield state.copyWith(
        status: RealtimeStatus.Connected,
        patientChannel: Nullable(channelName),
      );
    }
    if (event is DisconnectRealtimeEvent) {
      await realtimeService.disconnectFromChannel(state.patientChannel);
      yield state.copyWith(
        status: RealtimeStatus.Disconnected,
        patientChannel: null,
      );
    }
  }
}
