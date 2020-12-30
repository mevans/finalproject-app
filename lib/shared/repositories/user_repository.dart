import 'package:app/shared/models/auth_data.dart';
import 'package:app/shared/models/patient.dart';
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

  Future<dynamic> verifySignupToken({
    @required String token,
  }) {
    return this.dio.post('auth/verify-token', data: {
      'token': token,
    }).then((value) => value.data);
  }

  Future<AuthData> register({
    @required String email,
    @required String password,
    @required String password2,
    @required String token,
  }) {
    return this.dio.post('auth/register', data: {
      'email': email,
      'password': password,
      'password2': password2,
      'token': token,
    }).then((response) => AuthData.fromJson(response.data));
  }
}
