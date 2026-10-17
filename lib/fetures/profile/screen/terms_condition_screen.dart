import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/fetures/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        surfaceTintColor: AppColors.appBackgroundColor,
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
          "Terms & Conditions",
          style: GoogleFonts.montserrat(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.termsConditionHtml.value.isEmpty && !controller.isTermsLoading.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.fetchTermsCondition();
            });
          }
          return controller.isTermsLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF0F4C5C),
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: HtmlWidget(
                    controller.termsConditionHtml.value.isNotEmpty
                        ? controller.termsConditionHtml.value
                        : "<p>No terms and conditions available.</p>",
                    textStyle: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F2A37),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
