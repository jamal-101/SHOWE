import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import '../../../core/common_text/common_text.dart';
import '../controller/profile_controller.dart';

class UpdateProfileInformationScreen extends StatelessWidget {
  const UpdateProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Profile Information",
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildLabel("Full Name"),
                        TextField(
                          // controller: controller.nameController,
                          decoration: _inputDecoration("Mohammad Shakil"),
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Gender"),
                        DropDownButton(),
                        SizedBox(height: 20.h),
                        _buildLabel("Email"),
                        TextField(
                          // controller: controller.emailController,
                          decoration: _inputDecoration("example.email123@gmail.com"),
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Phone"),
                        TextFormField(
                          // controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _inputDecoration("+61 0000 000 00"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CommonButton(
                    title: "Save Changes",
                    onTap: () {
                    },
                  ),
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
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1F2A37),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(color: Color(0xFF6B7280), fontSize: 16.sp,fontWeight: FontWeight.w500),
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(color: Color(0xFF0F4C5C)),
      ),
    );
  }
}

class DropDownButton extends StatelessWidget {
  const DropDownButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}