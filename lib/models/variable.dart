import 'package:app/models/choice_type.dart';
import 'package:app/models/range_type.dart';
import 'package:equatable/equatable.dart';

enum VariableType { range, choice }

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
  List<Object> get props => throw UnimplementedError();

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(id: json['id']);
  }
}
