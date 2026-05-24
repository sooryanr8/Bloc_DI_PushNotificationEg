import '../../domain/entities/patient.dart';

class PatientModel extends Patient {

  PatientModel({
    required super.id,
    required super.name,
  });

  factory PatientModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return PatientModel(
      id: json['id'],
      name: json['name'],
    );
  }
}