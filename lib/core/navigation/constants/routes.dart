import 'package:app/features/login/login_page.dart';
import 'package:app/features/report/report.dart';
import 'package:app/features/settings/settings_page.dart';
import 'package:app/features/signup/signup_page.dart';
import 'package:app/features/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String report = '/report';
  static String signup = '/signup';
  static String settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    '/': (ctx) => SplashPage(),
    '/login': (ctx) => LoginPage(),
    '/report': (ctx) => ReportPage(),
    '/signup': (ctx) => SignupPage(),
    '/settings': (ctx) => SettingsPage(),
  };
}
