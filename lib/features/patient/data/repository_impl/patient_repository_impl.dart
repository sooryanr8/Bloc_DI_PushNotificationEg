import 'package:test1/features/patient/data/datasource/patient_datasource.dart';
import 'package:test1/features/patient/domain/entities/patient.dart';
import 'package:test1/features/patient/domain/repository/patient_repository.dart';

class PatientRepositoryImpl extends PatientRepository
{
  final PatientDataSource patientDatasource;

  PatientRepositoryImpl(this.patientDatasource);

  @override
  Future<List<Patient>> searchPatients(String query) async{
    return await patientDatasource.searchPatients(query);
  }
}