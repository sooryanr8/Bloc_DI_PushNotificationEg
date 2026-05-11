import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async{
    await _requestPermission();
    await _getFcmToken();
    _listenForegroundMessages();
  }

  Future<void> _requestPermission() async{
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true
    );
    print("Notification Permission: " "${settings.authorizationStatus}",
    );
  }

  Future<void> _getFcmToken() async {
    String? token = await firebaseMessaging.getToken();
    print("FCM Token");
    print(token);
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen(
        (RemoteMessage message)
            {
              print("Foreground Notification Received");
              print("TITLE : ${message.notification?.title}");
              print("BODY : ${message.notification?.body}");
            }
    );
  }
}