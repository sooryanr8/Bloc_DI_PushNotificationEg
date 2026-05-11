import '../../domain/entities/patient.dart';

abstract class PatientState {}

class PatientInitial extends PatientState{}

class PatientLoaded extends PatientState{
  final List<Patient> patients;

  PatientLoaded(this.patients);
}

class PatientEmpty extends PatientState{}