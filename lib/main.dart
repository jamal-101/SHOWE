
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_event/core/storage/storage_key.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/storage/local_storage.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    serverClientId: '755395683027-rt3bfjjp7qismr49qp66c03a3r081vb3.apps.googleusercontent.com',
  );
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