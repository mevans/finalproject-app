import 'package:tracker/features/login/login_page.dart';
import 'package:tracker/features/report/report.dart';
import 'package:tracker/features/settings/notification_preferences/notification_preferences_page.dart';
import 'package:tracker/features/settings/settings_page.dart';
import 'package:tracker/features/signup/signup_page.dart';
import 'package:tracker/features/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String report = '/report';
  static String signup = '/signup';
  static String settings = '/settings';
  static String notificationPreferences = '/notification-preferences';

  static Map<String, WidgetBuilder> routes = {
    '/': (ctx) => SplashPage(),
    '/login': (ctx) => LoginPage(),
    '/report': (ctx) => ReportPage(),
    '/signup': (ctx) => SignupPage(
          invite: ModalRoute.of(ctx).settings.arguments,
        ),
    '/settings': (ctx) => SettingsPage(),
    '/notification-preferences': (ctx) => NotificationPreferencesPage(),
  };
}
