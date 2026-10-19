// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:digital_event/core/common_text/common_text.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/fetures/home/controller/hom_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:digital_event/core/global_widget/common_button.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class EventDetailsScreen extends StatelessWidget {
//   const EventDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> data = Get.arguments ?? {};
//     final RxInt activeIndex = 0.obs;
//     return Scaffold(
//       body: GetBuilder<HomController>(
//         builder: (controller) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     CarouselSlider.builder(
//                       itemCount: 5,
//                       options: CarouselOptions(
//                         height: 300.h,
//                         viewportFraction: 1,
//                         autoPlay: true,
//                         onPageChanged: (index, reason) {
//                           activeIndex.value = index;
//                         },
//                       ),
//                       itemBuilder: (context, index, realIndex) {
//                         return Image.asset(
//                           data['image'] ?? AppImages.eventImage,
//                           height: 300.h,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         );
//                       },
//                     ),
//                     Positioned(
//                       bottom: 20.h,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Obx(
//                           () => AnimatedSmoothIndicator(
//                             activeIndex: activeIndex.value,
//                             count: 5,
//                             effect: ExpandingDotsEffect(
//                               dotHeight: 8.h,
//                               dotWidth: 8.w,
//                               activeDotColor: const Color(0xFFF2A900),
//                               dotColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 50.h,
//                       left: 20.w,
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         ),
//                         onPressed: () => Get.back(),
//                       ),
//                     ),
//                     Positioned(
//                       top: 50.h,
//                       right: 20.w,
//                       child: GestureDetector(
//                         onTap: () => controller.toggleFavorite(data),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withValues(alpha: 0.2),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: (data['isFavorite'] ?? false)
//                                 ? Image.asset(
//                                     AppImages.unFavoriteIcon,
//                                     color: Colors.white,
//                                     height: 25.h,
//                                     width: 25.w,
//                                   )
//                                 : Image.asset(
//                                     AppImages.selectFavoriteIcon,
//                                     height: 25.h,
//                                     width: 25.w,
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(20.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12.w,
//                           vertical: 4.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(
//                             0xFF7C7C7C1A,
//                           ).withValues(alpha: 0.1),
//                           borderRadius: BorderRadius.circular(5.r),
//                         ),
//                         child: CommonText(
//                           text: data['name'] ?? "Event",
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF0F4C5C),
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       Text(
//                         data['title']?? "Event Details",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF1D2125),
//                         ),
//                       ),
//                       SizedBox(height: 20.h),
//                       _buildInfoTile(
//                         AppImages.calender,
//                         "${data['date'] ?? 'TBA'}, 2026",
//                         "Friday, 4:00 PM - 6:00 PM",
//                       ),
//                       SizedBox(height: 15.h),
//                       _buildInfoTile(
//                         AppImages.location_1,
//                         data['address'] ?? "Gala Convention Center",
//                         "123 Golf Street, UK",
//                         isFollow: true,
//                       ),
//                       SizedBox(height: 15.h),
//                       _buildInfoTile(
//                         data['artistImage'] ?? AppImages.artistImage,
//                         data['artistName'] ?? "Artist Name",
//                         "Artist",
//                         isFollow: true,
//                         isFullImage: true,
//                       ),
//                       SizedBox(height: 25.h),
//                       Text(
//                         "About event",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       Text(
//                         "To have a successful hotel business in the modern age, it is essential to have a strong online Presence Guests ...",
//                         style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: CommonButton(
//           title: "Get Ticket - \$${data['price']} ?? '0,00",
//           onTap: () {},
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoTile(
//     String imagePath,
//     String title,
//     String subTitle, {
//     bool isFollow = false,
//     bool isFullImage = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           height: 50.h,
//           width: 50.w,
//           padding: isFullImage ? EdgeInsets.zero : EdgeInsets.all(10.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFE9F0F2),
//             borderRadius: BorderRadius.circular(10.r),
//             image: isFullImage
//                 ? DecorationImage(
//                     image: AssetImage(imagePath),
//                     fit: BoxFit.cover,
//                   )
//                 : null,
//           ),
//           child: isFullImage
//               ? null
//               : Center(
//                   child: Image.asset(imagePath, height: 24.h, width: 24.w),
//                 ),
//         ),
//         SizedBox(width: 15.w),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: GoogleFonts.montserrat(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.sp,
//                   color: const Color(0xFF1D2125),
//                 ),
//               ),
//               Text(
//                 subTitle,
//                 style: GoogleFonts.montserrat(
//                   color: Colors.grey,
//                   fontSize: 12.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (isFollow)
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFE9F0F2),
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//             ),
//             child: Text(
//               "Follow",
//               style: GoogleFonts.montserrat(
//                 color: const Color(0xFF0F4C5C),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
//
//
//

import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/api_enpoint.dart';
import '../model/event_details_model.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt activeIndex = 0.obs;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomController>(
          builder: (controller) {
            if (controller.isDetailsLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
              );
            }
            if (controller.eventDetailsModel == null ||
                controller.eventDetailsModel!.data == null) {
              return const Center(child: Text("Event details not found"));
            }
        
            final Data eventData = controller.eventDetailsModel!.data!;
            final detailData = controller.eventDetailsModel?.data;
            if (detailData == null) return const SizedBox();
            final List<String> images =
                (eventData.gallery != null && eventData.gallery!.isNotEmpty)
                ? eventData.gallery!
                : (eventData.coverImage != null ? [eventData.coverImage!] : []);
        
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (images.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: images.length,
                          options: CarouselOptions(
                            height: 300.h,
                            viewportFraction: 1,
                            autoPlay: images.length > 1,
                            onPageChanged: (index, reason) {
                              activeIndex.value = index;
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final String fullImageUrl =
                                ApiEndPoint.getImageUrl(images[index]);
                            return Image.network(
                              fullImageUrl,
                              height: 300.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                            );
                          },
                        )
                      else
                        Container(
                          height: 300.h,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      if (images.length > 1)
                        Positioned(
                          bottom: 20.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Obx(
                              () => AnimatedSmoothIndicator(
                                activeIndex: activeIndex.value,
                                count: images.length,
                                effect: ExpandingDotsEffect(
                                  dotHeight: 8.h,
                                  dotWidth: 8.w,
                                  activeDotColor: const Color(0xFFF2A900),
                                  dotColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 50.h,
                        left: 20.w,
                        child: GestureDetector(
                          onTap: (){
                            Get.find<HomController>().fetchEvents(isRefresh: true);
                                  Navigator.pop(context);
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.5)
                            ),child: Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: Icon(Icons.arrow_back_ios,size: 20.sp,color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50.h,
                        right: 20.w,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(detailData);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (detailData.isFavorited ?? false)
                                  ? Image.asset(
                                      AppImages.selectFavoriteIcon,
                                      height: 25.h,
                                      width: 25.w,
                                    )
                                  : Image.asset(
                                      AppImages.unFavoriteIcon,
                                      height: 25.h,
                                      width: 25.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (eventData.category != null &&
                            eventData.category!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF7C7C7C1A,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CommonText(
                              text: eventData.category!,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF0F4C5C),
                            ),
                          ),
                        SizedBox(height: 10.h),
                        Text(
                          eventData.title ?? "Event Details",
                          style: GoogleFonts.montserrat(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D2125),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildInfoTile(
                          imagePath: AppImages.calender,
                          title: eventData.eventDate != null
                              ? DateFormat(
                                  'EEEE, MMM dd, yyyy',
                                ).format(DateTime.parse(eventData.eventDate!))
                              : 'TBA',
                          subTitle:
                              (eventData.performances != null &&
                                  eventData.performances!.isNotEmpty)
                              ? "${eventData.performances!.first.startTime ?? ''} - ${eventData.performances!.first.endTime ?? ''} (${eventData.performances!.first.type ?? ''})"
                              : "Time TBA",
                        ),
                        SizedBox(height: 15.h),
                        _buildInfoTile(
                          imagePath: AppImages.location_1,
                          title: eventData.vanue?.name ?? "Venue TBA",
                          subTitle:
                              eventData.address ??
                              eventData.vanue?.addressLine1 ??
                              "Address TBA",
                        ),
                        SizedBox(height: 15.h),
                        if (eventData.artist != null)
                          _buildInfoTile(
                            imagePath: eventData.artist?.image != null
                                ? ApiEndPoint.getImageUrl(eventData.artist!.image)
                                : AppImages.artistImage,
                            title: eventData.artist?.name ?? "Unknown Artist",
                            subTitle: eventData.artist?.type ?? "Artist",
                            isFollow: false,
                            isNetworkImage: eventData.artist?.image != null,
                            // onFollowTap: () {
                            //   // Follow button logic
                            // },
                          ),
                        SizedBox(height: 25.h),
                        Text(
                          "About event",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        HtmlWidget(
                          (eventData.descriptionHtml != null && eventData.descriptionHtml!.isNotEmpty)
                              ? eventData.descriptionHtml!
                              : "No description available for this event.",
                          textStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                        ),
                        _buildNearbySection(
                          "Nearby Restaurants",
                          eventData.nearbyRestaurants?.map((res) => _NearbyItem(
                            name: res.name,
                            image: res.image,
                            rating: res.rating?.toString(),
                            distance: res.distance,
                            website: res.website,
                          )).toList(),
                          controller,
                        ),
                         _buildNearbySection(
                            "Nearby Hotels",
                            eventData.nearbyHotels?.map((hotel) => _NearbyItem(
                              name: hotel.name,
                              image: hotel.image,
                              rating: hotel.rating,
                              distance: hotel.distance,
                              website: hotel.website,
                            )).toList(),controller,
                          ),
        
                        _buildNearbySection(
                          "Nearby Bars",
                          eventData.nearbyBars?.map((bar) => _NearbyItem(
                            name: bar.name,
                            image: bar.image,
                            rating: bar.rating,
                            distance: bar.distance,
                          )).toList(),controller,
                        ),
                        SizedBox(height: 20.h),
                        _buildInfoTile(
                          imagePath:
                              (eventData.author?.image != null &&
                                  eventData.author!.image!.isNotEmpty)
                              ? ApiEndPoint.getImageUrl(eventData.author!.image)
                              : AppImages.artistImage,
                          title: eventData.author?.name ?? "Artist Name",
                          subTitle: "Organizer",
                          isFollow: false,
                          isNetworkImage:
                              eventData.author?.image != null &&
                              eventData.author!.image!.isNotEmpty,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<HomController>(
        builder: (controller) {
          if (controller.eventDetailsModel?.data == null) {
            return const SizedBox.shrink();
          }
          final eventData = controller.eventDetailsModel!.data!;
          final price = eventData.price;
          final eventId = eventData.sId;
          final ticketUrl = eventData.getTicketsUrl;
          final isPurchased = eventData.isAlreadyProgrammePurchased ?? false;

          final bool hasProgramme = (eventData.programme != null && eventData.programme!.isNotEmpty) ||
              (eventData.programmeData != null);

          final double programmePrice = eventData.pricePence != null
              ? (eventData.pricePence! / 100)
              : (eventData.price?.toDouble() ?? 0.0);

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (isPurchased)
                    if (hasProgramme && isPurchased)
                      GestureDetector(
                        onTap: () {
                         Get.toNamed(AppRoutes.myProgramScreen);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF009661),
                            borderRadius: BorderRadius.circular(500.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.r),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Purchased • View Programmes",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      )
                    // else
                    else if (hasProgramme && !isPurchased)
                      GestureDetector(
                        onTap: () {
                          if (controller.isPurchaseLoading.value) return;
                          if (eventId != null && eventId.isNotEmpty) {
                            controller.purchaseTicket(eventId, eventData.price ?? 0);
                          } else {
                            Get.snackbar(
                              "Error",
                              "Invalid Event ID",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500.r),
                            border: Border.all(
                              width: 1.w,
                              color: const Color(0xFF0F4C5C),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              controller.isPurchaseLoading.value
                                  ? "Purchase Programme..."
                                  // : "Purchase Programme - £${eventData.price ?? 0}",
                                  : "Purchase Programme - £${programmePrice.toStringAsFixed(2)}",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: const Color(0xFF0F4C5C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // SizedBox(height: 10.h,),
                    if (hasProgramme) SizedBox(height: 10.h),
                    CommonButton(
                      title: controller.ticketIsPurchaseLoading.value
                          ? "Processing..."
                          : "Get Ticket - £${price ?? 0}",
                      onTap: () {
                        if (controller.ticketIsPurchaseLoading.value) return;
                        controller.openTicketUrl(ticketUrl);

                      },
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }


  Widget _buildInfoTile({
    required String imagePath,
    required String title,
    required String subTitle,
    bool isFollow = false,
    bool isNetworkImage = false,
  }) {
    return Row(
      children: [
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F0F2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: isNetworkImage
                ? Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        Image.asset(AppImages.artistImage, fit: BoxFit.cover),
                  )
                : Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: const Color(0xFF1D2125),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (isFollow)
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE9F0F2),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              "Follow",
              style: GoogleFonts.montserrat(
                color: const Color(0xFF0F4C5C),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }


  Widget _buildNearbySection(String title, List<_NearbyItem>? items,HomController controller) {
    if (items == null || items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: ()=>controller.openWebsite(item.website),
                child: Container(
                  width: 200.w,
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: item.image != null
                            ? Image.network(
                                ApiEndPoint.getImageUrl(item.image),
                                width: 50.w,
                                height: 50.h,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) =>
                                    const Icon(Icons.store),
                              )
                            : const Icon(Icons.store),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name ?? "N/A",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            Text(
                              "${item.distance ?? 'N/A'} • ⭐ ${item.rating ?? '0'}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


class _NearbyItem {
  final String? name;
  final String? image;
  final String? rating;
  final String? distance;
  final String? website;
  _NearbyItem({this.name, this.image, this.rating, this.distance, this.website,});
}
