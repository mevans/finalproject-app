part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportEnterPageEvent extends ReportEvent {}

class ReportSubmitReportEvent extends ReportEvent {}

class ReportTogglePanelExpansion extends ReportEvent {
  final int id;

  ReportTogglePanelExpansion(this.id);

  List<Object> get props => [id];
}

abstract class ReportResponseToggle<T extends Response> extends ReportEvent {
  final T response;

  ReportResponseToggle(this.response);

  List<Object> get props => [response];
}

class ReportChoiceResponseToggle extends ReportResponseToggle<ChoiceResponse> {
  ReportChoiceResponseToggle(ChoiceResponse response) : super(response);
}
