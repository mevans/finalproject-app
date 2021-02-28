import 'package:app/shared/models/variable.dart';
import 'package:equatable/equatable.dart';
import 'package:rrule/rrule.dart';

class VariableInstance extends Equatable {
  final int id;
  final int patient;
  final Variable variable;
  final RecurrenceRule schedule;

  VariableInstance({
    this.id,
    this.patient,
    this.variable,
    this.schedule,
  });

  @override
  List<Object> get props => [id, patient, variable, schedule];

  factory VariableInstance.fromJson(Map<String, dynamic> json) {
    return VariableInstance(
      id: json['id'],
      patient: json['patient'],
      variable: Variable.fromJson(json['variable']),
      schedule: json['schedule'] != null
          ? RecurrenceRule.fromString(json['schedule'])
          : null,
    );
  }
}
