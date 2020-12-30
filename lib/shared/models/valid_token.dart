import 'package:equatable/equatable.dart';

class ValidToken extends Equatable {
  final String firstName, lastName;

  ValidToken({this.firstName, this.lastName});

  List<Object> get props => [firstName, lastName];

  factory ValidToken.fromJson(Map<String, dynamic> json) => ValidToken(
        firstName: json['first_name'],
        lastName: json['last_name'],
      );
}
