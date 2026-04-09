import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem("Events", true),
                _buildTabItem("Artists", false),
                _buildTabItem("Venues", false),
              ],
            ),
            const Divider(thickness: 1, height: 1, color: Color(0xFFE0E0E0)),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildEventCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTabItem(String title, bool isActive) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? const Color(0xFFF2A900) : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 2,
            width: double.infinity,
            color: isActive ? const Color(0xFFF2A900) : Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
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
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
              ),
            ),
          ),
          Positioned(
            top: 15.h,
            right: 15.w,
            child: Icon(Icons.favorite_border, color: Colors.white, size: 24.sp),
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
                  child: Text("Music", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                ),
                SizedBox(height: 5.h),
                Text(
                  "The Rolling Stones Live in Concert",
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
                        Text("Dec 18 - 08:00 PM", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                      ],
                    ),
                    Text("\$120.00", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}