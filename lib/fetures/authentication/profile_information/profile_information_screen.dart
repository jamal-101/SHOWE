import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/profile_information/profile_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common_text/common_text.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Set your Profile",
          style: GoogleFonts.montserrat(
            color: const Color(0xFF0F4C5C),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child:
        CommonButton(title: "Next", onTap: () {
          Get.toNamed(AppRoutes.setFaceRecognition);
        }),
      ),
      body: GetBuilder<ProfileInformationController>(
        init: ProfileInformationController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                _buildLabel("Full Name"),
                _buildTextField(hint: "Mohammad Shakil"),
                SizedBox(height: 20.h),
                _buildLabel("Gender"),
                DropDownGender(),
                SizedBox(height: 20.h),
                _buildLabel("Email"),
                _buildTextField(hint: "example.email123@gmail.com"),
                SizedBox(height: 20.h),
                _buildLabel("Phone"),
                _buildTextField(hint: "+61 0000 000 00"),
                SizedBox(height: 20.h),
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
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F4C5C),
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class DropDownGender extends StatelessWidget {
  const DropDownGender({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileInformationController>(
      builder: (controller) {
        return Container(
          height: 54.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Obx(
                      () => CommonText(
                    text: controller.selectedGender.value,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF0F4C5C),
                  ),
                ),
              ),
              PopupMenuButton<Gender>(
                offset: Offset(0, 50.h),
                elevation: 2,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF0F4C5C),
                ),
                onSelected: (Gender value) {
                  controller.updateSelectedGender(value);
                },
                itemBuilder: (context) => [
                  _buildPopupItem(Gender.other, "Prefer not to say",showDivider: true),
                  _buildPopupItem(Gender.female, "Female", showDivider: true),
                  _buildPopupItem(Gender.male, "Male"),
                ].reversed.toList(),
              ),
            ],
          ),
        );
      },
    );
  }
  PopupMenuItem<Gender> _buildPopupItem(Gender value, String text, {bool showDivider = false}) {
    return PopupMenuItem(
      value: value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showDivider) Divider(color: Colors.grey.shade200, thickness: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: CommonText(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}