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

abstract class ReportResponse<T extends Response> extends ReportEvent {
  final T response;

  ReportResponse(this.response);

  List<Object> get props => [response];
}

class ReportChoiceResponseToggle extends ReportResponse<ChoiceResponse> {
  ReportChoiceResponseToggle(ChoiceResponse response) : super(response);
}

class ReportRangeResponse extends ReportResponse<RangeResponse> {
  ReportRangeResponse(RangeResponse response) : super(response);
}

class ReportRangeClear extends ReportEvent {
  final int id;

  ReportRangeClear(this.id);

  List<Object> get props => [];
}

class ReportUpdateNote extends ReportEvent {
  final String note;

  ReportUpdateNote(this.note);

  List<Object> get props => [note];
}
