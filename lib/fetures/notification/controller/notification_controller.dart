import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../home/controller/hom_controller.dart';
import '../../home/screen/event_details_screen.dart';
import '../../home/screen/venue_details_screen.dart';
import '../../my_program/screen/red_web_screen.dart';
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
      }
      // else {
      //   Get.snackbar("Error", response.message);
      // }
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


  // void openNotificationUrl(BuildContext context, String? extraPath, {String? title}) {
  //   if (extraPath == null || extraPath.trim().isEmpty) return;
  //
  //   final String token = LocalStorage.token;
  //   String path = extraPath.trim();
  //   if (!path.startsWith('/')) {
  //     path = '/$path';
  //   }
  //   String finalUrl = "${ApiEndPoint.websiteUrl}$path";
  //   if (token.isNotEmpty) {
  //     finalUrl = "$finalUrl&token=${Uri.encodeComponent(token)}";
  //   }
  //   log("==========================================");
  //   log("GENERATED FULL URL: $finalUrl");
  //   log("==========================================");
  //   Get.to(() => ReaderWebScreen(
  //     readerUrl: finalUrl,
  //     title: title ?? "Reader",
  //   ));
  // }


  void openNotificationUrl(BuildContext context, String? extraPath, {String? title}) async {
    if (extraPath == null || extraPath.trim().isEmpty) return;

    String path = extraPath.trim();
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path.startsWith('/events/')) {
      final Uri uri = Uri.parse(path);
      final List<String> segments = uri.pathSegments;

      if (segments.length >= 2) {
        String eventId = segments[1];
        final HomController homeController = Get.find<HomController>();
        await homeController.fetchEventDetails(eventId);
        if (homeController.eventDetailsModel?.data != null) {
          Get.to(() => const EventDetailsScreen(), arguments: homeController.eventDetailsModel!.data);
        }
        return;
      }
    }

    if (path.startsWith('/venues/')) {
      final Uri uri = Uri.parse(path);
      final List<String> segments = uri.pathSegments;

      if (segments.length >= 2) {
        String venueId = segments[1];

        final HomController homeController = Get.put(HomController());

        await homeController.fetchVenueDetails(venueId);
        if (homeController.venueDetailsModel?.data != null) {
          Get.to(() => const VenueDetailsScreen());
        }
        return;
      }
    }
    final String token = LocalStorage.token;
    String finalUrl = "${ApiEndPoint.websiteUrl}$path";

    if (token.isNotEmpty) {
      String separator = finalUrl.contains('?') ? '&' : '?';
      finalUrl = "$finalUrl${separator}token=${Uri.encodeComponent(token)}";
    }

    log("==========================================");
    log("GENERATED WEBVIEW URL: $finalUrl");
    log("==========================================");

    // Get.to(() => ReaderWebScreen(
    //   readerUrl: finalUrl,
    //   title: title ?? "Reader",
    // ));
  }

}