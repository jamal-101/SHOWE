import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Events",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 22.h),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Music Event Ticket",
                            style: GoogleFonts.montserrat(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2A37),
                            ),
                          ),
                          Text(
                            "01 January, 2026",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.delete_outline,
                        color: Color(0xFF0F4C5C),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190.h,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(AppImages.myProgramImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 30,
                                  left: 15,
                                  top: 12,
                                  bottom: 12,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      width: 1.5.w,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Music",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Image.asset(
                                              AppImages.eventTextImage,
                                              height: 60.h,
                                              width: 60.w,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 1,
                                          color: Color(0xFFBE1012),
                                          thickness: 3,
                                          endIndent: 25,
                                        ),
                                        Text(
                                          "TICKET",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Divider(
                                          color: Color(0xFFBE1012),
                                          height: 1,
                                          thickness: 3,
                                          endIndent: 25,
                                        ),
                                        SizedBox(height: 10.h),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 14,
                                            top: 4,
                                          ),
                                          child: Text(
                                            "Date - 1st Jan, 7-9 PM",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFFF7F4EF),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.h, left: 25.w, right: 10.w, bottom: 0.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(width: 2, color: const Color(0xFF062027)),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "ADMIN",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "ONE",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          BarcodeWidget(
                                            barcode: Barcode.code128(),
                                            data: 'A1234567890A',
                                            width: 25.w,
                                            height: 120.h,
                                            drawText: false,
                                          ),
                                          SizedBox(width: 2.w),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              "A1234567890A",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
