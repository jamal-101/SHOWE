import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digital_event/core/storage/storage_key.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/storage/local_storage.dart';
import 'core/utils/fcm_service.dart';
import 'app.dart';
import 'core/utils/local_notification_service.dart';
import 'firebase_options.dart';
import 'package:uuid/uuid.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocalNotificationService.initialize();

  await GoogleSignIn.instance.initialize(
    serverClientId: '755395683027-rt3bfjjp7qismr49qp66c03a3r081vb3.apps.googleusercontent.com',
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await saveDeviceIdOnStartup();
  await LocalStorage.getAllPrefData();
  if (LocalStorage.isLogIn) {
    FCMService.getAndPrintFCMToken();
  }

  // App khola obosthay push ashle
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("🔔 [FOREGROUND] title: ${message.notification?.title}");
    debugPrint("🔔 [FOREGROUND] body: ${message.notification?.body}");
    debugPrint("🔔 [FOREGROUND] data: ${message.data}");

    LocalNotificationService.showNotification(message);
    // LocalNotificationService.showNotification(message);
  });

// Background e thaka obosthay notification e tap korle
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("🔔 [TAPPED] title: ${message.notification?.title}");
    debugPrint("🔔 [TAPPED] data: ${message.data}");
  });

// App bondho (terminated) thakar por notification e tap kore khulle
  final initial = await FirebaseMessaging.instance.getInitialMessage();
  if (initial != null) {
    debugPrint("🔔 [LAUNCHED FROM PUSH] title: ${initial.notification?.title}");
    debugPrint("🔔 [LAUNCHED FROM PUSH] data: ${initial.data}");
  }


  runApp(const MyApp());
}

// Future<void> saveDeviceIdOnStartup() async {
//   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   String id = "";
//
//   try {
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       id = androidInfo.id;
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       id = iosInfo.identifierForVendor ?? "";
//     }
//     if (id.isNotEmpty) {
//       await LocalStorage.setString(LocalStorageKeys.deviceId, id);
//
//       print("=========================================");
//       print("📱 Device ID Saved in main.dart: $id");
//       print("=========================================");
//     }
//   } catch (e) {
//     print("❌ Error storing device id in main.dart: $e");
//   }
// }


Future<void> saveDeviceIdOnStartup() async {
  final prefs = await SharedPreferences.getInstance();
  String? existingId = prefs.getString(LocalStorageKeys.deviceId);

  // যদি ডিভাইসে আগে থেকে কোনো আইডি না থাকে, তবে নতুন ইউনিক আইডি তৈরি করুন
  if (existingId == null || existingId.isEmpty) {
    const uuid = Uuid();
    String newUniqueId = uuid.v4();
    await LocalStorage.setString(LocalStorageKeys.deviceId, newUniqueId);

    print("=========================================");
    print("📱 Generated New Unique Device/Session ID: $newUniqueId");
    print("=========================================");
  } else {
    print("=========================================");
    print("📱 Existing Device ID Loaded: $existingId");
    print("=========================================");
  }
}




@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("🔔 [BACKGROUND] title: ${message.notification?.title}");
  debugPrint("🔔 [BACKGROUND] body: ${message.notification?.body}");
  debugPrint("🔔 [BACKGROUND] data: ${message.data}");
}