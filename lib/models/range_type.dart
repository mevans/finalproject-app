import 'package:equatable/equatable.dart';

class RangeType extends Equatable {
  final int id;
  final int minValue;
  final int maxValue;
  final int variable;

  RangeType({
    this.id,
    this.minValue,
    this.maxValue,
    this.variable,
  });

  @override
  List<Object> get props => [id, minValue, maxValue, variable];

  factory RangeType.fromJson(Map<String, dynamic> json) {
    return RangeType(
      id: json['id'],
      minValue: json['min_value'],
      maxValue: json['max_value'],
      variable: json['variable'],
    );
  }
}
