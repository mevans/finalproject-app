part of 'report_bloc.dart';

class ReportState extends Equatable {
  final bool initialising;
  final List<VariableInstance> variables;

  ReportState({
    @required this.initialising,
    @required this.variables,
  });

  @override
  List<Object> get props => [];

  static ReportState initial = ReportState(
    initialising: true,
    variables: [],
  );

  ReportState copyWith({
    bool initialising,
    List<VariableInstance> variables,
  }) =>
      ReportState(
          initialising: initialising ?? this.initialising,
          variables: variables ?? this.variables);
}
