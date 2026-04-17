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
        itemCount: 2,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF262626),
                          ),
                        ),
                        Text(
                          "01 January, 2026",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(AppImages.deleteAccountIcon,height: 25.h,width: 25.w)
                  ],
                ),
                SizedBox(height: 12.h),
                CustomPaint(
                  painter: TicketPainter(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 175.h,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 65,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12.w, 15.h, 12.w, 15.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.black.withValues(alpha: 0.7), width: 1.w),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text("Event Ticket",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  Divider(
                                      color: const Color(0xFFBE1012),
                                      thickness: 2,
                                      height: 6.h,
                                      indent: 20.w,
                                      endIndent: 20.w
                                  ),
                                  FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text("TICKET",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 2)),
                                    ),
                                  ),
                                  Divider(
                                      color: const Color(0xFFBE1012),
                                      thickness: 2,
                                      height: 6.h,
                                      indent: 20.w,
                                      endIndent: 20.w
                                  ),
                                  FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text("Date - 1st Jan, 7-9 PM",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFFF7F4EF))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 35,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15.w, 15.h, 10.w, 15.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.black, width: 1.w),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "ADMIN ",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFFFFFFF))),
                                            TextSpan(
                                                text: "ONE",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000))),
                                          ]),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      BarcodeWidget(
                                        barcode: Barcode.code128(),
                                        data: 'A1234567890A',
                                        width: 30.w,
                                        height: 130.h,
                                        drawText: false,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5.w),
                                      RotatedBox(
                                        quarterTurns: 7,
                                        child: Text("A1234567890A",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFE5A11F), Color(0xFF0F4C5C)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    const double notchRadius = 10;
    final double notchCenterPath = size.width * 0.65;
    final path = Path()
      ..moveTo(15, 0)
      ..lineTo(notchCenterPath - notchRadius, 0)
      ..arcToPoint(Offset(notchCenterPath + notchRadius, 0),
          radius: const Radius.circular(notchRadius), clockwise: false)
      ..lineTo(size.width - 15, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 15)
      ..lineTo(size.width, size.height - 15)
      ..quadraticBezierTo(size.width, size.height, size.width - 15, size.height)
      ..lineTo(notchCenterPath + notchRadius, size.height)
      ..arcToPoint(Offset(notchCenterPath - notchRadius, size.height),
          radius: const Radius.circular(notchRadius), clockwise: false)
      ..lineTo(15, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 15)
      ..lineTo(0, 15)
      ..quadraticBezierTo(0, 0, 15, 0)
      ..close();
    canvas.drawPath(path, gradientPaint);
    final dashPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    double dashHeight = 4;
    double dashSpace = 4;
    double startY = 12;
    while (startY < size.height - 12) {
      canvas.drawLine(Offset(notchCenterPath, startY),
          Offset(notchCenterPath, startY + dashHeight), dashPaint);
      startY += dashHeight + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}