import 'package:tracker/core/authentication/bloc/authentication_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';

class AuthenticationInterceptor extends Interceptor {
  final Dio dio;
  final Dio tokenDio;
  bool initialised = false;
  AuthenticationBloc authenticationBloc;

  AuthenticationInterceptor({
    @required this.dio,
    @required this.tokenDio,
  }) {
    dio.interceptors.add(this);
  }

  initialise(AuthenticationBloc authenticationBloc) {
    this.authenticationBloc = authenticationBloc;
    initialised = true;
  }

  @override
  Future<void> onRequest(RequestOptions options) async {
    if (!initialised) {
      return super.onRequest(options);
    }
    final state = authenticationBloc.state;
    if (state.status == AuthenticationStatus.authenticated &&
        options.headers['Authorization'] == null) {
      options.headers['Authorization'] = 'Bearer ${state.authData.access}';
    }
    return super.onRequest(options);
  }

  @override
  Future<void> onError(DioError error) async {
    if (!initialised) {
      return super.onError(error);
    }
    // Token expired
    if (error.response?.statusCode == 401 &&
        !error.request.path.contains('refresh-token')) {
      RequestOptions options = error.response.request;
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      final state = authenticationBloc.state;

      try {
        final response = await tokenDio.post('auth/refresh-token',
            data: {'refresh': state.authData.refresh});
        final data = response.data;
        final refreshedToken = data['access'];
        authenticationBloc.add(RefreshTokenSuccess(access: refreshedToken));
        options.headers['Authorization'] = 'Bearer $refreshedToken';
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
        await dio.request(options.path, options: options);
      } catch (e) {
        authenticationBloc.add(RefreshTokenFailure());
      }
    }
  }
}
