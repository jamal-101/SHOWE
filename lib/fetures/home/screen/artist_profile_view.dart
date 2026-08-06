//
// import 'package:digital_event/core/common_text/common_text.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/fetures/home/controller/hom_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/constans/app_string.dart';
// import '../../../core/utils/api_enpoint.dart';
//
// class ArtistProfileView extends StatelessWidget {
//   const ArtistProfileView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomController controller = Get.find<HomController>();
//     final ScrollController scrollController = ScrollController();
//
//     final dynamic args = Get.arguments;
//     String artistId = '';
//     if (args is String) {
//       artistId = args;
//     } else if (args is Map<String, dynamic>) {
//       artistId = args['_id'] ?? args['id'] ?? '';
//     }
//
//     if (artistId.isNotEmpty) {
//       controller.fetchSingleArtist(artistId);
//       controller.fetchArtistEvents(artistId);
//     }
//
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >=
//           scrollController.position.maxScrollExtent - 200) {
//         if (artistId.isNotEmpty) {
//           controller.fetchArtistEvents(artistId, isLoadMore: true);
//         }
//       }
//     });
//
//     return Scaffold(
//       body: Obx(() {
//         if (controller.isSingleArtistLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final artistData = controller.singleArtistData;
//
//         if (artistData.isEmpty) {
//           return const Center(child: Text("No artist details found"));
//         }
//
//         return SingleChildScrollView(
//           controller: scrollController,
//           child: Column(
//             children: [
//               _buildArtistHeader(artistData, controller),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10.h),
//                     const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
//                     SizedBox(height: 10.h),
//                     _buildSectionTitle("About"),
//                     CommonText(
//                       textAlign: TextAlign.start,
//                       text: artistData['short_description'] ??
//                           AppString.venuAboutText,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.sp,
//                       color: const Color(0xFF767676),
//                     ),
//                     SizedBox(height: 20.h),
//                     _buildSectionTitle("Events"),
//
//                     // Events List
//                     Obx(() {
//                       if (controller.isEventsLoading.value) {
//                         return const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(20.0),
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                       }
//
//                       if (controller.artistEventsList.isEmpty) {
//                         return const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 20),
//                           child: Center(
//                             child: Text("No events found for this artist"),
//                           ),
//                         );
//                       }
//
//                       return Column(
//                         children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             padding: EdgeInsets.zero,
//                             itemCount: controller.artistEventsList.length,
//                             itemBuilder: (context, index) {
//                               var event = controller.artistEventsList[index];
//                               return _buildEventCard(event, controller, index);
//                             },
//                           ),
//
//                           if (controller.isMoreEventsLoading.value)
//                             Padding(
//                               padding: EdgeInsets.symmetric(vertical: 15.h),
//                               child: const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                         ],
//                       );
//                     }),
//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.h),
//       child: Text(
//         title,
//         style: GoogleFonts.montserrat(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           color: const Color(0xFF1D2125),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildArtistHeader(dynamic data, HomController controller) {
//     final String coverUrl =
//         "${ApiEndPoint.imageUrl}${data['cover_image'] ?? ""}";
//     final String profileUrl = "${ApiEndPoint.imageUrl}${data['image'] ?? ""}";
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         SizedBox(
//           height: 250.h,
//           width: double.infinity,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.network(
//                 coverUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Image.asset(
//                   AppImages.eventImage,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SafeArea(
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 15.w, top: 10.h),
//                     child: GestureDetector(
//                       onTap: () => Get.back(),
//                       child: Container(
//                         height: 35.h,
//                         width: 35.w,
//                         decoration: const BoxDecoration(
//                           color: Colors.black26,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.arrow_back_ios_new,
//                             color: Colors.white,
//                             size: 16.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 210.h),
//           padding: EdgeInsets.only(bottom: 20.h),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   height: 90.h,
//                   width: 90.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white, width: 4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: ClipOval(
//                     child: Image.network(
//                       profileUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Image.asset(
//                         AppImages.artistImage,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 15.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         data['name'] ?? "Unknown Artist",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 19.sp,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF1D2125),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         data['category'] ?? "Artist",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 14.sp,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildEventCard(dynamic data, HomController controller, int index) {
//     final String coverUrl =
//         "${ApiEndPoint.imageUrl}${data['cover_image'] ?? ""}";
//     final String title = data['title'] ?? "Concert Title";
//     final String category = data['category'] ?? "Music";
//     final dynamic price = data['price'] ?? 0;
//     final String rawDate = data['event_date'] ?? "";
//
//     String formattedDate = rawDate;
//     if (rawDate.isNotEmpty && rawDate.contains("T")) {
//       formattedDate = rawDate.split("T")[0];
//     }
//
//     return GestureDetector(
//       onTap: () {
//         if (data['_id'] != null) {
//           // Get.toNamed(AppRoutes.eventDetailsView, arguments: data['_id']);
//         }
//       },
//       child: Container(
//         height: 160.h,
//         margin: EdgeInsets.only(bottom: 15.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20.r),
//               child: Image.network(
//                 coverUrl,
//                 height: 160.h,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Image.asset(
//                   AppImages.eventImage,
//                   height: 160.h,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
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
//
//
//             Positioned(
//               top: 15.h,
//               right: 15.w,
//               child:
//               Positioned(
//                 top: 15.h,
//                 right: 15.w,
//                 child: GestureDetector(
//                   onTap: () => controller.toggleFavorite(data),
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white.withValues(alpha: 0.2),
//                     ),
//                     child: (data.isFavorited ?? false)
//                         ? Image.asset(
//                       AppImages.selectFavoriteIcon,
//                       height: 25.h,
//                       width: 25.w,
//                     )
//                         : Image.asset(
//                       AppImages.unFavoriteIcon,
//                       height: 25.h,
//                       width: 25.w,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             Positioned(
//               bottom: 15.h,
//               left: 15.w,
//               right: 15.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.2),
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     child: Text(
//                       category,
//                       style: TextStyle(color: Colors.white, fontSize: 10.sp),
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   Text(
//                     title,
//                     style: GoogleFonts.montserrat(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
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
//                             formattedDate,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "\$$price",
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
// }

import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constans/app_string.dart';
import '../../../core/utils/api_enpoint.dart';
import '../model/event_model.dart' as EventModel;
import 'event_details_screen.dart';

class ArtistProfileView extends StatelessWidget {
  const ArtistProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomController controller = Get.find<HomController>();
    final ScrollController scrollController = ScrollController();

    // Get Arguments
    final dynamic args = Get.arguments;
    String artistId = '';
    if (args is String) {
      artistId = args;
    } else if (args is Map<String, dynamic>) {
      artistId = args['_id'] ?? args['id'] ?? '';
    }

    if (artistId.isNotEmpty) {
      controller.fetchSingleArtist(artistId);
      controller.fetchArtistEvents(artistId);
    }

    // Scroll Listener for Event Pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (artistId.isNotEmpty) {
          controller.fetchArtistEvents(artistId, isLoadMore: true);
        }
      }
    });

    return Scaffold(
      body: Obx(() {
        if (controller.isSingleArtistLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final artistData = controller.singleArtistData;

        if (artistData.isEmpty) {
          return const Center(child: Text("No artist details found"));
        }

        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              _buildArtistHeader(artistData, controller),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    SizedBox(height: 10.h),
                    _buildSectionTitle("About"),
                    CommonText(
                      textAlign: TextAlign.start,
                      text: artistData['short_description'] ??
                          AppString.venuAboutText,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xFF767676),
                    ),
                    SizedBox(height: 20.h),
                    _buildSectionTitle("Events"),

                    // Events List
                    Obx(() {
                      if (controller.isEventsLoading.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (controller.artistEventsList.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text("No events found for this artist"),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: controller.artistEventsList.length,
                            itemBuilder: (context, index) {
                              var event = controller.artistEventsList[index];
                              return _buildEventCard(event, controller, index);
                            },
                          ),

                          if (controller.isMoreEventsLoading.value)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      );
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1D2125),
        ),
      ),
    );
  }

  Widget _buildArtistHeader(dynamic data, HomController controller) {
    final String coverUrl =
        "${ApiEndPoint.imageUrl}${data['cover_image'] ?? ""}";
    final String profileUrl = "${ApiEndPoint.imageUrl}${data['image'] ?? ""}";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 250.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                coverUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AppImages.eventImage,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 210.h),
          padding: EdgeInsets.only(bottom: 20.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 90.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 4),
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
                      profileUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AppImages.artistImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data['name'] ?? "Unknown Artist",
                        style: GoogleFonts.montserrat(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D2125),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data['category'] ?? "Artist",
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(dynamic data, HomController controller, int index) {
    final String coverUrl = "${ApiEndPoint.imageUrl}${data is EventModel.Data ? data.coverImage ?? "" : data['cover_image'] ?? ""}";
    final String title = data is EventModel.Data ? (data.title ?? "Concert Title") : (data['title'] ?? "Concert Title");
    final String category = data is EventModel.Data ? (data.category ?? "Music") : (data['category'] ?? "Music");
    final dynamic price = data is EventModel.Data ? (data.price ?? 0) : (data['price'] ?? 0);
    final String rawDate = data is EventModel.Data ? (data.eventDate ?? "") : (data['event_date'] ?? "");

    String formattedDate = rawDate;
    if (rawDate.isNotEmpty && rawDate.contains("T")) {
      formattedDate = rawDate.split("T")[0];
    }

    return GestureDetector(
      onTap: () async {
          if (data.sId != null) {
            await controller.fetchEventDetails(data.sId!);
            if (controller.eventDetailsModel?.data != null) {
              Get.to(() => const EventDetailsScreen(), arguments: data);
            }
          }

      },
      child: Container(
        height: 160.h,
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                coverUrl,
                height: 160.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AppImages.eventImage,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              right: 15.w,
              child: GetBuilder<HomController>(
                builder: (ctrl) {
                  bool isFav = false;
                  if (data is EventModel.Data) {
                    isFav = data.isFavorited ?? false;
                  } else if (data is Map) {
                    isFav = data['isFavorited'] ?? false;
                  }

                  return GestureDetector(
                    onTap: () => ctrl.toggleFavorite(data),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Image.asset(
                        isFav
                            ? AppImages.selectFavoriteIcon
                            : AppImages.unFavoriteIcon,
                        height: 25.h,
                        width: 25.w,
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(
              bottom: 15.h,
              left: 15.w,
              right: 15.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}