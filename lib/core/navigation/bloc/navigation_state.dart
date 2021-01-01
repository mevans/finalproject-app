part of 'navigation_bloc.dart';

class NavigationState extends BlocState {
  final navigationId;

  NavigationState({
    @required this.navigationId,
  }) : super([navigationId]);

  static final initial = NavigationState(navigationId: 0);

  copyWith({
    int navigationId,
  }) =>
      NavigationState(
        navigationId: navigationId ?? this.navigationId,
      );
}
