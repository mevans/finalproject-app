import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final int id;
  final String value;
  final int type;

  Choice({this.id, this.value, this.type});

  @override
  List<Object> get props => [id, value, type];

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      id: json['id'],
      value: json['value'],
      type: json['choice_type'],
    );
  }
}
