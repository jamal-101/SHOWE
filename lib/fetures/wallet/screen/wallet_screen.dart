import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/route/app_routes.dart';
import '../controller/wallet_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0F4C5C),
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Wallet",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.myEventScreen);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.eventsIcon, height: 25.h, width: 25.w),
                  CommonText(
                    text: "My Events",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2A37),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<WalletController>(
        init: WalletController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Upload your tickets to My Events for\neasy access",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1D2125),
                  ),
                ),
                const Divider(height: 40, thickness: 1),
                _buildLabel("Event name"),
                TextField(
                  controller: controller.eventNameController,
                  decoration: _inputDecoration("e.g. Rolling Stones Tour"),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    CommonText(
                      text: 'Note : ',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Color(0xFF1C1C1C),
                    ),
                    CommonText(
                      text:
                          'Label the event so you can find it easily in My Events.',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Color(0xFF6B7280),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildLabel("Event Date"),
                GestureDetector(
                  onTap: () => controller.selectDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: controller.formattedDate,
                          color: Color(0xFF6B7280),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF0F4C5C),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => controller.uploadTicket(),
                  child: Container(
                    height: 180.h,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DottedBorder(
                      options: RectDottedBorderOptions(
                        dashPattern: [10, 5],
                        strokeWidth: 1,
                      ),
                      child: controller.pickedImage != null
                          ? Stack(
                              children: [
                                Image.file(
                                  controller.pickedImage!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  child: const Center(
                                    child: Icon(
                                      Icons.sync,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.linkIcon,
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                  Text(
                                    "Upload ticket",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CommonButton(
                  title: "Upload",
                  onTap:(){
                    Get.toNamed(AppRoutes.myEventScreen);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F4C5C),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(
        color: Color(0xFF6B7280),
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(15),
        ),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
