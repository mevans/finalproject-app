import 'package:app/shared/models/user.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final bool isDoctor;
  final bool isPatient;

  final User doctor;

  Patient({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.isDoctor,
    this.isPatient,
    this.doctor,
  });

  @override
  List<Object> get props =>
      [id, email, firstName, lastName, isDoctor, isPatient, doctor];

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isDoctor: json['is_doctor'],
      isPatient: json['is_patient'],
      doctor: User.fromJson(json['doctor']),
    );
  }
}
