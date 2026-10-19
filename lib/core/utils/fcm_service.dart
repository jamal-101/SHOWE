import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  /// Fetches and prints the FCM Token to console for testing push notifications.
  static Future<String?> getAndPrintFCMToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request permission for iOS & Android notifications
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('🔔 FCM Permission Status: ${settings.authorizationStatus}');

      // Configure foreground notification presentation options for iOS
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get FCM Token
      String? token = await messaging.getToken();

      debugPrint("==================================================");
      debugPrint("🔥 FCM TOKEN FOR PUSH NOTIFICATION TEST:");
      debugPrint("$token");
      debugPrint("==================================================");

      return token;
    } catch (e) {
      debugPrint("❌ Error fetching FCM Token: $e");
      return null;
    }
  }
}
