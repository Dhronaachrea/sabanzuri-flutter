import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/utils.dart';

class PushNotification {
  static show({required String otp}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/infinity_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    var android = const AndroidNotificationDetails(
      '1',
      'OTP Notifications',
      priority: Priority.high,
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      playSound: true,
    );
    var iOS = const IOSNotificationDetails(presentAlert: true);
    var platform = NotificationDetails(android: android, iOS: iOS);
    BuildContext context = navigatorKey.currentContext!;
    await flutterLocalNotificationsPlugin.show(
      0,
      'Infiniti Lotto',
      context.l10n.otpNotification(otp),
      platform,
      payload: '',
    );
  }
}
