import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        surfaceTintColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
            );
          }

          if (controller.notifications.isEmpty) {
            return Center(
              child: Text(
                "No notifications available",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: const Color(0xFF767676),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchNotifications();
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: controller.notifications.length,
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 0.8,
                color: Color(0xFFEEEEEE),
              ),
              itemBuilder: (context, index) {
                NotificationItem item = controller.notifications[index];

                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (item.extraPath != null && item.extraPath!.isNotEmpty) {
                      controller.openNotificationUrl(
                        context,
                        item.extraPath,
                        title: item.title,
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: const AssetImage(AppImages.bellIcon),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title ?? "Notification",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16.sp,
                                        fontWeight: (item.isRead ?? false)
                                            ? FontWeight.w500
                                            : FontWeight.bold,
                                        color: const Color(0xFF333333),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    controller.formatTime(item.createdAt),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF767676),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                item.message ?? "",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF767676),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}