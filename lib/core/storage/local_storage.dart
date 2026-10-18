import 'package:digital_event/core/storage/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../log/app_log.dart';
import 'package:uuid/uuid.dart';

class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String profileImage = "";
  static String deviceId = "";
  static SharedPreferences? preferences;
  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }
  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    myRole = localStorage.getString(LocalStorageKeys.myRole) ?? "";
    profileImage = localStorage.getString(LocalStorageKeys.profileImage) ?? "";
    deviceId = localStorage.getString(LocalStorageKeys.deviceId) ?? "";

    appLog(userId, source: "Local Storage");
  }
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();

    const List<String> userKeys = [
      LocalStorageKeys.token,
      LocalStorageKeys.refreshToken,
      LocalStorageKeys.isLogIn,
      LocalStorageKeys.userId,
      LocalStorageKeys.myImage,
      LocalStorageKeys.myName,
      LocalStorageKeys.myEmail,
      LocalStorageKeys.myRole,
      LocalStorageKeys.profileImage,
    ];

    for (final String key in userKeys) {
      await localStorage.remove(key);
    }
    _resetInMemoryData();
    await getAllPrefData();
  }


  static void _resetInMemoryData() {
    token = "";
    refreshToken = "";
    isLogIn = false;
    userId = "";
    myImage = "";
    myName = "";
    myEmail = "";
    myRole = "";
    profileImage = "";
  }

  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }


  static Future<void> resetDeviceIdForNewUser() async {
    const uuid = Uuid();
    String freshId = uuid.v4();
    await setString(LocalStorageKeys.deviceId, freshId);
    deviceId = freshId;
    print("🔄 Fresh Unique ID Generated for New User: $freshId");
  }

}









