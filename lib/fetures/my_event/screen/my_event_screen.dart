import 'package:barcode_widget/barcode_widget.dart';
import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/fetures/my_event/screen/widget/event_delete_dialog.dart';
import 'package:digital_event/fetures/my_event/screen/widget/ticket_plip_pop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/utils/api_enpoint.dart';
import '../controller/my_event_controller.dart';
class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyEventController());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.appBackgroundColor,
        automaticallyImplyLeading: false,
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
      body: GetBuilder<MyEventController>(
        builder: (controller) {
          return Obx(() {
            if (controller.isLoading.value && controller.ticketList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
              );
            }
            if (controller.ticketList.isEmpty) {
              return Center(
                child: Text(
                  "No Events Available",
                  style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey),
                ),
              );
            }

            return RefreshIndicator(
              color: const Color(0xFF0F4C5C),
              onRefresh: () async {
                await controller.fetchTickets();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: controller.scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      itemCount: controller.ticketList.length,
                      itemBuilder: (context, index) {
                        final ticket = controller.ticketList[index];
                        final String fullFileUrl = "${ApiEndPoint.imageUrl}${ticket.file ?? ""}";

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
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ticket.name ?? "Event Ticket",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          ticket.date != null && ticket.date!.isNotEmpty
                                              ? DateFormat('dd MMMM, yyyy').format(DateTime.parse(ticket.date!))
                                              : "Date TBA",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF6B7280),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.walletScreen,
                                              arguments: {
                                                "isEdit": true,
                                                "ticketId": ticket.sId,
                                                "name": ticket.name,
                                                "date": ticket.date,
                                                "file": ticket.file,
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit_note,color: Color(0xFF3F5362),size: 28.sp,),
                                        ),
                                        SizedBox(width: 10.w),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(EventDeleteDialog(index: index));
                                          },
                                          child: Image.asset(
                                            AppImages.deleteAccountIcon,
                                            height: 22.h,
                                            width: 22.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              GestureDetector(
                                onTap: () {
                                  if (ticket.file != null && ticket.file!.isNotEmpty) {
                                    Get.dialog(TicketFilePopup(fileUrl: fullFileUrl));
                                  } else {
                                    Get.snackbar("Info", "No ticket file attached.");
                                  }
                                },
                                child: CustomPaint(
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
                                                border: Border.all(
                                                  color: Colors.black54.withValues(alpha: 0.4),
                                                  width: 1.5.w,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 15),
                                                      child: Text(
                                                        ticket.name ?? "Event Ticket",
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 24.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: const Color(0xFFBE1012),
                                                    thickness: 2,
                                                    height: 6.h,
                                                    indent: 20.w,
                                                    endIndent: 20.w,
                                                  ),
                                                  FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 15),
                                                      child: Text(
                                                        "TICKET",
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 28.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                          letterSpacing: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: const Color(0xFFBE1012),
                                                    thickness: 2,
                                                    height: 6.h,
                                                    indent: 20.w,
                                                    endIndent: 20.w,
                                                  ),
                                                  FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 15),
                                                      child: Text(
                                                        ticket.date != null && ticket.date!.isNotEmpty
                                                            ? DateFormat('MMM dd, h:mm a').format(DateTime.parse(ticket.date!))
                                                            : "Date TBA",
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 13.sp,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xFFF7F4EF),
                                                        ),
                                                      ),
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
                                                border: Border.all(
                                                  color: Colors.black54.withValues(alpha: 0.4),
                                                  width: 1.5.w,
                                                ),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      RotatedBox(
                                                        quarterTurns: 3,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: "Admit ",
                                                                style: GoogleFonts.montserrat(
                                                                  fontSize: 20.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xFFFFFFFF),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: "ONE",
                                                                style: GoogleFonts.montserrat(
                                                                  fontSize: 20.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xFF000000),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      BarcodeWidget(
                                                        barcode: Barcode.code128(),
                                                        data: ticket.sId ?? 'A1234567890A',
                                                        width: 30.w,
                                                        height: 130.h,
                                                        drawText: false,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(width: 5.w),
                                                      RotatedBox(
                                                        quarterTurns: 7,
                                                        child: Text(
                                                          ticket.sId != null && ticket.sId!.length > 10
                                                              ? ticket.sId!.substring(0, 10).toUpperCase()
                                                              : "TICKET",
                                                          style: GoogleFonts.montserrat(
                                                            fontSize: 13.sp,
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
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  if (controller.isLoadMore.value)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: const CircularProgressIndicator(color: Color(0xFF0F4C5C)),
                    ),
                ],
              ),
            );
          });
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
      ..arcToPoint(
        Offset(notchCenterPath + notchRadius, 0),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(size.width - 15, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 15)
      ..lineTo(size.width, size.height - 15)
      ..quadraticBezierTo(size.width, size.height, size.width - 15, size.height)
      ..lineTo(notchCenterPath + notchRadius, size.height)
      ..arcToPoint(
        Offset(notchCenterPath - notchRadius, size.height),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
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
      canvas.drawLine(
        Offset(notchCenterPath, startY),
        Offset(notchCenterPath, startY + dashHeight),
        dashPaint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}