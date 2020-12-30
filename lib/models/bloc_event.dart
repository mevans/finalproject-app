import 'package:equatable/equatable.dart';

abstract class BlocEvent extends Equatable {
  final List<Object> props;

  BlocEvent({this.props = const []});
}
