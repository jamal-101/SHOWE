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
      backgroundColor: AppColors.appBackgroundColor,
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
                        final bool isPdf = (ticket.file ?? "").toLowerCase().endsWith('.pdf');

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
                                          child: Icon(Icons.edit_note, color: const Color(0xFF3F5362), size: 28.sp),
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
                                onTap: isPdf
                                    ? () {
                                  if (ticket.file != null && ticket.file!.isNotEmpty) {
                                    Get.dialog(TicketFilePopup(fileUrl: fullFileUrl));
                                  } else {
                                    Get.snackbar("Info", "No ticket file attached.");
                                  }
                                }
                                    : null,

                                child: Container(
                                  width: double.infinity,
                                  height: 175.h,
                                  decoration: BoxDecoration(
                                    color: isPdf ? const Color(0xFFF3F4F6) : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: Colors.grey.shade300, width: 1.w),
                                  ),
                                  child: isPdf
                                      ? _buildPdfPlaceholder()
                                      : _buildImagePlaceholder(fullFileUrl),
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

  Widget _buildPdfPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.picture_as_pdf,
            color: const Color(0xFFBE1012),
            size: 54.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            "View PDF Ticket",
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F4C5C),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Tap to open document",
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
          );
        },
        errorBuilder: (context, error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.broken_image, size: 40, color: Colors.grey),
              SizedBox(height: 4.h),
              Text(
                "Failed to load image ticket",
                style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}