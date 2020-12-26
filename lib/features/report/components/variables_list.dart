import 'package:app/features/report/components/range_variable_input.dart';
import 'package:app/features/report/components/variable_input.dart';
import 'package:app/models/choice_response.dart';
import 'package:app/models/range_response.dart';
import 'package:app/models/variable.dart';
import 'package:app/models/variable_instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VariablesList extends StatelessWidget {
  final List<VariableInstance> variables;
  final List<int> expandedPanels;
  final List<ChoiceResponse> choiceResponses;
  final List<RangeResponse> rangeResponses;
  final List<int> respondedVariables;
  final ValueChanged<int> onPanelToggled;
  final ValueChanged<ChoiceResponse> onChoiceToggle;
  final ValueChanged<RangeResponse> onRangeResponse;
  final ValueChanged<int> onRangeClear;

  const VariablesList({
    Key key,
    this.variables,
    this.expandedPanels,
    this.choiceResponses,
    this.rangeResponses,
    this.respondedVariables,
    this.onPanelToggled,
    this.onChoiceToggle,
    this.onRangeResponse,
    this.onRangeClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemBuilder: (ctx, index) {
        final variable = variables[index];
        final isExpanded = expandedPanels.contains(variable.id);
        final responded = respondedVariables.contains(variable.variable.id);
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onPanelToggled(variable.id),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        variable.variable.name,
                        style: TextStyle(
                          fontSize: 16,
                        ).merge(responded ? TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ) : null),
                      ),
                      ExpandIcon(
                        padding: const EdgeInsets.all(16),
                        onPressed: null,
                        isExpanded: isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(height: 0.0),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(bottom: 8),
                  child: VariableInput(
                    variable: variable,
                    rangeResponses: rangeResponses,
                    onRangeResponse: onRangeResponse,
                    onRangeClear: onRangeClear,
                    choiceResponses: choiceResponses,
                    onChoiceToggle: onChoiceToggle,
                  ),
                ),
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (ctx, index) => SizedBox(height: 8),
      itemCount: variables.length,
    );
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ExpansionPanelList(
        dividerColor: Theme.of(context).dividerColor,
        expansionCallback: (panelIndex, _) =>
            onPanelToggled(variables[panelIndex].id),
        expandedHeaderPadding: EdgeInsets.zero,
        children: variables.map(
          (variable) {
            Widget inputWidget = Container();
            bool active = false;
            switch (variable.variable.type) {
              case VariableType.range:
                RangeResponse response = rangeResponses.firstWhere(
                    (r) => r.variable == variable.variable.id,
                    orElse: () => null);
                active = response != null;
                inputWidget = RangeVariableInput(
                  rangeType: variable.variable.range,
                  rangeResponse: response,
                  onValueChanged: onRangeResponse,
                  onClear: () => onRangeClear(variable.variable.id),
                );
                break;
              case VariableType.choice:
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
                            color: Theme.of(context).accentColor,
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
      ),
    );
  }
}
