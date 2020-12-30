import 'package:app/shared/models/choice_response.dart';
import 'package:app/shared/models/range_response.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final List<ChoiceResponse> choiceResponses;
  final List<RangeResponse> rangeResponses;
  final String note;

  Report({this.choiceResponses, this.rangeResponses, this.note});

  List<Object> get props => [choiceResponses, rangeResponses, note];

  Map<String, dynamic> toJson() {
    return {
      'choice_responses': choiceResponses.map((r) => r.toJson()).toList(),
      'range_responses': rangeResponses.map((r) => r.toJson()).toList(),
      'note': note,
    };
  }
}
