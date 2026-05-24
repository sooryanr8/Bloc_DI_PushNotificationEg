import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/patient_model.dart';

class PatientDataSource {

  Future<List<PatientModel>> searchPatients(
      String query,
      ) async {

    final response = await http.get(
      Uri.parse(
        'http://192.168.1.39:8000/patients',
      ),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return (data as List)
          .map(
            (e) => PatientModel.fromJson(e),
      )
          .toList();

    } else {

      throw Exception(
        'Failed to load patients',
      );
    }
  }
}