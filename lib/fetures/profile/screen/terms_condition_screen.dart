import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/fetures/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonText(text: 'The Showe Group Ltd',fontSize: 16.sp,fontWeight: FontWeight.w700,color: Color(0xFF000000),),
                SizedBox(height: 20.h),
                CommonText(
                  text: """Version 1.0 — From 2/2/20
These Terms of Use (“Terms”) govern your use of the SHOWE mobile application and related services (“App”).
By creating an account or using the App, you agree to these Terms.
If you do not agree, do not use the App.""",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Color(0xFF1F2A37),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
