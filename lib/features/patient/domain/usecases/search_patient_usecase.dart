import 'package:test1/features/patient/domain/entities/patient.dart';
import 'package:test1/features/patient/domain/repository/patient_repository.dart';

class SearchPatientUseCase {
  final PatientRepository patientRepository;
  SearchPatientUseCase(this.patientRepository);

  Future<List<Patient>> call(String query)
  {
    return patientRepository.searchPatients(query);
  }
}