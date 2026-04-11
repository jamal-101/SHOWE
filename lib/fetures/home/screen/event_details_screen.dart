import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    final RxInt activeIndex = 0.obs;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HomController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: 5,
                      options: CarouselOptions(
                        height: 300.h,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          activeIndex.value = index;
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Image.asset(
                          data['image'],
                          height: 300.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex: activeIndex.value,
                            count: 5,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8.h,
                              dotWidth: 8.w,
                              activeDotColor: const Color(0xFFF2A900),
                              dotColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 20.w,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Positioned(
                      top: 50.h,
                      right: 20.w,
                      child: GestureDetector(
                        onTap: () => controller.toggleFavorite(data),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (data['isFavorite'] ?? false)
                                ? Image.asset(
                                    AppImages.unFavoriteIcon,
                                    color: Colors.white,
                                    height: 25.h,
                                    width: 25.w,
                                  )
                                : Image.asset(
                                    AppImages.selectFavoriteIcon,
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C7C7C1A).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CommonText(
                         text:  data['name'],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0F4C5C),
                          ),
                        ),
                      SizedBox(height: 10.h),
                      Text(
                        data['title'],
                        style: GoogleFonts.montserrat(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D2125),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildInfoTile(
                        AppImages.calender,
                        "${data['date']}, 2026",
                        "Friday, 4:00 PM - 6:00 PM",
                      ),
                      SizedBox(height: 15.h),
                      _buildInfoTile(
                        AppImages.location_1,
                        "Gala Convention Center",
                        "123 Golf Street, UK",
                        isFollow: true,
                      ),
                      SizedBox(height: 15.h),
                      _buildInfoTile(
                        AppImages.eventImage,
                        data['title'],
                        "Artist",
                        isFollow: true,
                        isFullImage: true,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "About event",
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "To have a successful hotel business in the modern age, it is essential to have a strong online Presence Guests ...",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: CommonButton(
          title: "Get Ticket - \$${data['price']}",
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    String imagePath,
    String title,
    String subTitle, {
    bool isFollow = false,
    bool isFullImage = false,
  }) {
    return Row(
      children: [
        Container(
          height: 50.h,
          width: 50.w,
          padding: isFullImage ? EdgeInsets.zero : EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFFE9F0F2),
            borderRadius: BorderRadius.circular(10.r),
            image: isFullImage
                ? DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: isFullImage
              ? null
              : Center(
                  child: Image.asset(imagePath, height: 24.h, width: 24.w),
                ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: const Color(0xFF1D2125),
                ),
              ),
              Text(
                subTitle,
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (isFollow)
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE9F0F2),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              "Follow",
              style: GoogleFonts.montserrat(
                color: const Color(0xFF0F4C5C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
