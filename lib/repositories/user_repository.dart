import 'package:app/models/auth_data.dart';
import 'package:app/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';

class UserRepository {
  final Dio dio;

  UserRepository({this.dio});

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
}
