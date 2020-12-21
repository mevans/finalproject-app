part of 'report_bloc.dart';

class ReportState extends Equatable {
  final bool initialising;
  final List<VariableInstance> variables;
  final List<int> openPanels;

  ReportState({
    @required this.initialising,
    @required this.variables,
    @required this.openPanels,
  });

  @override
  List<Object> get props => [initialising, variables, openPanels];

  static ReportState initial = ReportState(
    initialising: true,
    variables: [],
    openPanels: [],
  );

  ReportState copyWith({
    bool initialising,
    List<VariableInstance> variables,
    List<int> openPanels,
  }) =>
      ReportState(
        initialising: initialising ?? this.initialising,
        variables: variables ?? this.variables,
        openPanels: openPanels ?? this.openPanels,
      );
}
