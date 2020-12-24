import 'package:app/models/report.dart';
import 'package:app/models/variable_instance.dart';
import 'package:fresh_dio/fresh_dio.dart';

class VariableRepository {
  final Dio dio;

  VariableRepository({this.dio});

  Future<List<VariableInstance>> getVariables() {
    return this.dio.get('variables?expand=~all').then((response) {
      List instances = response.data;
      return instances.map((i) => VariableInstance.fromJson(i)).toList();
    });
  }

  Future<dynamic> submitReport(Report report) {
    return this.dio.post('report', data: report.toJson());
  }
}
