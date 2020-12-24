import 'package:app/models/report.dart';
import 'package:app/models/choice_response.dart';
import 'package:app/models/range_response.dart';
import 'package:app/models/response.dart';
import 'package:app/models/variable_instance.dart';
import 'package:app/repositories/variable_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final VariableRepository variableRepository;

  ReportBloc({this.variableRepository}) : super(ReportState.initial);

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ReportEnterPageEvent) {
      final variables = await this.variableRepository.getVariables();
      yield state.copyWith(
        initialising: false,
        variables: variables,
      );
    }
    if (event is ReportTogglePanelExpansion) {
      final open = [...state.openPanels];
      if (open.contains(event.id)) {
        open.remove(event.id);
      } else {
        open.add(event.id);
      }
      yield state.copyWith(
        openPanels: open,
      );
    }
    if (event is ReportChoiceResponseToggle) {
      final choiceResponses = [...state.choiceResponses];
      if (choiceResponses.contains(event.response)) {
        choiceResponses.remove(event.response);
      } else {
        final existing = choiceResponses.firstWhere(
            (r) => r.variable == event.response.variable,
            orElse: () => null);
        if (existing == null) {
          choiceResponses.add(event.response);
        } else {
          choiceResponses.remove(existing);
          choiceResponses.add(event.response);
        }
      }
      yield state.copyWith(
        choiceResponses: choiceResponses,
      );
    }
    if (event is ReportRangeResponse) {
      final rangeResponses = [...state.rangeResponses];
      final existing = rangeResponses.firstWhere(
              (r) => r.variable == event.response.variable,
          orElse: () => null);
      if (existing != null) {
        rangeResponses.remove(existing);
      }
      rangeResponses.add(event.response);

      yield state.copyWith(
        rangeResponses: rangeResponses,
      );
    }
    if (event is ReportSubmitReportEvent) {
      final report = Report(
          choiceResponses: state.choiceResponses,
          rangeResponses: state.rangeResponses,
      );
      yield state.copyWith(
        submittingReport: true,
      );
      await variableRepository.submitReport(report);
      yield state.copyWith(
        submittingReport: false,
        rangeResponses: [],
        choiceResponses: [],
        openPanels: [],
      );
    }
  }
}
