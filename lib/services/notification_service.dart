import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:meau/http_clients/dio_client.dart';
import 'package:meau/interfaces/http_client_interface.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.remoteMessage,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  final IHttpClient client;
  final DioClient dioClient = new DioClient();

  NotificationService(this.client) {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupAndroidDetails();
    _setupNotifications();
  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      // _onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      // Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(payload);
    }
  }

  showNotificationScheduled(CustomNotification notification, Duration duration) {
    final date = DateTime.now().add(duration);

    localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.local),
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  showLocalNotification(CustomNotification notification) {
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.notificationResponse!.payload);
    }
  }

  sendNotification(String title, String message, String tokenNotification) async {
    //Esse token fica localizado em: config do projeto -> cloud messaging -> chave do servidor

    // meau-8d974
    String token =
        "AAAA5ibyiPw:APA91bFh1yABxQdHATPDqJiikgVFJ4q-Fr3vPoj4vyLJufdkxc6JbZoC1JGNZ-Adp8ooS-ipy6efItxEl7MbzZd31hlv-imc6U0PV59AtwSttrUq2GWhs_YwHQDZ4rpvnkIligcIkuv2";

    // // meau-6c661
    // String token =
    //     "AAAAX7EDEcM:APA91bE_KwHBPyOizo9C7YWIUY4XBoAFqZlbBEV-7K7yO3baRbNC7rmhmR2Lc6pcjlXt4dN_GrFdRvvgcPadUQCO2fszQfNKcmhoCFcnwUkk3zvJaM93aPTJsiVc2W8gk8rbMOVIP_AY";

    // meau-472b4
    // String token =
    //     "AAAAgDdzT0I:APA91bF1eJdwLIBETqdB-6FT12Fv80uI5PthNxUvEk0Now7OZyWxaPhd9f2LEV2SGsfhT7yyEekKjDoERXmnCqVijK1hxQaAd7JdMP16I1QiO_JznftoJ2HZwgIhMOuIqMmykOEYbpFR";

    var res = await dioClient.post(
        "https://fcm.googleapis.com/fcm/send",
        {
          'notification': <String, dynamic>{'body': message, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": tokenNotification,
        },
        token);
  }
}
