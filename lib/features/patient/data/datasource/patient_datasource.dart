import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/url_constants.dart';
import '../../../../core/logger/logger_helper.dart';
import '../models/patient_model.dart';

class PatientDataSource {
  Future<List<PatientModel>> searchPatients(String query) async {
    final url = UrlConstants.patientSearch;

    logInfo('Calling API: $url');

    final response = await http.get(Uri.parse(url));

    logApi(method: 'GET', url: url, response: response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data as List).map((e) => PatientModel.fromJson(e)).toList();
    }

    throw Exception('Failed to load patients');
  }
}
