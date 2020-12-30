import 'package:app/shared/models/choice_type.dart';
import 'package:app/shared/models/range_type.dart';
import 'package:equatable/equatable.dart';

enum VariableType { from, range, choice }

extension VariableTypeIndex on VariableType {
  operator [](String key) => (name) {
        switch (name) {
          case 'range':
            return VariableType.range;
          case 'choice':
            return VariableType.choice;
        }
      }(key);
}

class Variable extends Equatable {
  final int id;
  final String name;
  final VariableType type;

  final RangeType range;
  final ChoiceType choice;

  Variable({
    this.id,
    this.name,
    this.type,
    this.range,
    this.choice,
  });

  @override
  List<Object> get props => [id, name, type, range, choice];

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      id: json['id'],
      name: json['name'],
      type: VariableType.from[json['type']],
      choice: json['choice'] != null ? ChoiceType.fromJson(json['choice']) : null,
      range: json['range'] != null ? RangeType.fromJson(json['range']) : null,
    );
  }
}
