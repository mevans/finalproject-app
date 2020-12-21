import 'package:app/models/variable.dart';
import 'package:equatable/equatable.dart';

class VariableInstance extends Equatable {
  final int id;
  final int patient;
  final Variable variable;

  VariableInstance({
    this.id,
    this.patient,
    this.variable,
  });

  @override
  List<Object> get props => [id, patient, variable];

  factory VariableInstance.fromJson(Map<String, dynamic> json) {
    return VariableInstance(
      id: json['id'],
      patient: json['patient'],
      variable: Variable.fromJson(json['variable']),
    );
  }
}
