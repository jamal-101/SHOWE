// import 'package:flutter/cupertino.dart';
// import 'app.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_event/core/storage/storage_key.dart';
import 'core/storage/local_storage.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await saveDeviceIdOnStartup();
  await LocalStorage.getAllPrefData();
  runApp(const MyApp());
}

Future<void> saveDeviceIdOnStartup() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String id = "";

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? "";
    }
    if (id.isNotEmpty) {
      await LocalStorage.setString(LocalStorageKeys.deviceId, id);

      print("=========================================");
      print("📱 Device ID Saved in main.dart: $id");
      print("=========================================");
    }
  } catch (e) {
    print("❌ Error storing device id in main.dart: $e");
  }
}