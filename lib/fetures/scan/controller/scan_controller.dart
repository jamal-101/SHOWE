import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../../home/controller/hom_controller.dart';
import '../../home/screen/event_details_screen.dart';
class ScanController extends GetxController {

  Future<void> startQRScan(BuildContext context) async {
    await Get.to(
          () => AiBarcodeScanner(
        onDetect: (BarcodeCapture capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            String scannedLink = barcodes.first.rawValue!;
            Get.back();
            if (scannedLink.isNotEmpty) {
              String eventId = _extractIdFromUrl(scannedLink);
              if (eventId.isNotEmpty) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  _fetchAndNavigateToDetails(eventId);
                });
              } else {
                Get.snackbar("Error", "Could not find a Event");
              }
            }
          }
        },
      ),
    );
  }

  String _extractIdFromUrl(String url) {
    try {
      Uri uri = Uri.parse(url.trim());
      if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last;
      }
      return url.trim();
    } catch (e) {
      String cleanUrl = url.split('?').first;
      if (cleanUrl.contains('/')) {
        return cleanUrl.split('/').last.trim();
      }
      return cleanUrl.trim();
    }
  }

  Future<void> _fetchAndNavigateToDetails(String id) async {
    try {
      final HomController homeController = Get.isRegistered<HomController>()
          ? Get.find<HomController>()
          : Get.put(HomController());
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Color(0xFF0F4C5C))),
        barrierDismissible: false,
      );
      await homeController.fetchEventDetails(id);
      if (Get.isDialogOpen ?? false) Get.back();
      if (homeController.eventDetailsModel?.data != null) {
        Get.to(
              () => const EventDetailsScreen(),
          arguments: homeController.eventDetailsModel!.data,
        );
      } else {
        Get.snackbar("Failed", "Event details not found for this ID.");
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar("Error", "Something went wrong while fetching data.");
    }
  }

  bool isPurchased = false;
  void setPurchaseStatus(bool status) {
    isPurchased = status;
    update();
  }
}