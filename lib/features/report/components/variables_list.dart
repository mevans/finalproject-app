import 'package:app/features/report/components/choice_variable_input.dart';
import 'package:app/models/choice_response.dart';
import 'package:app/models/range_response.dart';
import 'package:app/models/variable.dart';
import 'package:app/models/variable_instance.dart';
import 'package:flutter/material.dart';

class VariablesList extends StatelessWidget {
  final List<VariableInstance> variables;
  final List<int> expandedPanels;
  final List<ChoiceResponse> choiceResponses;
  final List<RangeResponse> rangeResponses;
  final ValueChanged<int> onPanelToggled;
  final ValueChanged<ChoiceResponse> onChoiceToggle;

  const VariablesList({
    Key key,
    this.variables,
    this.expandedPanels,
    this.choiceResponses,
    this.rangeResponses,
    this.onPanelToggled,
    this.onChoiceToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, _) =>
          onPanelToggled(variables[panelIndex].id),
      expandedHeaderPadding: EdgeInsets.zero,
      children: variables.map(
        (variable) {
          Widget inputWidget = Container();
          bool active = false;
          switch (variable.variable.type) {
            case VariableType.range:
              break;
            case VariableType.choice:
              ChoiceResponse response = choiceResponses.firstWhere(
                  (r) => r.variable == variable.variable.id,
                  orElse: () => null);
              active = response != null;
              inputWidget = ChoiceVariableInput(
                choiceType: variable.variable.choice,
                choiceResponse: response,
                onChoiceToggle: onChoiceToggle,
              );
              break;
          }
          return ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: expandedPanels.contains(variable.id),
            headerBuilder: (ctx, expanded) {
              return ListTile(
                title: Text(
                  "${variable.variable.name}",
                  style: active
                      ? TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        )
                      : null,
                ),
              );
            },
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: inputWidget,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
