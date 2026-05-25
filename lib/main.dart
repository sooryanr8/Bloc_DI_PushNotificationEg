import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';

import 'core/logger/logger_helper.dart';
import 'core/notification/firebase_notification_service.dart';
import 'core/notification/local_notification_service.dart';

import 'features/auth/presentation/screens/splash_screen.dart';

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await LoggerHelper.initialize();

  init();

  await sl<FirebaseNotificationService>().initialize();

  await sl<LocalNotificationService>().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
    );
  }
}
