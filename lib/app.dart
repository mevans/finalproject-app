import 'package:tracker/core/authentication/bloc/authentication_bloc.dart';
import 'package:tracker/core/navigation/bloc/navigation_bloc.dart';
import 'package:tracker/core/navigation/constants/routes.dart';
import 'package:tracker/core/notifications/bloc/notification_bloc.dart';
import 'package:tracker/core/realtime/bloc/realtime_bloc.dart';
import 'package:tracker/core/snackbar/bloc/snackbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigator = GlobalKey();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(read: context.read)
      ..add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (ctx) => _authenticationBloc,
        ),
        BlocProvider<NotificationBloc>(
          lazy: false,
          create: (ctx) => NotificationBloc(read: ctx.read),
        ),
        BlocProvider<NavigationBloc>(
          lazy: false,
          create: (ctx) => NavigationBloc(
            read: ctx.read,
            navigator: navigator,
          ),
        ),
        BlocProvider<SnackbarBloc>(
          lazy: false,
          create: (ctx) => SnackbarBloc(
            read: ctx.read,
            navigator: navigator,
          ),
        ),
        BlocProvider<RealtimeBloc>(
          lazy: false,
          create: (ctx) => RealtimeBloc(
            read: ctx.read,
          ),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, data) => MaterialApp(
          navigatorKey: navigator,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: data?.preferences?.getThemeMode(),
          debugShowCheckedModeBanner: false,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
