import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'login_screen.dart';

import '../../../patient/presentation/screens/patient_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>()..add(CheckSession()),

      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (_) => const PatientScreen()),
            );
          }

          if (state is AuthUnauthenticated) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },

        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
