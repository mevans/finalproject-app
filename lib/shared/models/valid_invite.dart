import 'package:equatable/equatable.dart';

class ValidInvite extends Equatable {
  final String id, firstName, lastName, email;

  ValidInvite({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  List<Object> get props => [id, firstName, lastName, email];

  factory ValidInvite.fromJson(Map<String, dynamic> json) => ValidInvite(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
      );
}
