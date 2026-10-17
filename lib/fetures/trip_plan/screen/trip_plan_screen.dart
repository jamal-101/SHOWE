import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/fetures/home/screen/venue_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../home/controller/hom_controller.dart';
import '../../home/model/venue_model.dart' as VenueModel;
import '../controller/trip_plan_controller.dart';

class TripPlanScreen extends StatelessWidget {
  const TripPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      appBar: AppBar(
        surfaceTintColor: AppColors.appBackgroundColor,
        backgroundColor: AppColors.appBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Trip Planner",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<TripPlanController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.searchIcon,
                        height: 25.h,
                        width: 25.w,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => controller.searchVenue(value),
                          decoration: InputDecoration(
                            hintText: "Search venue",
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Venues",
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
                      );
                    }
                    if (controller.venues.isEmpty) {
                      return const Center(child: Text("No venues found"));
                    }
                    return ListView.builder(
                      controller: controller.scrollController, // 🔹 Scroll Controller সংযুক্ত করা হলো
                      itemCount: controller.venues.length +
                          (controller.isMoreLoading.value ? 1 : 0),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // নিচে স্ক্রল করলে নিচের দিকে ছোট সার্কুলার প্রোগ্রেস দেখাবে
                        if (index == controller.venues.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF0F4C5C),
                              ),
                            ),
                          );
                        }
                        return _buildVenueItem(controller.venues[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVenueItem(VenueModel.Data data) {
    return GestureDetector(
      onTap: () async {
        if (data.sId != null) {
          final homController = Get.isRegistered<HomController>()
              ? Get.find<HomController>()
              : Get.put(HomController());
          await homController.fetchVenueDetails(data.sId!);
          if (homController.venueDetailsModel?.data != null) {
            Get.to(
                  () => const VenueDetailsScreen(),
              arguments: data,
            );
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F0F2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? "Unknown Venue",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D2125),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    [data.city, data.state, data.country]
                        .where((field) => field != null && field.trim().isNotEmpty)
                        .join(', '),
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data.createdAt != null && data.createdAt!.isNotEmpty
                        ? DateFormat('dd MMMM, yyyy')
                        .format(DateTime.parse(data.createdAt!))
                        : "No Date Provided",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF0F4C5C),
                    size: 22,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF0F4C5C),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}