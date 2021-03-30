part of 'report_bloc.dart';

abstract class ReportEvent extends BlocEvent {
  ReportEvent([props]) : super(props: props);
}

class ReportEnterPageEvent extends ReportEvent {}

class ReportRealtimeUpdateEvent extends ReportEvent {}

class ReportSubmitReportEvent extends ReportEvent {}

class ReportTogglePanelExpansion extends ReportEvent {
  final int id;

  ReportTogglePanelExpansion(this.id) : super([id]);
}

abstract class ReportResponse<T extends Response> extends ReportEvent {
  final T response;

  ReportResponse(this.response) : super([response]);
}

class ReportChoiceResponseToggle extends ReportResponse<ChoiceResponse> {
  ReportChoiceResponseToggle(ChoiceResponse response) : super(response);
}

class ReportRangeResponse extends ReportResponse<RangeResponse> {
  ReportRangeResponse(RangeResponse response) : super(response);
}

class ReportRangeClear extends ReportEvent {
  final int id;

  ReportRangeClear(this.id) : super([id]);
}

class ReportUpdateNote extends ReportEvent {
  final String note;

  ReportUpdateNote(this.note) : super([note]);
}

class ReportRefreshEvent extends ReportEvent {}
