// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:digital_event/core/utils/app_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:digital_event/core/global_widget/common_button.dart';
// import '../controller/profile_controller.dart';
//
// class ChangePasswordScreen extends StatelessWidget {
//   const ChangePasswordScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     return Scaffold(
//       appBar: AppBar(
//        backgroundColor: AppColors.appBackgroundColor,
//         surfaceTintColor: AppColors.appBackgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           "Change Password",
//           style: GoogleFonts.montserrat(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             color: const Color(0xFF0F4C5C),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: GetBuilder<ProfileController>(
//         builder: (controller) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Form(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 10.h),
//                           Text(
//                             "Please set your new password",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF1F2A37),
//                             ),
//                           ),
//                           SizedBox(height: 30.h),
//                           _buildLabel("Current Password"),
//                           _buildPasswordField(
//                             validator: Utils.passwordValidator,
//                             controller: controller.currentPasswordController,
//                             hint: "****************",
//                           ),
//                           SizedBox(height: 20.h),
//                           _buildLabel("New Password"),
//                           _buildPasswordField(
//                             validator: Utils.passwordValidator,
//                             controller: controller.newPasswordController,
//                             hint: "****************",
//                           ),
//                           SizedBox(height: 20.h),
//                           _buildLabel("Confirm New Password"),
//                           _buildPasswordField(
//                             validator: (value) => Utils.confirmPasswordValidator(
//                               value,
//                               controller.newPasswordController.text,
//                             ),
//                             controller: controller.confirmPasswordController,
//                             hint: "****************",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20.h),
//                     child: CommonButton(
//                       isLoading: controller.isPasswordLoading.value,
//                       title: "Update Password",
//                       onTap: () {
//                         if (_formKey.currentState!.validate()) {
//                           controller.changePassword();
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildPasswordField({required TextEditingController controller, required String hint,required String? Function(String?)? validator,}) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       obscureText: true,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 14.sp),
//         filled: true,
//         fillColor: const Color(0xFFF8F8F8),
//         contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.r),
//           borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.r),
//           borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.r),
//           borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Text(
//         text,
//         style: GoogleFonts.montserrat(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w600,
//           color: Color(0xFF5C5C5C),
//         ),
//       ),
//     );
//   }
// }


import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import '../controller/profile_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  // 🔑 গ্লোবাল কি-টি build মেথডের বাইরে রাখা হলো যাতে স্টেট রিসেট না হয়
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        surfaceTintColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Change Password",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              "Please set your new password",
                              style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F2A37),
                              ),
                            ),
                            SizedBox(height: 30.h),
        
                            // 🔐 ১. Current Password
                            _buildLabel("Current Password"),
                            _buildPasswordField(
                              controller: controller.currentPasswordController,
                              hint: "****************",
                              validator: Utils.passwordValidator,
                              isObscure: controller.isCurrentObscure,
                              onSuffixTap: () => controller.toggleCurrentObscure(),
                            ),
                            SizedBox(height: 20.h),
        
                            // 🔐 ২. New Password
                            _buildLabel("New Password"),
                            _buildPasswordField(
                              controller: controller.newPasswordController,
                              hint: "****************",
                              validator: Utils.passwordValidator,
                              isObscure: controller.isNewObscure,
                              onSuffixTap: () => controller.toggleNewObscure(),
                            ),
                            SizedBox(height: 20.h),
        
                            // 🔐 ৩. Confirm New Password
                            _buildLabel("Confirm New Password"),
                            _buildPasswordField(
                              controller: controller.confirmPasswordController,
                              hint: "****************",
                              validator: (value) => Utils.confirmPasswordValidator(
                                value,
                                controller.newPasswordController.text,
                              ),
                              isObscure: controller.isConfirmObscure,
                              onSuffixTap: () => controller.toggleConfirmObscure(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: CommonButton(
                        isLoading: controller.isPasswordLoading.value,
                        title: "Update Password",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.changePassword();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 🛠️ obscure এবং suffix icon প্যারামিটার সহ মডিফাইড মেথড
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?)? validator,
    required bool isObscure,
    required VoidCallback onSuffixTap,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscure, // ডায়নামিক obscure স্টেট
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),

        // 👁️ চোখের আইকন হ্যান্ডলিং
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFF6B7280),
            size: 20.sp,
          ),
          onPressed: onSuffixTap,
        ),

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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
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
          color: const Color(0xFF5C5C5C),
        ),
      ),
    );
  }
}