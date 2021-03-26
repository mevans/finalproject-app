import 'package:tracker/core/realtime/services/realtime_service.dart';
import 'package:tracker/core/root_bloc/root_bloc.dart';
import 'package:tracker/core/snackbar/bloc/snackbar_bloc.dart';
import 'package:tracker/shared/models/bloc_event.dart';
import 'package:tracker/shared/models/bloc_state.dart';
import 'package:tracker/shared/models/choice_response.dart';
import 'package:tracker/shared/models/range_response.dart';
import 'package:tracker/shared/models/report.dart';
import 'package:tracker/shared/models/response.dart';
import 'package:tracker/shared/models/variable_instance.dart';
import 'package:tracker/shared/repositories/variable_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final Locator read;
  RootBloc rootBloc;
  VariableRepository variableRepository;
  RealtimeService realtimeService;

  ReportBloc({
    @required this.read,
  }) : super(ReportState.initial) {
    rootBloc = read<RootBloc>();
    variableRepository = read<VariableRepository>();
    realtimeService = read<RealtimeService>();

    realtimeService.getMessageStream(names: [
      'variable',
      'variableinstance'
    ]).listen((m) => add(ReportRealtimeUpdateEvent()));
  }

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ReportEnterPageEvent || event is ReportRealtimeUpdateEvent) {
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
        note: state.note,
      );
      yield state.copyWith(
        submittingReport: true,
      );
      try {
        await variableRepository.submitReport(report: report);
        yield state.copyWith(
          submittingReport: false,
          rangeResponses: [],
          choiceResponses: [],
          openPanels: [],
          note: "",
        );
        rootBloc.add(ShowInfoSnackbar("Report Submitted!"));
      } catch (e) {}
    }
    if (event is ReportRangeClear) {
      final rangeResponses = [...state.rangeResponses];
      rangeResponses.removeWhere((response) => response.variable == event.id);
      yield state.copyWith(
        rangeResponses: rangeResponses,
      );
    }
    if (event is ReportUpdateNote) {
      yield state.copyWith(
        note: event.note,
      );
    }
  }

  List<int> respondedVariables() {
    return [
      ...state.rangeResponses.map((r) => r.variable),
      ...state.choiceResponses.map((r) => r.variable),
    ];
  }

  @override
  Future<Function> close() {
    print("closing");
    super.close();
  }
}
