import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final bool isDoctor;
  final bool isPatient;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.isDoctor,
    this.isPatient,
  });

  @override
  List<Object> get props => [email, firstName, lastName, isDoctor, isPatient];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isDoctor: json['is_doctor'],
      isPatient: json['is_patient'],
    );
  }
}
