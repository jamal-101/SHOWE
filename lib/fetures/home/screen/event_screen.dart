import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:digital_event/fetures/home/screen/venue_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'event_details_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0F4C5C),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Popular Events",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomController>(
        init: HomController(),
        builder: (controller) {
          List<Map<String, dynamic>> currentData = [];
          if (controller.selectedTabIndex == 0) {
            currentData = controller.eventData;
          } else if (controller.selectedTabIndex == 1) {
            currentData = controller.artistData;
          } else {
            currentData = controller.venuesData;
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFF8F8F8),
                //     borderRadius: BorderRadius.circular(30.r),
                //   ),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       hintText: controller.selectedTabIndex == 2
                //           ? "Search venue"
                //           : "Search",
                //       hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                //       border: InputBorder.none,
                //       icon: const Icon(Icons.search, color: Colors.grey),
                //     ),
                //   ),
                //
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: controller.selectedTabIndex == 2
                                      ? "Search venue"
                                      : "Search",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (controller.selectedTabIndex == 2) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: VerticalDivider(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  thickness: 1,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showCalendarDialog(context);
                                },
                                icon: Image.asset( AppImages.searchCalender,height: 25.h,width: 25.w,),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem(
                      "Events",
                      controller.selectedTabIndex == 0,
                      0,
                      controller,
                    ),
                    _buildTabItem(
                      "Artists",
                      controller.selectedTabIndex == 1,
                      1,
                      controller,
                    ),
                    _buildTabItem(
                      "Venues",
                      controller.selectedTabIndex == 2,
                      2,
                      controller,
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xFFE0E0E0),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentData.length,
                    itemBuilder: (context, index) {
                      if (controller.selectedTabIndex == 2) {
                        return _buildVenueCard(currentData[index]);
                      } else {
                        return _buildEventCard(currentData[index]);
                      }
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

  Widget _buildTabItem(
    String title,
    bool isActive,
    int index,
    HomController controller,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? const Color(0xFFF2A900) : Colors.grey,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 2,
                width: double.infinity,
                color: isActive ? const Color(0xFFF2A900) : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> data) {
    return GetBuilder<HomController>(
      init: HomController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(EventDetailsScreen(), arguments: data);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            height: 180.h,
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
                          data['name'],
                          style: TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        data['title'],
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        data['subtitle'],
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
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "${data['date']} - ${data['time']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
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
      },
    );
  }

  Widget _buildVenueCard(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: (){
        Get.to(VenueDetailsScreen(),arguments: data);
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
                    data['name'] ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D2125),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['address'] ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['date'] ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Image.asset(AppImages.location, height: 30.h, width: 30.w),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF0F4C5C),
              size: 18,
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
        child: GetBuilder<HomController>(
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
