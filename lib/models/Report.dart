import 'package:app/models/choice_response.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final List<ChoiceResponse> choiceResponses;

  Report({this.choiceResponses});

  List<Object> get props => [choiceResponses];

  Map<String, dynamic> toJson() {
    return {
      'choice_responses': choiceResponses.map((r) => r.toJson()).toList(),
    };
  }
}
