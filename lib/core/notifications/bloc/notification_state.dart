part of 'notification_bloc.dart';

class NotificationState extends BlocState<NotificationState> {
  final bool initialised;
  final bool active;
  final String token;

  NotificationState({
    @required this.initialised,
    @required this.active,
    @required this.token,
  }) : super([initialised, active, token]);

  static final initial = NotificationState(
    initialised: false,
    active: false,
    token: null,
  );

  @override
  NotificationState copyWith({
    bool initialised,
    bool active,
    Nullable<String> token,
  }) =>
      NotificationState(
        initialised: initialised ?? this.initialised,
        active: active ?? this.active,
        token: token == null ? this.token : token.value,
      );
}
