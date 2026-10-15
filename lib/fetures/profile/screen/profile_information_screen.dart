// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:digital_event/core/utils/app_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:digital_event/core/global_widget/common_button.dart';
// import '../controller/profile_controller.dart';
//
// class UpdateProfileInformationScreen extends StatelessWidget {
//   const UpdateProfileInformationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.appBackgroundColor,
//         surfaceTintColor: AppColors.appBackgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           "Profile Information",
//           style: GoogleFonts.montserrat(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF0F4C5C),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: GetBuilder<ProfileController>(
//         init: ProfileController(),
//         builder: (controller) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 20.h),
//                           _buildLabel("Full Name"),
//                           TextFormField(
//                             validator: Utils.fullNameValidator,
//                             controller: controller.nameController,
//                             decoration: _inputDecoration("Mohammad Shakil"),
//                           ),
//                           // SizedBox(height: 20.h),
//                           // _buildLabel("Gender"),
//                           // DropDownButton(),
//                           SizedBox(height: 20.h),
//                           _buildLabel("Email"),
//                           TextFormField(
//                             validator: Utils.emailValidator,
//                             controller: controller.emailController,
//                             decoration: _inputDecoration("example.email123@gmail.com"),
//                           ),
//                           SizedBox(height: 20.h),
//                           _buildLabel("Phone"),
//                           TextFormField(
//                             validator: Utils.phoneValidator,
//                             controller: controller.phoneController,
//                             keyboardType: TextInputType.phone,
//                             decoration: _inputDecoration("+61 0000 000 00"),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20.h),
//                     child: CommonButton(
//                       isLoading: controller.isLoading.value,
//                       title: "Save Changes",
//                       onTap: () {
//                         controller.updateProfile();
//                         if (_formKey.currentState!.validate()) {
//                           controller.updateProfile();
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
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Text(
//         text,
//         style: GoogleFonts.montserrat(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w600,
//           color: const Color(0xFF1F2A37),
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: GoogleFonts.montserrat(color: Color(0xFF6B7280), fontSize: 16.sp,fontWeight: FontWeight.w500),
//       filled: true,
//       fillColor: const Color(0xFFF8F8F8),
//       contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15.r),
//         borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15.r),
//         borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15.r),
//         borderSide: const BorderSide(color: Color(0xFF0F4C5C)),
//       ),
//     );
//   }
// }

// class DropDownButton extends StatelessWidget {
//   const DropDownButton({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       builder: (controller) {
//         return Container(
//           height: 54.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF7F7F7),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 16.w),
//                 child: Obx(
//                       () => CommonText(
//                     text: controller.selectedGender.value,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: const Color(0xFF0F4C5C),
//                   ),
//                 ),
//               ),
//               PopupMenuButton<Gender>(
//                 offset: Offset(0, 50.h),
//                 elevation: 2,
//                 color: Colors.white,
//                 surfaceTintColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 icon: const Icon(
//                   Icons.keyboard_arrow_down,
//                   color: Color(0xFF0F4C5C),
//                 ),
//                 onSelected: (Gender value) {
//                   controller.updateSelectedGender(value);
//                 },
//                 itemBuilder: (context) => [
//                   _buildPopupItem(Gender.other, "Prefer not to say",showDivider: true),
//                   _buildPopupItem(Gender.female, "Female", showDivider: true),
//                   _buildPopupItem(Gender.male, "Male"),
//                 ].reversed.toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   PopupMenuItem<Gender> _buildPopupItem(Gender value, String text, {bool showDivider = false}) {
//     return PopupMenuItem(
//       value: value,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (showDivider) Divider(color: Colors.grey.shade200, thickness: 1),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.h),
//             child: CommonText(
//               text: text,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF6B7280),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:digital_event/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/api_enpoint.dart';
import '../controller/profile_controller.dart';

class UpdateProfileInformationScreen extends StatelessWidget {
  UpdateProfileInformationScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String pageTitle = Get.arguments ?? "Profile Information";
    final bool isEditeMode = pageTitle == "Update Profile";
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
          onPressed: () {
            Get.put(ProfileController()).getProfile();
            Get.back();
          },
        ),
        title: Text(
          pageTitle,
          style: GoogleFonts.montserrat(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            final String? networkImageUrl = controller.profileModel?.data?.image;
            ImageProvider? getProfileImageProvider() {
              if (controller.profileImage != null) {
                return FileImage(controller.profileImage!);
              } else if (networkImageUrl != null && networkImageUrl.isNotEmpty) {
                return NetworkImage(
                  ApiEndPoint.getImageUrl(networkImageUrl),
                );
              }
              return null;
            }
        
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        color: const Color(0xFF0F4C5C),
                        backgroundColor: Colors.white,
                        onRefresh: () async {
                          await Get.put(ProfileController()).getProfile();
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50.r,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage: getProfileImageProvider(),
                                      child: (controller.profileImage == null &&
                                          (networkImageUrl == null || networkImageUrl.isEmpty))
                                          ? Icon(
                                        Icons.person,
                                        size: 50.sp,
                                        color: Colors.grey[400],
                                      )
                                          : null,
                                    ),
                                    if (isEditeMode)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _showImagePickerBottomSheet(
                                            context,
                                            controller,
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 16.r,
                                          backgroundColor: const Color(0xFF0F4C5C),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25.h),
                              _buildLabel("Full Name"),
                              TextFormField(
                                readOnly: !isEditeMode,
                                // validator: Utils.fullNameValidator,
                                controller: controller.nameController,
                                decoration: _inputDecoration("Mohammad Shakil",isEditMode: isEditeMode),
                              ),
                              SizedBox(height: 20.h),
                              _buildLabel("Email"),
                              TextFormField(
                                readOnly: !isEditeMode,
                                // validator: Utils.emailValidator,
                                controller: controller.emailController,
                                decoration: _inputDecoration(
                                  "example.email123@gmail.com",
                                  isEditMode: isEditeMode
                                ),
                              ),
                              SizedBox(height: 20.h),
                              _buildLabel("Phone"),
                              TextFormField(
                                readOnly: !isEditeMode,
                                // validator: Utils.phoneValidator,
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: _inputDecoration("+61 0000 000 00",isEditMode: isEditeMode),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (pageTitle == "Update Profile")
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: CommonButton(
                        isLoading: controller.isLoading.value,
                        title: "Update Profile",
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {
                          controller.updateProfile();
                          // }
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
  void _showImagePickerBottomSheet(
    BuildContext context,
    ProfileController controller,
  )
  {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF0F4C5C),
                ),
                title: Text('Gallery', style: GoogleFonts.montserrat()),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: Color(0xFF0F4C5C),
                ),
                title: Text('Camera', style: GoogleFonts.montserrat()),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
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

  InputDecoration _inputDecoration(String hint,{bool isEditMode = true}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(
        color: const Color(0xFF6B7280),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
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
        borderSide: isEditMode
            ? const BorderSide(color: Color(0xFF0F4C5C))
            : BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }
}
