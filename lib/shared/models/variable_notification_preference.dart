import 'package:tracker/shared/models/variable_instance.dart';
import 'package:tracker/shared/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VariableNotificationPreference extends Equatable {
  final int id;
  final TimeOfDay time;
  final bool enabled;
  final VariableInstance instance;

  VariableNotificationPreference({
    this.id,
    this.time,
    this.enabled,
    this.instance,
  });

  @override
  List<Object> get props => [id, time, enabled, instance];

  factory VariableNotificationPreference.fromJson(Map<String, dynamic> json) {
    final times = (json['time'] as String).split(':').map(int.parse).toList();
    return VariableNotificationPreference(
      id: json['id'],
      time: TimeOfDay(hour: times[0], minute: times[1]),
      enabled: json['enabled'],
      instance: VariableInstance.fromJson(json['instance']),
    );
  }

  Map<String, dynamic> toPatchJson() {
    return {
      'id': id,
      'time': time.basicFormat(),
      'enabled': enabled,
    };
  }
}
