import 'package:equatable/equatable.dart';

abstract class BlocState<T> extends Equatable {
  final List<Object> props;

  BlocState([this.props = const []]);

  T copyWith();
}
