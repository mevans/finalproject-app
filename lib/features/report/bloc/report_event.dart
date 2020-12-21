part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportEnterPageEvent extends ReportEvent {}
