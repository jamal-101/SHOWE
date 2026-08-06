// import 'package:digital_event/core/common_text/common_text.dart';
// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/constans/app_string.dart';
// import 'package:digital_event/core/route/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../controller/hom_controller.dart';
//
//
// class VenueDetailsScreen extends StatelessWidget {
//   const VenueDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> data = Get.arguments ?? {};
//     final controller = Get.find<HomController>();
//     return GetBuilder<HomController>(
//       init: HomController(),
//       builder: (controller) {
//         final eventData = controller.eventData[0];
//         final artistData = controller.artistData[0];
//         return Scaffold(
//           body: Obx(() {
//             if (controller.isVenueDetailsLoading.value) {
//               return const Center(child: CircularProgressIndicator(color: Color(0xFF0F4C5C)));
//             }
//
//             // ২. ডাটা চেক
//             if (controller.venueDetailsModel == null || controller.venueDetailsModel!.data == null) {
//               return const Center(child: Text("No Data Found"));
//             }
//             final venueData = controller.venueDetailsModel!.data!;
//             double latitude = 0.0;
//             double longitude = 0.0;
//             if (venueData.location?.coordinates != null && venueData.location!.coordinates!.length >= 2) {
//               longitude = venueData.location!.coordinates![0];
//               latitude = venueData.location!.coordinates![1];
//             }
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildVenueHeader(data, controller),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Divider(height: 20, thickness: 1),
//                         _buildSectionTitle("About"),
//                         CommonText(
//                           textAlign: TextAlign.start,
//                           text: AppString.venuAboutText,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16.sp,
//                           color: const Color(0xFF767676),
//                         ),
//                         SizedBox(height: 10.h),
//                         _buildSectionTitle("Events"),
//                         _buildEventCard(eventData, controller),
//                         _buildSectionTitle("Artist"),
//                         _buildArtistSection(artistData, controller),
//                         SizedBox(height: 10.h),
//                         _buildSectionTitle("Map"),
//                         Container(
//                           height: 150.h,
//                           width: double.infinity,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15.r),
//                           ),
//                           child: GoogleMap(
//                             initialCameraPosition: CameraPosition(
//                               target: LatLng(23.8103, 90.4125),
//                               zoom: 14.0,
//                             ),
//                             mapType: MapType.normal,
//                             myLocationEnabled: true,
//                             zoomControlsEnabled: false,
//                             onMapCreated: (GoogleMapController controller) {},
//                             markers: {
//                               Marker(
//                                 markerId: const MarkerId('venue_location'),
//                                 position: LatLng(23.8103, 90.4125),
//                                 infoWindow: const InfoWindow(
//                                   title: 'Gala Convention Center',
//                                 ),
//                               ),
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 20.h),
//                         _buildSectionTitle("Transport Information"),
//                         _buildBulletPoint("Public Transport"),
//                         _buildBulletPoint("Parking"),
//                         SizedBox(height: 20.h),
//                         _buildSectionTitle("Nearby Restaurants"),
//                         Row(
//                           children: [
//                             _buildSmallCard("Cafe Rio", AppImages.eventImage),
//                             SizedBox(width: 15.w),
//                             _buildSmallCard("Cieolo", AppImages.artistImage),
//                           ],
//                         ),
//                         SizedBox(height: 10.h),
//                         _buildSectionTitle("Recommended Hotels"),
//                         SizedBox(
//                           height: 100.h,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: 5,
//                             padding: EdgeInsets.zero,
//                             itemBuilder: (context, index) {
//                               return _buildWideCard(
//                                 "Inter Continental Hotel",
//                                 AppImages.hotelImage,
//                               );
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 20.h),
//                         _buildSectionTitle("Nearby Bars"),
//                         Row(
//                           children: [
//                             _buildSmallCard("Galaxy bar", AppImages.eventImage),
//                             SizedBox(width: 15.w),
//                             _buildSmallCard("Erram", AppImages.artistImage),
//                           ],
//                         ),
//                         SizedBox(height: 30.h),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.h),
//       child: Text(
//         title,
//         style: GoogleFonts.montserrat(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBulletPoint(String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 5.h),
//       child: Row(
//         children: [
//           const Icon(Icons.circle, size: 6, color: Colors.grey),
//           SizedBox(width: 10.w),
//           Text(
//             text,
//             style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSmallCard(String name, String imagePath) {
//     return Expanded(
//       child: Container(
//         height: 100.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.r),
//           image: DecorationImage(
//             image: AssetImage(imagePath),
//             fit: BoxFit.cover,
//           ),
//         ),
//         alignment: Alignment.bottomLeft,
//         padding: EdgeInsets.all(10.w),
//         child: Text(
//           name,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEventCard(Map<String, dynamic> data, HomController controller) {
//     return GestureDetector(
//       onTap: () {
//         // Get.to(const EventDetailsScreen(), arguments: data);
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 20.h),
//         height: 180.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           image: const DecorationImage(
//             image: AssetImage(AppImages.eventImage),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.r),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.black.withValues(alpha: 0.8),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 15.h,
//               right: 15.w,
//               child: GestureDetector(
//                 onTap: () => controller.toggleFavorite(data),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withValues(alpha: 0.2),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: (data['isFavorite'] ?? false)
//                         ? Image.asset(
//                             AppImages.unFavoriteIcon,
//                             color: Colors.white,
//                             height: 25.h,
//                             width: 25.w,
//                           )
//                         : Image.asset(
//                             AppImages.selectFavoriteIcon,
//                             height: 25.h,
//                             width: 25.w,
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 15.h,
//               left: 15.w,
//               right: 15.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 10.w,
//                       vertical: 4.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.2),
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     child: Text(
//                       'Music',
//                       style: TextStyle(color: Colors.white, fontSize: 10.sp),
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   Text(
//                     'The Weekend Vibes Concert',
//                     style: GoogleFonts.montserrat(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.calendar_today,
//                             color: Colors.white,
//                             size: 14.sp,
//                           ),
//                           SizedBox(width: 5.w),
//                           Text(
//                             "Dec 18  - 08:00 PM",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "\$120.00",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWideCard(String name, String imagePath) {
//     return Container(
//       height: 100.h,
//       width: 300.w,
//       margin: EdgeInsets.only(right: 15.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r),
//         image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
//       ),
//       alignment: Alignment.bottomLeft,
//       padding: EdgeInsets.all(10.w),
//       child: Text(
//         name,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVenueHeader(
//     Map<String, dynamic> data,
//     HomController controller,
//   ) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           decoration: const BoxDecoration(color: AppColors.appBackgroundColor),
//           child: Column(
//             children: [
//               Container(
//                 height: 230.h,
//                 width: double.infinity,
//                 decoration:  BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.venueDetailsImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 15.w, top: 10.h),
//                       child: GestureDetector(
//                         onTap: () => Get.back(),
//                         child: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                           size: 20.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   left: 105.w,
//                   top: 12.h,
//                   right: 20.w,
//                   bottom: 15.h,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Gala Convention Center",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFF2D2D2D),
//                             ),
//                           ),
//                           SizedBox(height: 4.h),
//                           Text(
//                             "123 Golf Street, UK",
//                             style: GoogleFonts.montserrat(
//                               color: const Color(0xFF767676),
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         controller.toggleFavorite(data);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                           color: Color(0xFFE0E0E0),
//                           shape: BoxShape.circle,
//                         ),
//                         child: (data['isFavorite'] ?? false)
//                             ? Image.asset(
//                                 AppImages.unFavoriteIcon,
//                                 color: Colors.white,
//                                 height: 25.h,
//                                 width: 25.w,
//                               )
//                             : Image.asset(
//                                 AppImages.selectFavoriteIcon,
//                                 height: 25.h,
//                                 width: 25.w,
//                               ),
//                         // const Icon(
//                         //   Icons.favorite_border,
//                         //   color: Colors.white,
//                         //   size: 22,
//                         // ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 200.h,
//           left: 10.w,
//           child: Container(
//             height: 80.h,
//             width: 80.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//               border: Border.all(color: Colors.white, width: 3),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: ClipOval(
//               child: Image.asset(AppImages.venueLogoImage, fit: BoxFit.cover),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildArtistSection(
//     Map<String, dynamic> data,
//     HomController controller,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         Get.toNamed(AppRoutes.artistProfileView);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 0.h),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15.r),
//               child: Image.asset(
//                 AppImages.artistImage,
//                 width: 70.w,
//                 height: 70.h,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: 15.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Chester Bennington",
//                     style: GoogleFonts.montserrat(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFF2D2D2D),
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     "Artist",
//                     style: GoogleFonts.montserrat(
//                       fontSize: 14.sp,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 controller.toggleFavorite(data);
//               },
//               child: Container(
//                 height: 40.h,
//                 width: 40.h,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFE0E0E0),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: (data['isFavorite'] ?? false)
//                       ? Image.asset(
//                           AppImages.unFavoriteIcon,
//                           color: Colors.white,
//                           height: 25.h,
//                           width: 25.w,
//                         )
//                       : Image.asset(
//                           AppImages.selectFavoriteIcon,
//                           height: 25.h,
//                           width: 25.w,
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:digital_event/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // গুগল ম্যাপের জন্য
import '../../../core/constans/app_images.dart';
import '../../../core/utils/api_enpoint.dart';
import '../controller/hom_controller.dart';

class VenueDetailsScreen extends StatelessWidget {
  const VenueDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomController controller = Get.put(HomController());
    return Scaffold(
      body: Obx(() {
        if (controller.isVenueDetailsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
          );
        }
        if (controller.venueDetailsModel == null ||
            controller.venueDetailsModel!.data == null) {
          return const Center(child: Text("No Data Found"));
        }
        final venueData = controller.venueDetailsModel!.data!;
        double latitude = 0.0;
        double longitude = 0.0;
        if (venueData.location?.coordinates != null &&
            venueData.location!.coordinates!.length >= 2) {
          longitude = venueData.location!.coordinates![0];
          latitude = venueData.location!.coordinates![1];
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVenueHeader(venueData, controller),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venueData.name ?? "Unknown Venue",
                      style: GoogleFonts.montserrat(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F4C5C),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFFF2A900),
                          size: 20,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "${venueData.addressLine1 ?? ""}, ${venueData.city ?? ""}",
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 40),
                    Text(
                      "About Venue",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      venueData.description ?? "No description available",
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Location on Map",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    if (latitude != 0.0 && longitude != 0.0)
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(latitude, longitude),
                              zoom: 15,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId("venue_loc"),
                                position: LatLng(latitude, longitude),
                                infoWindow: InfoWindow(title: venueData.name),
                              ),
                            },
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                          ),
                        ),
                      )
                    else
                      const Center(
                        child: Text("Exact location coordinates not available"),
                      ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVenueHeader(dynamic venueData, HomController controller) {
    String coverUrl = "${ApiEndPoint.imageUrl}${venueData.coverImage ?? ""}";
    String logoUrl = "${ApiEndPoint.imageUrl}${venueData.logo ?? ""}";
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.appBackgroundColor),
          child: Column(
            children: [
              Container(
                height: 230.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 10.h),
                      child: GestureDetector(
                        onTap: (){
                         Get.back();
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
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 105.w,
                  top: 12.h,
                  right: 20.w,
                  bottom: 15.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venueData.name ?? "Unknown Venue",
                            style: GoogleFonts.montserrat(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${venueData.addressLine1 ?? ""}, ${venueData.city ?? ""}",
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF767676),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toggleFavorite(venueData),
                      child: GetBuilder<HomController>(
                        builder: (controller) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: (venueData.isFavorited ?? false)
                                ? Image.asset(
                              AppImages.selectFavoriteIcon,
                              height: 22.h,
                              width: 22.w,
                            )
                                : Image.asset(
                              AppImages.unFavoriteIcon,
                              color: Colors.amber,
                              height: 22.h,
                              width: 22.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 200.h,
          left: 10.w,
          child: Container(
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                logoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.business, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
