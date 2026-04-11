import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/my_event_controller.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C)),
        title: Text("My Events", style: GoogleFonts.montserrat(color: const Color(0xFF0F4C5C), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GetBuilder<MyEventController>(
        init: MyEventController(),
        builder: (controller) {
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: 1, // আপনার ডাটা অনুযায়ী হবে
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 2))],
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Music Event Ticket", style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                            Text("01 January, 2026", style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey)),
                          ],
                        ),
                        const Icon(Icons.delete_outline, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ClipPath(
                      clipper: TicketClipper(),
                      child: Container(
                        height: 180.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF2A900), Color(0xFF0F4C5C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Stack(
                          children: [
                            // বাম পাশের ইমেজ/ডিজাইন
                            // Positioned(
                            //   left: 10, top: 10, bottom: 10,
                            //   child: Image.asset("assets/images/ticket_design.png", fit: BoxFit.contain),
                            //   // আপনি এখানে আপলোড করা ইমেজটিও দিতে পারেন
                            // ),
                            Positioned(
                              left: (MediaQuery.of(context).size.width - 70.w) * 0.65,
                              top: 10, bottom: 10,
                              child: Column(
                                children: List.generate(15, (index) => Container(
                                  width: 1, height: 5,
                                  color: Colors.white.withValues(alpha: 0.5),
                                  margin: const EdgeInsets.symmetric(vertical: 2),
                                )),
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
          );
        },
      ),
    );
  }
}





class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double radius = 10;
    path.lineTo(size.width * 0.65 - radius, size.height);
    path.arcToPoint(Offset(size.width * 0.65 + radius, size.height),
        radius: Radius.circular(radius), clockwise: false);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.lineTo(size.width * 0.65 + radius, 0);
    path.arcToPoint(Offset(size.width * 0.65 - radius, 0),
        radius: Radius.circular(radius), clockwise: false);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}