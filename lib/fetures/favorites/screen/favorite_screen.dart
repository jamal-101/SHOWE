import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constans/app_colors.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../home/screen/event_details_screen.dart';
import '../../home/screen/venue_details_screen.dart';
import '../controller/favorite_controller.dart';
import '../model/artist_favourite_model.dart' as af;
import '../model/favourite_event_model.dart' as ev;
import '../model/favourite_venue_model.dart' as vn;

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Favorites",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      body: GetBuilder<FavoriteController>(
        init: Get.put(FavoriteController()),
        builder: (controller) {
          final List<dynamic> currentList = controller.favoriteList;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem("Events", controller.selectedFavouriteTabIndex.value == 0, 0, controller),
                    _buildTabItem("Artists", controller.selectedFavouriteTabIndex.value == 1, 1, controller),
                    _buildTabItem("Venues", controller.selectedFavouriteTabIndex.value == 2, 2, controller),
                  ],
                ),
                const Divider(thickness: 1, height: 1, color: Color(0xFFE0E0E0)),
                SizedBox(height: 15.h),
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFFF2A900)))
                      : currentList.isEmpty
                      ? Center(
                    child: Text(
                      controller.selectedFavouriteTabIndex.value == 0
                          ? "No favorite events found"
                          : controller.selectedFavouriteTabIndex.value == 1
                          ? "No favorite artists found"
                          : "No favorite venues found",
                      style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey),
                    ),
                  )
                      : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: currentList.length,
                          itemBuilder: (context, index) {
                            final rawData = currentList[index];

                            if (controller.selectedFavouriteTabIndex.value == 2) {
                              if (rawData is vn.Data) return _buildVenueCard(rawData);
                            }
                            else if (controller.selectedFavouriteTabIndex.value == 1) {
                              if (rawData is af.Data) {
                                return _buildFavoriteArtistCard(rawData);
                              }
                            }
                            else {
                              if (rawData is ev.Data) return _buildFavouriteEventCard(rawData);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      if (controller.isLoadMore.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: const CircularProgressIndicator(color: Color(0xFFF2A900)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavouriteEventCard(ev.Data data) {
    final String fullImageUrl = ApiEndPoint.getImageUrl(data.coverImage);
    final HomController homController = Get.isRegistered<HomController>()
        ? Get.find<HomController>()
        : Get.put(HomController());

    return GestureDetector(
      onTap: () async {
        if (data.sId != null) {
          await homController.fetchEventDetails(data.sId!);
          if (homController.eventDetailsModel?.data != null) {
            Get.to(() => const EventDetailsScreen());
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
            onError: (exception, stackTrace) {},
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
                init: Get.isRegistered<HomController>() ? null : Get.put(HomController()),
                builder: (homeController) {
                  return GestureDetector(
                    onTap: () async {
                      await homeController.toggleFavorite(data);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Image.asset(
                        AppImages.selectFavoriteIcon,
                        height: 22.h,
                        width: 22.w,
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
                  if (data.category != null && data.category!.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
                          Icon(Icons.calendar_today, color: Colors.white, size: 14.sp),
                          SizedBox(width: 5.w),
                          Text(
                            data.eventDate != null && data.eventDate!.isNotEmpty
                                ? DateFormat('dd MMMM, yyyy').format(DateTime.parse(data.eventDate!))
                                : "No Date Provided",
                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Text(
                        data.price != null ? "\$${data.price}" : "Free",
                        style: GoogleFonts.montserrat(
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

  Widget _buildTabItem(String title, bool isActive, int index, FavoriteController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVenueCard(vn.Data data) {
    final HomController homController = Get.isRegistered<HomController>()
        ? Get.find<HomController>()
        : Get.put(HomController());

    return GestureDetector(
      onTap: () async {
        if (data.sId != null) {
          await homController.fetchVenueDetails(data.sId!);
          if (homController.venueDetailsModel?.data != null) {
            Get.to(() => const VenueDetailsScreen());
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: const Color(0xFFE9F0F2),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? "Unknown Venue",
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
                    [data.city, data.state, data.country]
                        .where((field) => field != null && field.trim().isNotEmpty)
                        .map((field) => field!.trim())
                        .isEmpty
                        ? "No Address Provided"
                        : [data.city, data.country]
                        .where((field) => field != null && field.trim().isNotEmpty)
                        .map((field) => field!.trim())
                        .join(', '),
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]?.withValues(alpha: 0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data.createdAt != null && data.createdAt!.isNotEmpty
                        ? DateFormat('dd MMMM, yyyy').format(DateTime.parse(data.createdAt!))
                        : "No Date Provided",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]?.withValues(alpha: 0.9),
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Image.asset(AppImages.location, height: 26.h, width: 26.w)
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF0F4C5C), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteArtistCard(af.Data data) {
    final String fullImageUrl = ApiEndPoint.getImageUrl(data.image);

    return GestureDetector(
      onTap: (){
       Get.toNamed(AppRoutes.artistProfileView,arguments: data.sId);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(fullImageUrl),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name ?? "Unknown Artist", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(data.category ?? "No Category", style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            GetBuilder<HomController>(
              init: Get.isRegistered<HomController>() ? null : Get.put(HomController()),
              builder: (hc) {
                return IconButton(
                  onPressed: () => hc.toggleFavorite(data),
                  icon: Image.asset(
                      AppImages.selectFavoriteIcon,
                      height: 22.h,
                      width: 22.w
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}