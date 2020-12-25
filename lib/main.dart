import 'package:app/authentication/authentication_bloc.dart';
import 'package:app/authentication/authentication_interceptor.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/splash/splash.dart';
import 'package:app/repositories/token_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/repositories/variable_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

import 'features/login/login_page.dart';

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
  EquatableConfig.stringify = true;
  // Bloc.observer = LoggerBloc();
  final secureStorage = FlutterSecureStorage();
  final tokenRepository = TokenRepository(secureStorage: secureStorage);
  final url = 'http://192.168.1.112:8000/patient/';
  final dio = Dio()..options.baseUrl = url;
  final tokenDio = Dio()..options.baseUrl = url;
  final authInterceptor = AuthenticationInterceptor(
    dio: dio,
    tokenDio: tokenDio,
  );
  dio.interceptors.add(authInterceptor);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<VariableRepository>(
            create: (ctx) => VariableRepository(dio: dio)),
      ],
      child: App(
        userRepository: UserRepository(
          dio: dio,
        ),
        tokenRepository: tokenRepository,
        authenticationInterceptor: authInterceptor,
      ),
    ),
  );
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;
  final AuthenticationInterceptor authenticationInterceptor;

  const App({
    Key key,
    this.userRepository,
    this.tokenRepository,
    this.authenticationInterceptor,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;

  UserRepository get userRepository => widget.userRepository;

  TokenRepository get tokenRepository => widget.tokenRepository;

  AuthenticationInterceptor get authenticationInterceptor =>
      widget.authenticationInterceptor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (ctx) {
        authenticationBloc = AuthenticationBloc(
          userRepository: userRepository,
          tokenRepository: tokenRepository,
          authenticationInterceptor: authenticationInterceptor,
        );
        authenticationBloc.add(AppStarted());
        return authenticationBloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (ctx, state) {
            switch (state.status) {
              case AuthenticationStatus.initial:
                return SplashPage();
              case AuthenticationStatus.authenticated:
                if (state.initialising) {
                  return SplashPage();
                }
                return ReportPage();
              case AuthenticationStatus.unauthenticated:
                return LoginPage(
                  userRepository: userRepository,
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
