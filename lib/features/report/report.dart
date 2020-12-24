import 'package:app/authentication/authentication_bloc.dart';
import 'package:app/features/report/bloc/report_bloc.dart';
import 'package:app/features/report/components/variables_list.dart';
import 'package:app/repositories/variable_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportBloc _reportBloc;

  @override
  void initState() {
    _reportBloc =
        ReportBloc(variableRepository: context.read<VariableRepository>());
    _reportBloc.add(ReportEnterPageEvent());
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
            actions: [
              IconButton(
                icon: Icon(Icons.cancel),
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
                      child: SingleChildScrollView(
                        child: VariablesList(
                          variables: state.variables,
                          expandedPanels: state.openPanels,
                          choiceResponses: state.choiceResponses,
                          rangeResponses: state.rangeResponses,
                          onPanelToggled: (id) => _reportBloc.add(
                            ReportTogglePanelExpansion(id),
                          ),
                          onChoiceToggle: (response) => _reportBloc.add(
                            ReportChoiceResponseToggle(response),
                          ),
                          onRangeResponse: (response) =>
                              _reportBloc.add(ReportRangeResponse(response)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ElevatedButton(
                        onPressed: !reportButtonDisabled
                            ? () => _reportBloc.add(ReportSubmitReportEvent())
                            : null,
                        child: Text("Report"),
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
