import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:digital_event/fetures/home/screen/venue_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/api_enpoint.dart';
import 'event_details_screen.dart';
import '../model/venue_model.dart' as VenueModel;

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColors.appBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0F4C5C),
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: GetBuilder<HomController>(
          builder: (controller) {
            String title = "Events";
            if (controller.selectedTabIndex.value == 1) {
              title = "Artists";
            } else if (controller.selectedTabIndex.value == 2) {
              title = "Venues";
            }
            return Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F4C5C),
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomController>(
        init: HomController(),
        builder: (controller) {
          if (controller.selectedTabIndex.value == 0) {
          } else if (controller.selectedTabIndex.value == 1) {
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextField(
                                controller: controller.searchController,
                                onSubmitted: (value) {
                                  if (controller.selectedTabIndex.value == 0) {
                                    controller.fetchEvents(isRefresh: true);
                                  } else if (controller.selectedTabIndex.value == 2) {
                                    controller.fetchVenues(isRefresh: true);
                                  }
                                },
                                // onChanged: (value) {
                                //   if (controller.selectedTabIndex.value == 2) {
                                //     controller.searchVenue(value);
                                //   }
                                // },
                                onChanged: (value) {
                                  controller.onSearchChanged(value);
                                },
                                decoration: InputDecoration(
                                  hintText: controller.selectedTabIndex.value == 2
                                      ? "Search venue"
                                      : "Search",
                                  hintStyle: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // if (controller.selectedTabIndex.value == 2) ...[
                            //   Padding(
                            //     padding: EdgeInsets.symmetric(vertical: 12.h),
                            //     child: VerticalDivider(
                            //       color: Colors.grey.withValues(alpha: 0.5),
                            //       thickness: 1,
                            //     ),
                            //   ),
                            //   IconButton(
                            //     onPressed: () {
                            //       _showCalendarDialog(context, controller);
                            //     },
                            //     icon: Image.asset(
                            //       AppImages.searchCalender,
                            //       height: 25.h,
                            //       width: 25.w,
                            //       color: controller.selectedVenueDate != null ? Colors.orange : null,
                            //     ),
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem(
                      "Events",
                      controller.selectedTabIndex.value == 0,
                      0,
                      controller,
                    ),
                    _buildTabItem(
                      "Artists",
                      controller.selectedTabIndex.value == 1,
                      1,
                      controller,
                    ),
                    _buildTabItem(
                      "Venues",
                      controller.selectedTabIndex.value == 2,
                      2,
                      controller,
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xFFE0E0E0),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: Obx(() {
                    if (controller.selectedTabIndex == 1 && controller.isArtistLoading.value) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFF0F4C5C)));
                    }
                    if (controller.selectedTabIndex.value == 0 &&
                        controller.isEventLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF0F4C5C),
                        ),
                      );
                    }
                    if (controller.selectedTabIndex.value == 2 &&
                        controller.isVenueLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF0F4C5C),
                        ),
                      );
                    }

                    int itemCount = 0;
                    if (controller.selectedTabIndex.value == 0) {
                      itemCount =
                          (controller.eventModel.data?.length ?? 0) +
                              (controller.isLoadMore.value ? 1 : 0);
                    } else if (controller.selectedTabIndex == 1) {
                      itemCount = (controller.artistModel.data?.length ?? 0) + (controller.isArtistLoadMore.value ? 1 : 0);
                    } else if (controller.selectedTabIndex.value == 2) {
                      itemCount = controller.venueList.length +
                          (controller.isVenueLoadMore.value ? 1 : 0);
                    }
                    return RefreshIndicator(
                      color: const Color(0xFF0F4C5C),
                      onRefresh: () => controller.refreshCurrentTab(),
                      child: ListView.builder(
                        itemCount: itemCount,
                        controller: controller.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.selectedTabIndex.value == 0) {
                            if (index < (controller.eventModel.data?.length ?? 0)) {
                              return _buildEventCard(
                                controller.eventModel.data![index],
                              );
                            } else {
                              return _loadMoreIndicator();
                            }
                          }
                          else if (controller.selectedTabIndex.value == 1) {
                            if (index < (controller.artistModel.data?.length ?? 0)) {
                              return _buildArtistCard(
                                controller.artistModel.data![index],
                                controller,
                              );
                            } else {
                              return _loadMoreIndicator();
                            }
                          }
                          else {
                            if (index < controller.venueList.length) {
                              return _buildVenueCard(controller.venueList[index]);
                            } else {
                              return _loadMoreIndicator();
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabItem(
      String title,
      bool isActive,
      int index,
      HomController controller,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? const Color(0xFFF2A900) : Colors.grey,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 2,
                width: double.infinity,
                color: isActive ? const Color(0xFFF2A900) : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(dynamic data) {
    final String fullImageUrl =
        ApiEndPoint.getImageUrl(data.coverImage);
    final HomController controller = Get.find<HomController>();

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
        margin: EdgeInsets.only(bottom: 20.h),
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: NetworkImage(fullImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              right: 15.w,
              child: GestureDetector(
                onTap: () => controller.toggleFavorite(data),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: (data.isFavorited ?? false)
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
            Positioned(
              bottom: 15.h,
              left: 15.w,
              right: 15.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.category != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        data.category!,
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  SizedBox(height: 5.h),
                  Text(
                    data.title ?? "No Title",
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
                            data.eventDate != null
                                ? DateFormat(
                              'MMM dd, yyyy',
                            ).format(DateTime.parse(data.eventDate!))
                                : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${data.price ?? 0}",
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


  Widget _buildArtistCard(dynamic data, HomController controller) {
    final String fullImageUrl = ApiEndPoint.getImageUrl(data.image);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(
          AppRoutes.artistProfileView,
          arguments: data.sId ?? data.id,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                fullImageUrl,
                height: 80.h,
                width: 80.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 80.h,
                    width: 80.h,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 40.sp, color: Colors.grey.shade600),
                  );
                },
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? "Unknown Artist",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D2125),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data.category ?? "Artist",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => controller.toggleFavorite(data),
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                ),
                child: (data.isFavorited ?? false)
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
          ],
        ),
      ),
    );
  }

  Widget _buildVenueCard(VenueModel.Data data) {
    final controller = Get.find<HomController>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (data.sId != null) {
          await controller.fetchVenueDetails(data.sId!);
          if (controller.venueDetailsModel?.data != null) {
            Get.to(() => const VenueDetailsScreen());
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F0F2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? "Unknown Venue",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1D2125),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${data.city ?? ""}, ${data.country ?? ""}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      data.createdAt != null
                          ? DateFormat(
                        'MMMM dd, yyyy',
                      ).format(DateTime.parse(data.createdAt!))
                          : "Date TBA",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: const Color(0xFF0F4C5C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Image.asset(AppImages.location, height: 40.h, width: 40.w),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF0F4C5C),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showCalendarDialog(BuildContext context, HomController controller) {
  //   Get.dialog(
  //     Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.r),
  //       ),
  //       child: GetBuilder<HomController>(
  //         builder: (controller) {
  //           return Container(
  //             padding: EdgeInsets.all(20.w),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20.r),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     IconButton(
  //                       onPressed: () {
  //                         controller.focusedDay = DateTime(
  //                           controller.focusedDay.year,
  //                           controller.focusedDay.month - 1,
  //                         );
  //                         controller.update();
  //                       },
  //                       icon: const Icon(
  //                         Icons.arrow_back_ios,
  //                         size: 18,
  //                         color: Color(0xFF0F4C5C),
  //                       ),
  //                     ),
  //                     Text(
  //                       DateFormat('MMMM, yyyy').format(controller.focusedDay),
  //                       style: GoogleFonts.montserrat(
  //                         fontSize: 18.sp,
  //                         fontWeight: FontWeight.bold,
  //                         color: const Color(0xFF0F4C5C),
  //                       ),
  //                     ),
  //                     IconButton(
  //                       onPressed: () {
  //                         controller.focusedDay = DateTime(
  //                           controller.focusedDay.year,
  //                           controller.focusedDay.month + 1,
  //                         );
  //                         controller.update();
  //                       },
  //                       icon: const Icon(
  //                         Icons.arrow_forward_ios,
  //                         size: 18,
  //                         color: Color(0xFF0F4C5C),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 10.h),
  //                 TableCalendar(
  //                   firstDay: DateTime.now().subtract(const Duration(days: 365)),
  //                   lastDay: DateTime.now().add(const Duration(days: 365 * 5)),
  //                   focusedDay: controller.selectedVenueDate ?? DateTime.now(),
  //                   currentDay: controller.selectedVenueDate,
  //                   calendarFormat: CalendarFormat.month,
  //                   headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
  //                   onDaySelected: (selectedDay, focusedDay) {
  //                     controller.selectedVenueDate = selectedDay;
  //                     controller.fetchVenues(isRefresh: true);
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 SizedBox(height: 20.h),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   height: 48.h,
  //                   child: ElevatedButton(
  //                     onPressed: () => Get.back(),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: const Color(0xFFF2A900),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30.r),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       "Search",
  //                       style: GoogleFonts.montserrat(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                         fontSize: 16.sp,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}

Widget _loadMoreIndicator() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 15),
    child: Center(child: CircularProgressIndicator(color: Color(0xFF0F4C5C))),
  );
}
