import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/profile/controller/profile_controller.dart';
import 'package:digital_event/fetures/profile/widget/account_logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/api_enpoint.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../home/controller/hom_controller.dart';
import '../widget/account_delet_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.appBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(
            color: const Color(0xFF0F4C5C),
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                SizedBox(height: 20.h),
                _buildSectionHeader("General"),
                _buildSettingsGroup([
                  _buildListTile(
                    AppImages.personIcon,
                    "Profile Information",
                    0,
                  ),
                  _buildListTile(
                    AppImages.changePassIcon,
                    "Change Password",
                    1,
                  ),
                  _buildListTile(AppImages.notificationIcon, "Notification", 2),
                  _buildListTile(AppImages.securityIcon, "Security", 3),
                ]),
                SizedBox(height: 20.h),
                _buildSectionHeader("Others"),
                _buildSettingsGroup([
                  // _buildListTile(AppImages.helpCenterIcon, "Help Centre", 4),
                  _buildListTile(
                    AppImages.privacyPolicyIcon,
                    "Privacy policy",
                    5,
                  ),
                  _buildListTile(
                    AppImages.termsConditionIcon,
                    "Terms & Conditions",
                    6,
                  ),
                ]),
                SizedBox(height: 20.h),
                _buildSettingsGroup([
                  _buildListTile(
                    AppImages.deleteAccountIcon,
                    "Delete Account",
                    7,
                  ),
                  _buildListTile(
                    AppImages.logoutIcon,
                    "Logout",
                    8,
                    isLogout: true,
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        final userData = controller.profileModel?.data;
        final String profileName = userData?.name ?? "Guest User";
        final String profileEmail = userData?.email ?? "guest@gmail.com";
        final String? profileImage = userData?.image;

        return Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    (profileImage != null && profileImage.isNotEmpty)
                    ? NetworkImage(ApiEndPoint.getImageUrl(profileImage))
                          as ImageProvider
                    : AssetImage(AppImages.profileImage),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          profileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final ProfileController controller = Get.put(ProfileController());
                            controller.clearSelectedImage();
                            controller.getProfile();
                            Get.toNamed(AppRoutes.updateProfileInformationScreen,arguments: "Update Profile",);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                AppImages.editeProfileIcon,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      profileEmail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 5.w),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          color: const Color(0xFF0F4C5C).withValues(alpha: 0.7),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    String imagePath,
    String title,
    int index, {
    bool isLogout = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 22.w,
          height: 22.w,
          color: isLogout ? Colors.redAccent : const Color(0xFF000000),
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            color: isLogout ? Colors.redAccent : const Color(0xFF1F2A37),
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          switch (index) {
            case 0:
              final ProfileController controller = Get.put(ProfileController());
              controller.clearSelectedImage(); 
              controller.getProfile();
              Get.toNamed(AppRoutes.updateProfileInformationScreen);
              break;
            case 1:
              Get.toNamed(AppRoutes.changePasswordScreen);
              break;
            case 2:
              Get.toNamed(AppRoutes.notificationSettingScreen);
              break;
            case 3:
              Get.toNamed(AppRoutes.securityScreen);
              break;
            case 4:
              Get.toNamed(AppRoutes.helpCenterScreen);
              break;
            case 5:
              Get.toNamed(AppRoutes.privacyPolicyScreen);
              break;
            case 6:
              Get.toNamed(AppRoutes.termsConditionScreen);
              break;
            case 7:
              Get.dialog(const DeleteAccountDialog());
              break;
            case 8:
              Get.dialog(AccountLogoutDialog());
              break;
            default:
          }
        },
      ),
    );
  }
}
