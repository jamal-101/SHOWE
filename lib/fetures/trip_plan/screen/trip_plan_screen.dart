import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/fetures/home/screen/venue_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../controller/trip_plan_controller.dart';

class TripPlanScreen extends StatelessWidget {
  const TripPlanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TripPlanController());
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      appBar: AppBar(
        surfaceTintColor: AppColors.appBackgroundColor,
        backgroundColor: AppColors.appBackgroundColor,
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
                      Container(
                        height: 20.h,
                        width: 1,
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: () => _showCalendarDialog(context),
                        child: Image.asset(
                          AppImages.searchCalender,
                          height: 20.h,
                          width: 20.w,
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
                  child: ListView.builder(
                    itemCount: controller.venues.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildVenueItem(controller.venues[index]);
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

  Widget _buildVenueItem(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () => Get.to(VenueDetailsScreen(), arguments: data),
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
                    data['name'] ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D2125),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['address'] ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['date'] ?? "",
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

  void _showCalendarDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: GetBuilder<TripPlanController>(
          builder: (controller) {
            return Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.focusedDay = DateTime(
                            controller.focusedDay.year,
                            controller.focusedDay.month - 1,
                          );
                          controller.update();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Color(0xFF0F4C5C),
                        ),
                      ),
                      Text(
                        DateFormat('MMMM, yyyy').format(controller.focusedDay),
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F4C5C),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.focusedDay = DateTime(
                            controller.focusedDay.year,
                            controller.focusedDay.month + 1,
                          );
                          controller.update();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFF0F4C5C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay, day),
                    onDaySelected: controller.onDaySelected,
                    headerVisible: false,
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF0F4C5C),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: const Color(0xFF0F4C5C).withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2A900),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        "Search",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
