import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_flip/page_flip.dart';
import '../../../core/constans/app_images.dart';
import '../controller/scan_controller.dart';

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
      ),
      body: GetBuilder<ScanController>(
        builder: (controller) {
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 1.sh,
                      child: PageFlipWidget(
                        key: controller.pageFlipKey,
                        backgroundColor: Colors.black,
                        lastPage: Container(
                          color: const Color(0xFF0F4C5C),
                          child: const Center(
                            child: Text(
                              'The End',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        children: [
                          for (var imagePath in controller.bookImages)
                            Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 1.sh,
                      child: Image.asset(
                        AppImages.myProgramImag,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 40.h,
              //   left: 16.w,
              //   right: 16.w,
              //   child: _buildDownloadButton(),
              // ),
            ],
          );
        },
      ),
    );
  }

  // Widget _buildDownloadButton() {
  //   return GestureDetector(
  //     onTap: () {
  //
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       height: 50.h,
  //       decoration: BoxDecoration(
  //         color: Colors.white.withValues(alpha: 0.8),
  //         border: Border.all(width: 1.w, color: Colors.black),
  //         borderRadius: BorderRadius.circular(25.r),
  //       ),
  //       child: Center(
  //         child: Text(
  //           "Download Now",
  //           style: GoogleFonts.montserrat(
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xFF0F4C5C),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
