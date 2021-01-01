import 'package:app/core/authentication/bloc/authentication_bloc.dart';
import 'package:app/core/navigation/bloc/navigation_bloc.dart';
import 'package:app/core/navigation/constants/routes.dart';
import 'package:app/core/notifications/bloc/notification_bloc.dart';
import 'package:app/core/snackbar/bloc/snackbar_bloc.dart';
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
          create: (ctx) =>
              AuthenticationBloc(read: ctx.read)..add(AppStarted()),
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
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
      ),
    );
  }
}
