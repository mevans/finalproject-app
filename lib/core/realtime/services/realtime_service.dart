import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:rxdart/rxdart.dart';

class RealtimeService {
  final ably.Realtime realtime;
  final BehaviorSubject<List<ably.RealtimeChannel>> channels =
      BehaviorSubject.seeded([]);

  RealtimeService()
      : realtime = ably.Realtime(
            options:
                ably.ClientOptions.fromKey("NMUq6w.iAUGPg:SWRaw0-gHwRisLtP"));

  bool channelIsConnected(String channelName) {
    return this
        .channels
        .value
        .map((channel) => channel.name)
        .contains(channelName);
  }

  Future<void> connectToChannel(String channelName) async {
    if (this.channelIsConnected(channelName)) {
      return;
    }
    final channel = this.realtime.channels.get(channelName);
    await channel.attach();
    channels.add([...channels.value, channel]);
  }

  Future<void> disconnectFromChannel(String channelName) async {
    if (!this.channelIsConnected(channelName)) {
      return;
    }
    final channel = this
        .channels
        .value
        .firstWhere((channel) => channel.name == channelName);
    await channel.detach();
    final updatedChannels = this
        .channels
        .value
        .where((channel) => channel.name != channelName)
        .toList();
    channels.add(updatedChannels);
  }

  Stream<ably.Message> getMessageStream({
    String name,
    List<String> names = const [],
  }) {
    return this.channels.switchMap((channels) => Rx.merge(channels
        .map((channel) => channel.subscribe(name: name, names: names))));
  }
}
