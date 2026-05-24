import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import '../../../patient/presentation/screens/patient_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PatientScreen()),
              );
            }
          },

          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TextField(
                  controller: usernameController,

                  decoration: const InputDecoration(labelText: "Username"),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,

                  obscureText: true,

                  decoration: const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          context.read<AuthBloc>().add(
                            LoginPressed(
                              username: usernameController.text,

                              password: passwordController.text,
                            ),
                          );
                        },

                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),

                if (state is AuthError)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),

                    child: Text(state.message),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
