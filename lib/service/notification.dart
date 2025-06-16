import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather_forecast/main.dart';

Future<void> showWeatherNotification(String title, String body) async {
  if (!(Platform.isAndroid || Platform.isIOS)) return;

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'weather_alerts',
        'Hava Durumu Uyarıları',
        channelDescription: 'Şiddetli hava olayları için bildirimler',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}
