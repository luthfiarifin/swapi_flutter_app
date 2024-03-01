import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/common/model/reminder_model.dart';

@lazySingleton
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _configureLocalTimeZone();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    await requestPermissions();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      final plugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (plugin != null) {
        await plugin.requestNotificationsPermission();
      }
    }
  }

  Future<void> scheduleNotification(ReminderModel reminder) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.id,
      'A reminder for you!',
      'It\'s time to do something!',
      _getTimeZoneDateTime(reminder.time),
      const NotificationDetails(
        android: AndroidNotificationDetails('swapi-id', 'swapi-channel-id'),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    debugPrint('onDidReceiveNotificationResponse: $details');
  }

  Future<void> cancelNotification(int id, String? tag) async {
    await flutterLocalNotificationsPlugin.cancel(id, tag: tag);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  tz.TZDateTime _getTimeZoneDateTime(DateTime time) {
    return tz.TZDateTime(
      tz.local,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
    );
  }
}
