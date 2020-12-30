import 'package:app/features/report/components/range_variable_input.dart';
import 'package:app/shared/models/choice_response.dart';
import 'package:app/shared/models/range_response.dart';
import 'package:app/shared/models/variable.dart';
import 'package:app/shared/models/variable_instance.dart';
import 'package:flutter/material.dart';

import 'choice_variable_input.dart';

class VariableInput extends StatelessWidget {
  final VariableInstance variable;

  final List<RangeResponse> rangeResponses;
  final ValueChanged<RangeResponse> onRangeResponse;
  final ValueChanged<int> onRangeClear;

  final List<ChoiceResponse> choiceResponses;
  final ValueChanged<ChoiceResponse> onChoiceToggle;

  const VariableInput({
    Key key,
    this.variable,
    this.rangeResponses,
    this.onRangeResponse,
    this.onRangeClear,
    this.choiceResponses,
    this.onChoiceToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (variable.variable.type) {
      case VariableType.range:
        RangeResponse response = rangeResponses.firstWhere(
            (r) => r.variable == variable.variable.id,
            orElse: () => null);
        return RangeVariableInput(
          rangeType: variable.variable.range,
          rangeResponse: response,
          onValueChanged: onRangeResponse,
          onClear: () => onRangeClear(variable.variable.id),
        );
        break;
      case VariableType.choice:
        ChoiceResponse response = choiceResponses.firstWhere(
            (r) => r.variable == variable.variable.id,
            orElse: () => null);
        return ChoiceVariableInput(
          choiceType: variable.variable.choice,
          choiceResponse: response,
          onChoiceToggle: onChoiceToggle,
        );
        break;
    }
    return Container();
  }
}
