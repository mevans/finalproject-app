import 'package:tracker/features/report/components/variable_input.dart';
import 'package:tracker/shared/models/choice_response.dart';
import 'package:tracker/shared/models/range_response.dart';
import 'package:tracker/shared/models/variable_instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rrule/rrule.dart';

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

  String getVariableOccurrence(
      VariableInstance variable, BuildContext context) {
    return variable.schedule?.toText(l10n: context.read<RruleL10nEn>()) ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemBuilder: (ctx, index) {
        final variable = variables[index];
        final isExpanded = expandedPanels.contains(variable.id);
        final responded = respondedVariables.contains(variable.variable.id);
        final occurrence = getVariableOccurrence(variable, context);
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
                    children: [
                      Icon(Icons.alarm),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              variable.variable.name,
                              style: TextStyle(
                                fontSize: 16,
                              ).merge(responded
                                  ? TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600,
                                    )
                                  : null),
                            ),
                            if (occurrence != null)
                              Text(
                                occurrence,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(0.5),
                                ),
                              )
                          ],
                        ),
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
  }
}
