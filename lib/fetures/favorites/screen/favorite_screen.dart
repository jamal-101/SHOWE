import 'package:digital_event/fetures/home/controller/hom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constans/app_colors.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../home/screen/event_details_screen.dart';
import '../../home/screen/venue_details_screen.dart';
import '../controller/favorite_controller.dart';
import '../model/favourite_venue_model.dart' as vn;
import 'package:intl/intl.dart';
import '../model/favourite_event_model.dart' as ev;

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
          onPressed: () => Get.back(),
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
        init: FavoriteController(),
        initState: (state) {
          final FavoriteController controller = Get.put(FavoriteController());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.changeTab(0);
          });
        },
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem("Events", controller.selectedFavouriteTabIndex.value == 0, 0, controller),
                    // _buildTabItem("Artists", controller.selectedFavouriteTabIndex.value == 1, 1, controller),
                    _buildTabItem("Venues", controller.selectedFavouriteTabIndex.value == 2, 2, controller),
                  ],
                ),
                const Divider(thickness: 1, height: 1, color: Color(0xFFE0E0E0)),
                SizedBox(height: 15.h),
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFFF2A900)))
                      : (controller.selectedFavouriteTabIndex.value == 0 && controller.favoriteList.isEmpty)
                      ? const Center(child: Text("No favorite events found"))
                      : (controller.selectedFavouriteTabIndex.value == 2 && controller.favoriteList.isEmpty)
                      ? const Center(child: Text("No favorite venues found"))
                      : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.selectedFavouriteTabIndex.value == 1
                              ? controller.artistData.length
                              : controller.favoriteList.length,
                          itemBuilder: (context, index) {
                            if (controller.selectedFavouriteTabIndex.value == 2) {
                              final vn.Data itemData = controller.favoriteList[index] as vn.Data;
                              return _buildVenueCard(itemData);
                            }
                            // else if (controller.selectedFavouriteTabIndex.value == 1) {
                            //   return _buildArtistCard(controller.artistData[index], controller);
                            // }
                            else {
                              final ev.Data itemData = controller.favoriteList[index] as ev.Data;
                              return _buildFavouriteEventCard(itemData);
                            }
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
    final String fullImageUrl = "${ApiEndPoint.imageUrl}${data.coverImage ?? ""}";
    final HomController homController = Get.put(HomController());

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
            // favorite_screen.dart এর ভেতর

            Positioned(
              top: 15.h,
              right: 15.w,
              child: GetBuilder<HomController>(
                builder: (homeController) {
                  return GestureDetector(
                    onTap: () async {
                      debugPrint("Click detected on favorite icon!");
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
                  if (data.category != null)
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
    final HomController homController = Get.put(HomController());
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

  Widget _buildArtistCard(Map<String, dynamic> data, FavoriteController controller) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                data['image'],
                height: 80.h,
                width: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D2125),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    data['name'],
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
              child: (data['isFavorite'] ?? false)
                  ? Image.asset(AppImages.unFavoriteIcon, color: Colors.white, height: 22.h, width: 22.w)
                  : Image.asset(AppImages.selectFavoriteIcon, height: 22.h, width: 22.w),
            ),
          ],
        ),
      ),
    );
  }
}