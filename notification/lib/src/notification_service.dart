import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Responsible for scheduling notifications using [FlutterLocalNotificationsPlugin].
class NotificationService {
  NotificationService(this._flutterLocalNotificationsPlugin);

  /// Android-specific settings
  static const channelId = "com.example.bibit_technical_test";
  static const channelName = "Alarm Notifications";
  static const channelDescription =
      "Alarm Notifications for Bibit Technical Test";

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> initialize(
    DidReceiveNotificationResponseCallback onDidReceiveNotificationResponse,
  ) async {
    tz.initializeTimeZones();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // use default settings
    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  /// Creates a scheduled local notification.
  ///
  /// [id] is the unique identifier for this notification.
  /// [title] is the notification title.
  /// [message] is the notification message, shown below title.
  /// [scheduledDate] is the date & time in local Timezone
  /// at which this notification will be triggered.
  /// [payload] (optional) can be retrieved when user taps on the notification.
  void scheduleNotification(
    int id,
    String title,
    String message,
    tz.TZDateTime scheduledDate,
    String? payload,
  ) async {
    debugPrint('scheduling for $scheduledDate');
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      message,
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
}
