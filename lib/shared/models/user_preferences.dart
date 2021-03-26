import 'package:tracker/shared/models/user_theme.enum.dart';
import 'package:tracker/shared/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserPreferences extends Equatable {
  final int id;
  final int patient;
  final UserTheme userTheme;

  UserPreferences(this.userTheme, this.id, this.patient);

  @override
  List<Object> get props => [userTheme];

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(enumFromString(UserTheme.values, json['theme']),
        json['id'], json['patient']);
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': userTheme.toString().split('.')[1],
      'id': id,
      'patient': 'patient',
    };
  }

  ThemeMode getThemeMode() {
    switch (userTheme) {
      case UserTheme.LIGHT:
        return ThemeMode.light;
      case UserTheme.DARK:
        return ThemeMode.dark;
    }
  }

  copyWith({
    UserTheme userTheme,
  }) =>
      UserPreferences(
        userTheme ?? this.userTheme,
        id,
        patient,
      );
}
