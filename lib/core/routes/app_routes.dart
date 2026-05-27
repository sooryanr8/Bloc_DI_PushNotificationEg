import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/patient/presentation/screens/patient_screen.dart';

class AppRoutes {

  static const splash = '/';

  static const login = '/login';

  static const patient = '/patient';

  static Route<dynamic> generateRoute(
      RouteSettings settings,
      ) {

    switch (settings.name) {

      case splash:
        return MaterialPageRoute(
          builder: (_) =>
          const SplashScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) =>
          const LoginScreen(),
        );

      case patient:
        return MaterialPageRoute(
          builder: (_) =>
          const PatientScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(
              child: Text(
                'Route not found',
              ),
            ),
          ),
        );
    }
  }
}