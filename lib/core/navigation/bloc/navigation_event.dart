part of 'navigation_bloc.dart';

abstract class NavigationEvent extends BlocEvent with RootEvent {
  NavigationEvent([props]) : super(props: props);
}

class NavigationToRoot extends NavigationEvent {
  final String route;

  NavigationToRoot(this.route) : super([route]);
}

class NavigationPush extends NavigationEvent {
  final String route;
  final dynamic data;

  NavigationPush(this.route, {this.data}) : super([route, data]);
}

class NavigationPop<T> extends NavigationEvent {
  final T result;

  NavigationPop([this.result]) : super([result]);
}
