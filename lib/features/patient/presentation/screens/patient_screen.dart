import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/notification/local_notification_service.dart';

import '../bloc/patient_bloc.dart';
import '../bloc/patient_event.dart';
import '../bloc/patient_state.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PatientBloc>(),

      child: const _PatientView(),
    );
  }
}

class _PatientView extends StatelessWidget {
  const _PatientView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PatientBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Patient App")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await sl<LocalNotificationService>().showNotification();
        },

        child: const Icon(Icons.notifications),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),

            child: TextField(
              onChanged: (value) {
                bloc.add(SearchPatientEvent(value));
              },

              decoration: const InputDecoration(
                hintText: "Search patient...",

                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<PatientBloc, PatientState>(
              builder: (context, state) {
                if (state is PatientLoaded) {
                  return ListView.builder(
                    itemCount: state.patients.length,

                    itemBuilder: (context, index) {
                      final patient = state.patients[index];

                      return ListTile(title: Text(patient.name));
                    },
                  );
                }

                if (state is PatientEmpty) {
                  return const Center(
                    child: Text("There are no patients to show"),
                  );
                }

                return const Center(child: Text("Search Patients"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
