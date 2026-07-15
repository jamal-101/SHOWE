import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_string.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/constans/app_images.dart';

class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF0F4C5C),
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Image.asset(
                  AppImages.appLogo,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 48.w),
              ],
            ),
            Image.asset(AppImages.authSuccessImage),
            CommonText(
              text: AppString.congratulations,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F4C5C),
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(left: 50,right: 50),
              child: CommonText(
                text: AppString.yorPassHas,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            CommonButton(title: AppString.conti, onTap: (){
              Get.toNamed(AppRoutes.singUpLoginScreen);
            })
          ],
        ),
      ),
    );
  }
}
