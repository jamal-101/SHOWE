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
import '../../my_program/controller/Theatre_Controller.dart';
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

    // Uri.parse handles both a relative path ("/reader/<id>?page=4") and a
    // full external URL ("https://showe-web.vercel.app/reader/<id>?page=4")
    // uniformly, so we can read pathSegments/queryParameters either way.
    final String raw = extraPath.trim();
    final Uri? parsedUri = Uri.tryParse(raw);
    final List<String> segments = parsedUri?.pathSegments ?? [];

    String path = raw;
    if (!path.startsWith('/') && !path.startsWith('http')) {
      path = '/$path';
    }

    if (segments.length >= 2 && segments[segments.length - 2] == 'events') {
      String eventId = segments.last;
      final HomController homeController = Get.find<HomController>();
      await homeController.fetchEventDetails(eventId);
      if (homeController.eventDetailsModel?.data != null) {
        Get.to(() => const EventDetailsScreen(), arguments: homeController.eventDetailsModel!.data);
      }
      return;
    }

    if (segments.length >= 2 && segments[segments.length - 2] == 'venues') {
      String venueId = segments.last;
      final HomController homeController = Get.put(HomController());
      await homeController.fetchVenueDetails(venueId);
      if (homeController.venueDetailsModel?.data != null) {
        Get.to(() => const VenueDetailsScreen());
      }
      return;
    }

    if (segments.length >= 2 && segments[segments.length - 2] == 'reader') {
      final String programmeId = segments.last;
      final String? pageParam = parsedUri?.queryParameters['page'];
      int? initialPageIndex;
      final int? pageNumber = pageParam != null ? int.tryParse(pageParam) : null;
      // "page" in these links is 1-based (Page 1, Page 2...), ReaderPage wants a 0-based index.
      if (pageNumber != null && pageNumber > 0) {
        initialPageIndex = pageNumber - 1;
      }

      final TheatreController theatreController = Get.isRegistered<TheatreController>()
          ? Get.find<TheatreController>()
          : Get.put(TheatreController());

      theatreController.openReaderUrl(
        context,
        programmeId,
        title: title,
        initialPageIndex: initialPageIndex,
      );
      return;
    }

    // Anything we don't specifically recognise — open it in the in-app
    // webview instead of silently doing nothing.
    String webviewUrl = path;
    if (parsedUri == null || !parsedUri.hasScheme) {
      final String token = LocalStorage.token;
      webviewUrl = "${ApiEndPoint.websiteUrl}$path";
      if (token.isNotEmpty) {
        String separator = webviewUrl.contains('?') ? '&' : '?';
        webviewUrl = "$webviewUrl${separator}token=${Uri.encodeComponent(token)}";
      }
    }

    Get.to(() => ReaderWebScreen(
      readerUrl: webviewUrl,
      title: title ?? "Reader",
    ));
  }

}