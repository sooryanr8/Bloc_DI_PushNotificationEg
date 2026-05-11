import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {

    const AndroidInitializationSettings
    androidInitializationSettings =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
    initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin
        .initialize(
      settings: initializationSettings,
    );
  }

  Future<void> showNotification() async {

    const AndroidNotificationDetails
    androidNotificationDetails =
    AndroidNotificationDetails(
      'test_channel',
      'Test Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Hello',
      body: 'Push notification is working',
      notificationDetails: notificationDetails,
    );
  }
}