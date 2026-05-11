import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/features/patient/domain/usecases/search_patient_usecase.dart';
import 'package:test1/features/patient/presentation/bloc/patient_event.dart';
import 'package:test1/features/patient/presentation/bloc/patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final SearchPatientUseCase searchPatientUseCase;

  PatientBloc(this.searchPatientUseCase) : super(PatientInitial()) {
    on<SearchPatientEvent>(_onSearchPatients);
  }

  Future<void> _onSearchPatients(
    SearchPatientEvent event,
    Emitter<PatientState> emit,
  ) async {
    final patients = await searchPatientUseCase(event.query);

    final filteredPatients = patients
        .where(
          (patient) =>
              patient.name.toLowerCase().contains(event.query.toLowerCase()),
        )
        .toList();
    if (filteredPatients.isEmpty) {
      emit(PatientEmpty());
    } else {
      emit(PatientLoaded(filteredPatients));
    }
  }
}
