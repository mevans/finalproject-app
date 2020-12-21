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
  }
}
