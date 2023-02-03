import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meau/services/notification_service.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<dynamic> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    var token = getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();

    return token;
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('=======================================');
    debugPrint('TOKEN FIREBASE: $token');
    debugPrint('=======================================');

    return token;
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      // Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}
