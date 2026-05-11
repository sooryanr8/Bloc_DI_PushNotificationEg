import '../models/patient_model.dart';

class PatientDataSource {
  Future<List<PatientModel>> searchPatients(String query) async
  {
    return [
      PatientModel(id: "1", name: "Soorya"),
      PatientModel(id: "2", name: "Akshay"),
      PatientModel(id: "3", name: "Nikhil")
    ];
  }
}