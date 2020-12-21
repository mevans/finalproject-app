import 'package:app/models/variable_instance.dart';
import 'package:flutter/material.dart';

class VariablesList extends StatelessWidget {
  final List<VariableInstance> variables;
  final List<int> expandedPanels;
  final ValueChanged<int> onPanelToggled;

  const VariablesList({
    Key key,
    this.variables,
    this.expandedPanels,
    this.onPanelToggled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, _) =>
          onPanelToggled(variables[panelIndex].id),
      children: variables.map(
        (variable) {
          return ExpansionPanel(
            isExpanded: expandedPanels.contains(variable.id),
            headerBuilder: (ctx, expanded) {
              return ListTile(
                title: Text("${variable.variable.name}"),
              );
            },
            body: Container(),
          );
        },
      ).toList(),
    );
  }
}
