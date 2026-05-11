abstract class PatientEvent {}

class SearchPatientEvent extends PatientEvent
{
  final String query;
  SearchPatientEvent(this.query);
}