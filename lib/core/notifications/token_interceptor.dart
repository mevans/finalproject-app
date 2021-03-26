import 'package:tracker/core/notifications/bloc/notification_bloc.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final Dio dio;
  NotificationBloc notificationBloc;

  TokenInterceptor({this.dio}) {
    dio.interceptors.add(this);
  }

  initialise(NotificationBloc notificationBloc) {
    this.notificationBloc = notificationBloc;
  }

  @override
  Future<void> onRequest(RequestOptions options) async {
    NotificationState state = notificationBloc.state;
    if (!state.initialised) {
      state = await notificationBloc.stream.firstWhere((state) => state.initialised);
    }
    if (!state.active) return super.onRequest(options);
    options.headers['X-FCM-TOKEN'] = state.token;
    return super.onRequest(options);
  }
}
