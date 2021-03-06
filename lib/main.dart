import 'package:tracker/app.dart';
import 'package:tracker/core/authentication/authentication_interceptor.dart';
import 'package:tracker/core/notifications/token_interceptor.dart';
import 'package:tracker/core/realtime/services/realtime_service.dart';
import 'package:tracker/core/root_bloc/root_bloc.dart';
import 'package:tracker/shared/repositories/token_repository.dart';
import 'package:tracker/shared/repositories/user_repository.dart';
import 'package:tracker/shared/repositories/variable_repository.dart';
import 'package:tracker/shared/services/alert_service.dart';
import 'package:tracker/shared/services/dynamic_link_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:rrule/rrule.dart';
import 'package:time_machine/time_machine.dart';

class LoggerBloc extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await TimeMachine.initialize({'rootBundle': rootBundle});
  final l10n = await RruleL10nEn.create();
  EquatableConfig.stringify = true;
  // Bloc.observer = LoggerBloc();
  final url = 'https://proj-api.herokuapp.com/patient/';
  final dio = Dio()..options.baseUrl = url;
  final tokenDio = Dio()..options.baseUrl = url;
  runApp(
    BlocProvider<RootBloc>(
      lazy: true,
      create: (ctx) => RootBloc(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TokenRepository>(
              create: (ctx) => TokenRepository()),
          RepositoryProvider<VariableRepository>(
              create: (ctx) => VariableRepository(dio: dio)),
          RepositoryProvider<UserRepository>(
              create: (ctx) => UserRepository(dio: dio)),
          RepositoryProvider<AuthenticationInterceptor>(
              create: (ctx) => AuthenticationInterceptor(
                    dio: dio,
                    tokenDio: tokenDio,
                  )),
          RepositoryProvider(
              create: (ctx) => TokenInterceptor(
                    dio: dio,
                  )),
          RepositoryProvider(create: (ctx) => AlertService()),
          RepositoryProvider(create: (ctx) => DynamicLinkService()),
          RepositoryProvider(create: (ctx) => l10n),
          RepositoryProvider(create: (ctx) => RealtimeService()),
        ],
        child: App(),
      ),
    ),
  );
}
