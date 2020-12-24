import 'package:app/models/choice_response.dart';
import 'package:app/models/range_response.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final List<ChoiceResponse> choiceResponses;
  final List<RangeResponse> rangeResponses;

  Report({this.choiceResponses, this.rangeResponses});

  List<Object> get props => [choiceResponses, rangeResponses];

  Map<String, dynamic> toJson() {
    return {
      'choice_responses': choiceResponses.map((r) => r.toJson()).toList(),
      'range_responses': rangeResponses.map((r) => r.toJson()).toList(),
    };
  }
}
