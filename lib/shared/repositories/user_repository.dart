import 'package:app/shared/models/auth_data.dart';
import 'package:app/shared/models/patient.dart';
import 'package:app/shared/models/user_preferences.dart';
import 'package:app/shared/models/valid_invite.dart';
import 'package:app/shared/models/variable_notification_preference.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';

class UserRepository {
  final Dio dio;

  UserRepository({
    @required this.dio,
  });

  Future<AuthData> authenticate({
    @required String email,
    @required String password,
  }) {
    return this.dio.post('auth/login', data: {
      'email': email,
      'password': password,
    }).then((response) {
      final data = response.data;
      return AuthData(access: data['access'], refresh: data['refresh']);
    });
  }

  Future<Patient> getUser() {
    return this
        .dio
        .get('user')
        .then((response) => Patient.fromJson(response.data));
  }

  Future<ValidInvite> verifyInviteCode({
    @required String inviteCode,
  }) {
    return this.dio.post('auth/verify-invite-code', data: {
      'code': inviteCode,
    }).then((response) => ValidInvite.fromJson(response.data));
  }

  Future<ValidInvite> verifyInviteToken({
    @required String token,
  }) {
    return this.dio.post('auth/verify-invite-token', data: {
      'token': token,
    }).then((response) => ValidInvite.fromJson(response.data));
  }

  Future<AuthData> register({
    @required String email,
    @required String password,
    @required String password2,
    @required String code,
  }) {
    return this.dio.post('auth/register', data: {
      'email': email,
      'password': password,
      'password2': password2,
      'code': code,
    }).then((response) => AuthData.fromJson(response.data));
  }

  Future<List<VariableNotificationPreference>> getNotificationPreferences() {
    return this
        .dio
        .get('notification-preferences?expand=instance.variable')
        .then((response) {
      List instances = response.data;
      return instances
          .map((i) => VariableNotificationPreference.fromJson(i))
          .toList();
    });
  }

  Future<void> updateNotificationPreferences(
    List<VariableNotificationPreference> notificationPreferences,
  ) {
    return Future.wait(notificationPreferences.map((p) {
      return this.dio.patch(
            'notification-preferences/${p.id}/',
            data: p.toPatchJson(),
          );
    }));
  }

  Future<UserPreferences> getPreferences() {
    return this
        .dio
        .get('preferences')
        .then((r) => UserPreferences.fromJson(r.data));
  }

  Future<UserPreferences> updatePreferences(UserPreferences userPreferences) {
    return this
        .dio
        .patch('preferences', data: userPreferences.toJson())
        .then((r) => UserPreferences.fromJson(r.data));
  }
}
