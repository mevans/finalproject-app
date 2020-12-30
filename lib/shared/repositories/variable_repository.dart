import 'package:app/shared/models/report.dart';
import 'package:app/shared/models/variable_instance.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';

class VariableRepository {
  final Dio dio;

  VariableRepository({
    @required this.dio,
  });

  Future<List<VariableInstance>> getVariables() {
    return this.dio.get('variables?expand=~all').then((response) {
      List instances = response.data;
      return instances.map((i) => VariableInstance.fromJson(i)).toList();
    });
  }

  Future<void> submitReport({
    @required Report report,
  }) {
    return this.dio.post('report', data: report.toJson());
  }
}
