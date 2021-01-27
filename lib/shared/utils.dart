import 'package:flutter/material.dart';

extension TimeOfDayFormatting on TimeOfDay {
  String basicFormat() {
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) return '0$value';
      return value.toString();
    }

    final String hourLabel = _addLeadingZeroIfNeeded(hour);
    final String minuteLabel = _addLeadingZeroIfNeeded(minute);
    return "$hourLabel:$minuteLabel";
  }
}

T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value,
      orElse: () => null);
}
