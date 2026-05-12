import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/constans/app_string.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:digital_event/fetures/home/screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistProfileView extends StatelessWidget {
  const ArtistProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> artistData = Get.arguments ?? {};
    return GetBuilder<HomController>(
      builder: (controller){
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildArtistHeader(artistData,controller),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    SizedBox(height: 10.h),
                    _buildSectionTitle("About"),
                    CommonText(
                      textAlign: TextAlign.start,
                      text: artistData['about'] ?? AppString.venuAboutText,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF767676),
                    ),
                    SizedBox(height: 20.h),
                    _buildSectionTitle("Events"),
                    GetBuilder<HomController>(
                      builder: (controller) {
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: controller.eventData.take(2).length,
                          itemBuilder: (context, index) {
                            var event = controller.eventData[index];
                            return _buildEventCard(event, controller);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      }
    );
  }
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1D2125),
        ),
      ),
    );
  }

  Widget _buildArtistHeader(Map<String, dynamic> data, HomController controller) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 250.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(data['image'] ?? AppImages.eventImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 10.h),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 210.h),
          padding: EdgeInsets.only(bottom: 20.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 90.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      data['image'] ?? AppImages.artistImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data['title'] ?? "Chester Bennington",
                        style: GoogleFonts.montserrat(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D2125),
                        ),
                      ),
                      Text(
                        "Artist",
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controller.toggleFavorite(data);
                  },
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Color(0xFF00000033).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: (data['isFavorite'] ?? false)
                        ? Image.asset(
                      AppImages.unFavoriteIcon,
                      color: Colors.white,
                      height: 25.h,
                      width: 25.w,
                    ) :
                    Image.asset(
                      AppImages.selectFavoriteIcon,
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildEventCard(Map<String, dynamic> data, HomController controller) {
    return GestureDetector(
      onTap: () {
        Get.to(const EventDetailsScreen(), arguments: data);
      },
      child: Container(
        height: 160.h,
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: AssetImage(data['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              right: 15.w,
              child: GestureDetector(
                onTap: () => controller.toggleFavorite(data),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: (data['isFavorite'] ?? false)
                      ? Image.asset(
                    AppImages.unFavoriteIcon,
                    color: Colors.white,
                    height: 25.h,
                    width: 25.w,
                  ) :
                  Image.asset(
                    AppImages.selectFavoriteIcon,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15.h,
              left: 15.w,
              right: 15.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      data['name'] ?? "Music",
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['title'] ?? "Concert Title",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white, size: 14.sp),
                          SizedBox(width: 5.w),
                          Text(
                            "${data['date']} - ${data['time']}",
                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Text(
                        "\$${data['price']}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}