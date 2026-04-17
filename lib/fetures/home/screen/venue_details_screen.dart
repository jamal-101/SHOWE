import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/hom_controller.dart';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments ?? {};
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          "Venues",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF0F4C5C),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'] ?? "Gala Convention Center",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        data['address'] ?? "123 Golf Street, UK",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9F0F2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: const Text(
                    "Follow",
                    style: TextStyle(color: Color(0xFF0F4C5C)),
                  ),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),
            _buildSectionTitle("Map"),
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: const DecorationImage(
                  image: AssetImage(AppImages.mapImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle("Transport Information"),
            _buildBulletPoint("Public Transport"),
            _buildBulletPoint("Parking"),
            SizedBox(height: 20.h),
            _buildSectionTitle("Events"),
            _buildEventCard(),
            SizedBox(height: 20.h),
            _buildSectionTitle("Nearby Restaurants"),
            Row(
              children: [
                _buildSmallCard("Cafe Rio", AppImages.eventImage),
                SizedBox(width: 15.w),
                _buildSmallCard("Cieolo", AppImages.artistImage),
              ],
            ),
            SizedBox(height: 10.h),
            _buildSectionTitle("Recommended Hotels"),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return _buildWideCard(
                    "Inter Continental Hotel",
                    AppImages.hotelImage,
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle("Nearby Bars"),
            Row(
              children: [
                _buildSmallCard("Galaxy bar", AppImages.eventImage),
                SizedBox(width: 15.w),
                _buildSmallCard("Erram", AppImages.artistImage),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.grey),
          SizedBox(width: 10.w),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(String name, String imagePath) {
    return Expanded(
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(10.w),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
    return GetBuilder<HomController>(
      init: HomController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            // Get.to(EventDetailsScreen(), arguments: data);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: AssetImage(AppImages.eventImage),
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
                    // onTap: () => controller.toggleFavorite(data),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            // (data['isFavorite'] ?? false)
                            //     ? Image.asset(
                            //   AppImages.unFavoriteIcon,
                            //   color: Colors.white,
                            //   height: 25.h,
                            //   width: 25.w,
                            // )
                            //     :
                            Image.asset(
                              AppImages.selectFavoriteIcon,
                              height: 25.h,
                              width: 25.w,
                            ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'Music',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'The Weekend Vibes Concert',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // Text(
                      //   data['subtitle'],
                      //   style: GoogleFonts.montserrat(
                      //     color: Colors.white,
                      //     fontSize: 16.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Dec 18  - 08:00 PM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$120.00",
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
      },
    );
  }

  Widget _buildWideCard(String name, String imagePath) {
    return Container(
      height: 100.h,
      width: 300.w,
      margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10.w),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
