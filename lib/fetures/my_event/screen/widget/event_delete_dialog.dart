import 'package:digital_event/fetures/my_event/controller/my_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDeleteDialog extends StatelessWidget {
  // final VoidCallback onDelete;
  final int index;

  const EventDeleteDialog({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    final MyEventController controller = Get.put(MyEventController());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ticket Delete",
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF5C5C),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Are you sure you want to delete the ticket?",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: const Color(0xFF1F2A37),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h)),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: const Color(0xFFF1F1F1)),
                Expanded(
                  child: TextButton(
                    onPressed:  (){
                      // controller.deleteEvent(index);
                      controller.deleteEvent(index);
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h)),
                    child: Text(
                      "Yes, Delete",
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        color: const Color(0xFFFF5C5C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}