import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  List<NotificationItem> notifications = [];
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      update();

      ApiResponseModel response = await ApiService.get("/notification");

      if (response.isSuccess) {
        NotificationModel notificationModel = NotificationModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        if (notificationModel.success == true && notificationModel.data != null) {
          unreadCount.value = notificationModel.data?.unreadCount ?? 0;
          notifications = notificationModel.data?.notifications ?? [];
        }
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
  String formatTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour;
      String minuteStr = minute < 10 ? '0$minute' : '$minute';
      return '$hour:$minuteStr $period';
    } catch (e) {
      return "";
    }
  }
}