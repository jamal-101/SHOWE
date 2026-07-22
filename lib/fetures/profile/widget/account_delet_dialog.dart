// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class DeleteAccountDialog extends StatelessWidget {
//   final VoidCallback onDelete;
//
//   const DeleteAccountDialog({super.key, required this.onDelete});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Container(
//         padding: EdgeInsets.only(top: 20.h),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // টাইটেল: Account Delete
//             Text(
//               "Account Delete",
//               style: GoogleFonts.montserrat(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFFFF5C5C),
//               ),
//             ),
//             SizedBox(height: 15.h),
//
//             // বর্ণনা
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Text(
//                 "Are you sure you want to delete your account?",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14.sp,
//                   color: const Color(0xFF1F2A37),
//                 ),
//               ),
//             ),
//             SizedBox(height: 25.h),
//
//             // বাটন সেকশন
//             const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
//             Row(
//               children: [
//                 // Cancel বাটন
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => Get.back(),
//                     style: TextButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 15.h)),
//                     child: Text(
//                       "Cancel",
//                       style: GoogleFonts.montserrat(
//                         fontSize: 15.sp,
//                         color: const Color(0xFF9CA3AF),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // মাঝের বর্ডার
//                 Container(width: 1, height: 50, color: const Color(0xFFF1F1F1)),
//
//                 // Yes, Delete বাটন
//                 Expanded(
//                   child: TextButton(
//                     onPressed: onDelete,
//                     style: TextButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 15.h)),
//                     child: Text(
//                       "Yes, Delete",
//                       style: GoogleFonts.montserrat(
//                         fontSize: 15.sp,
//                         color: const Color(0xFFFF5C5C),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/profile_controller.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // এখানে Get.find ব্যবহার করা ভালো, কারণ ProfileScreen এ এটি অলরেডি ইনিশিয়েট করা আছে
    final ProfileController profileController = Get.find<ProfileController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // টাইটেল
              Text(
                "Account Delete",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF5C5C),
                ),
              ),
              SizedBox(height: 15.h),

              // বর্ণনা
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Are you sure you want to delete your account? This action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 20.h),

              // 🔐 পাসওয়ার্ড টেক্সট ফিল্ড (স্টেট আপডেটের জন্য GetBuilder ব্যবহার করা হয়েছে)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GetBuilder<ProfileController>(
                  builder: (controller) {
                    return TextFormField(
                      controller: controller.deleteAccountController,
                      obscureText: controller.isCurrentObscure,
                      autofocus: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: const Color(0xFF1F2A37),
                      ),
                      decoration: InputDecoration(
                        hintText: "Your Password",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.toggleCurrentObscure();
                          },
                          icon: Icon(
                            controller.isCurrentObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Color(0xFFFF5C5C), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password is required to proceed";
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 25.h),

              const Divider(height: 1, thickness: 1),

              // বাটন সেকশন
              Row(
                children: [
                  // Cancel বাটন
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        profileController.deleteAccountController.clear(); // ইনপুট ক্লিয়ার
                        Get.back();
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15.h)),
                      child: Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                    ),
                  ),
                  Container(width: 1, height: 50, color: Colors.grey.shade200),

                  // Yes, Delete বাটন (লোডিং স্টেট দেখানোর জন্য Obx ব্যবহার করা হয়েছে)
                  Expanded(
                    child: Obx(() {
                      return profileController.isDeleteLoading.value
                          ? const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                        ),
                      )
                          : TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            profileController.deleteAccount(
                              profileController.deleteAccountController.text.trim(),
                            );
                          }
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15.h)),
                        child: Text(
                          "Yes, Delete",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}