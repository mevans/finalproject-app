import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/core/navigation/bloc/navigation_bloc.dart';
import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/features/report/bloc/report_bloc.dart';
import 'package:app/features/report/components/variables_list.dart';
import 'package:app/shared/repositories/variable_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/note.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportBloc _reportBloc;
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    _reportBloc = ReportBloc(
      rootBloc: context.read<RootBloc>(),
      variableRepository: context.read<VariableRepository>(),
    )..add(ReportEnterPageEvent());
    _navigationBloc = context.read<NavigationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      cubit: _reportBloc,
      builder: (context, state) {
        final reportButtonDisabled = state.submittingReport ||
            (state.rangeResponses.isEmpty && state.choiceResponses.isEmpty);
        return Scaffold(
            appBar: AppBar(
              title: Text("Today"),
              leading: IconButton(icon: Icon(Icons.today), onPressed: () {}),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LoggedOut());
                  },
                )
              ],
            ),
            body: !state.initialising
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: VariablesList(
                          variables: state.variables,
                          expandedPanels: state.openPanels,
                          choiceResponses: state.choiceResponses,
                          rangeResponses: state.rangeResponses,
                          respondedVariables: _reportBloc.respondedVariables(),
                          onPanelToggled: (id) => _reportBloc.add(
                            ReportTogglePanelExpansion(id),
                          ),
                          onChoiceToggle: (response) => _reportBloc.add(
                            ReportChoiceResponseToggle(response),
                          ),
                          onRangeResponse: (response) => _reportBloc.add(
                            ReportRangeResponse(response),
                          ),
                          onRangeClear: (variable) => _reportBloc.add(
                            ReportRangeClear(variable),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            bottomNavigationBar: AnimatedCrossFade(
              firstChild: Container(height: 0),
              secondChild: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0, blurRadius: 3, color: Colors.black54)
                  ],
                ),
                height: 72,
                width: double.infinity,
                child: FlatButton(
                  child: Text("Submit",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme
                              .onSecondary)),
                  onPressed: () => _reportBloc.add(ReportSubmitReportEvent()),
                  color: Theme.of(context).accentColor,
                  disabledColor: Theme.of(context).disabledColor,
                ),
              ),
              duration: kThemeAnimationDuration,
              crossFadeState: reportButtonDisabled
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            floatingActionButton: Builder(
              builder: (ctx) => FloatingActionButton(
                child: Icon(Icons.note_add_outlined),
                backgroundColor: state.note == ""
                    ? Theme.of(context).chipTheme.backgroundColor
                    : Theme.of(context).accentColor,
                foregroundColor: state.note == ""
                    ? Theme.of(context).chipTheme.labelStyle.color
                    : null,
                onPressed: () {
                  showModalBottomSheet<String>(
                    isScrollControlled: true,
                    context: ctx,
                    builder: (ctx) => Note(
                      initialValue: state.note,
                      onSubmit: (note) {
                        _reportBloc.add(ReportUpdateNote(note));
                        _navigationBloc.add(NavigationPop());
                      },
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
