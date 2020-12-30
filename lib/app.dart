import 'package:app/authentication/authentication_interceptor.dart';
import 'package:app/authentication/bloc/authentication_bloc.dart';
import 'package:app/features/login/login_page.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/signup/signup_page.dart';
import 'package:app/features/splash/splash.dart';
import 'package:app/repositories/token_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigator = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (ctx) => AuthenticationBloc(
            userRepository: ctx.read<UserRepository>(),
            tokenRepository: ctx.read<TokenRepository>(),
            authenticationInterceptor: ctx.read<AuthenticationInterceptor>(),
            navigator: navigator,
          )..add(AppStarted()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => SplashPage(),
          '/login': (ctx) => LoginPage(),
          '/report': (ctx) => ReportPage(),
          '/signup': (ctx) => SignupPage(),
        },
      ),
    );
  }
}
