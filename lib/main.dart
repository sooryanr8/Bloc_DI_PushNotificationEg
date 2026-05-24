import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/notification/firebase_notification_service.dart';
import 'package:test1/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:test1/features/patient/presentation/bloc/patient_event.dart';
import 'core/di/injection_container.dart';
import 'core/notification/local_notification_service.dart';
import 'features/patient/presentation/bloc/patient_state.dart';

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  await sl<FirebaseNotificationService>().initialize();
  await sl<LocalNotificationService>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => sl<PatientBloc>(),
        child: const PatientScreen(),
      ),
    );
  }
}

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PatientBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Patient App")),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {

          await sl<LocalNotificationService>()
              .showNotification();

        },
        child: const Icon(Icons.notifications),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                else if(state is PatientEmpty)
                  {
                    return const Center(child: Text("There are no patients to show"));
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
