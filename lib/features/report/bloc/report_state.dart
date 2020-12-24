part of 'report_bloc.dart';

class ReportState extends Equatable {
  final bool initialising;
  final List<VariableInstance> variables;
  final List<int> openPanels;
  final List<ChoiceResponse> choiceResponses;
  final List<RangeResponse> rangeResponses;
  final bool submittingReport;

  ReportState({
    @required this.initialising,
    @required this.variables,
    @required this.openPanels,
    @required this.choiceResponses,
    @required this.rangeResponses,
    @required this.submittingReport,
  });

  @override
  List<Object> get props => [
        initialising,
        variables,
        openPanels,
        choiceResponses,
        rangeResponses,
        submittingReport,
      ];

  static ReportState initial = ReportState(
    initialising: true,
    variables: [],
    openPanels: [],
    choiceResponses: [],
    rangeResponses: [],
    submittingReport: false,
  );

  ReportState copyWith({
    bool initialising,
    List<VariableInstance> variables,
    List<int> openPanels,
    List<ChoiceResponse> choiceResponses,
    List<RangeResponse> rangeResponses,
    bool submittingReport,
  }) =>
      ReportState(
        initialising: initialising ?? this.initialising,
        variables: variables ?? this.variables,
        openPanels: openPanels ?? this.openPanels,
        choiceResponses: choiceResponses ?? this.choiceResponses,
        rangeResponses: rangeResponses ?? this.rangeResponses,
        submittingReport: submittingReport ?? this.submittingReport,
      );
}
