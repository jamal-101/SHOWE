import 'package:digital_event/core/constans/app_images.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  // নোটিফিকেশন ডাটা লিস্ট
  final List<Map<String, String>> notifications = [
    {
      "title": "Booking Confirmation",
      "subtitle": "Your booking request has been confirmed",
      "time": "8:20 AM",
      "icon": AppImages.hotelImage,
    },
    {
      "title": "Payment Successful",
      "subtitle": "Your payment has been successfully done.",
      "time": "8:20 AM",
      "icon": AppImages.myWalletImage,
    },
    {
      "title": "Enjoy 30% off",
      "subtitle": "Enjoy Up to 30% off in Abc Event",
      "time": "8:20 AM",
      "icon": AppImages.calender,
    },
    {
      "title": "Santa Maria sent a message",
      "subtitle": "Enjoy Up to 30% off in Santa Maria Resort",
      "time": "8:20 AM",
      "icon": AppImages.bellIcon,
    },
  ];
}