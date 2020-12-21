import 'package:app/models/choice.dart';
import 'package:equatable/equatable.dart';

class ChoiceType extends Equatable {
  final int id;
  final List<Choice> choices;
  final int variable;

  ChoiceType({this.id, this.choices, this.variable});

  @override
  List<Object> get props => [id, choices, variable];

  factory ChoiceType.fromJson(Map<String, dynamic> json) {
    return ChoiceType(
      id: json['id'],
      choices: (json['choices'] as List).map((c) => Choice.fromJson(c)).toList(),
      variable: json['variable'],
    );
  }
}
