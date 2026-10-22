import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // ১. প্লাগইন ইনিশিয়ালাইজ করা
    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // নোটিফিকেশনে ট্যাপ করলে এখানে হ্যান্ডেল করতে পারেন
      },
    );

    // ২. আইওএসের প্ল্যাটফর্ম স্পেসিফিক পারমিশন রিকোয়েস্ট
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
    _notificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    await iosImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  } // 👈 initialize() মেথডের এই বন্ধনীটি (closing brace) এখানে দিতে হবে

  static void showNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      await _notificationsPlugin.show(
        id: id,
        title: message.notification?.title ?? message.data['title'],
        body: message.notification?.body ?? message.data['message'],
        notificationDetails: notificationDetails,
      );
    } catch (e) {
      print('Error displaying notification: $e');
    }
  }
} // 👈 ক্লাসের শেষের বন্ধনী