import 'package:digital_event/core/storage/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../log/app_log.dart';


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

  // Create Local Storage Instance
  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
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

  /// Remove All Data From SharedPreferences
  // static Future<void> removeAllPrefData() async {
  //   final localStorage = await _getStorage();
  //   await localStorage.clear();
  //   _resetLocalStorageData();
  //   await getAllPrefData();
  // }

  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();

    // শুধু deviceId টি সেভ করে রাখুন
    String? currentDeviceId = localStorage.getString(LocalStorageKeys.deviceId);

    // সব ডাটা মুছে ফেলুন
    await localStorage.clear();

    // deviceId টি আবার পুনরায় সেট করুন
    if (currentDeviceId != null) {
      await localStorage.setString(LocalStorageKeys.deviceId, currentDeviceId);
    }

    _resetLocalStorageData();
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    // localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
    localStorage.setString(LocalStorageKeys.myRole, "");
    localStorage.setString(LocalStorageKeys.profileImage, "");
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
}
