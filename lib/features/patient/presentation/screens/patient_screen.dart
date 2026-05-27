import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/session_manager.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/notification/local_notification_service.dart';

import '../../../../core/routes/app_routes.dart';
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

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,

      builder: (_) => AlertDialog(
        title: const Text("Logout"),

        content: const Text("Are you sure you want to logout?"),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },

            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },

            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await sl<SessionManager>().logout();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
          (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PatientBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient App"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),

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
