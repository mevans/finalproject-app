import 'package:equatable/equatable.dart';

class AuthData extends Equatable {
  final String access;
  final String refresh;

  const AuthData({this.access, this.refresh});

  @override
  List<Object> get props => [access, refresh];

  @override
  String toString() =>
      'AuthData{access: ${access.substring(0, 10)}, refresh: ${refresh.substring(0, 10)}}';

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      access: json["access"],
      refresh: json["refresh"],
    );
  }
}
