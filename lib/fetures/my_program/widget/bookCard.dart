
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/utils/api_enpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../model/theatre_model.dart';

class BookCard extends StatelessWidget {
  final ProgrammeData item;
  final double width;
  final double height;
  final VoidCallback onTap;
  final int? index;

  const BookCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.onTap,
    this.index
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = item.coverImage != null && item.coverImage!.trim().isNotEmpty;
    String fullImageUrl = "${ApiEndPoint.imageUrl}${item.coverImage ?? ""}";
    final String customHeroTag = 'reader_cover_${item.sId ?? 'no_id'}_${index ?? 0}';

    return GestureDetector(
      onTap: () {
        if (hasImage) {
          onTap();
        } else {
          Get.snackbar(
            "Notice",
            "No programme available",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFF5A623),
            colorText: const Color(0xFFFFFFFF),
            margin: const EdgeInsets.all(12),
            borderRadius: 12.r,
            duration: const Duration(seconds: 2),
          );
        }
      },
      child: Hero(
        // tag: 'reader_cover_${item.sId ?? 'no_id'}',
        tag: customHeroTag,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFF5A623),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: hasImage
                ? CachedNetworkImage(
              imageUrl: fullImageUrl,
              fit: BoxFit.cover,
              memCacheWidth: (width * 2).toInt(),
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Container(
                  color: const Color(0xFF1A2A3A),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.totalSize != null
                          ? downloadProgress.downloaded / downloadProgress.totalSize!
                          : null,
                      color: const Color(0xFFF5A623),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorWidget: (_, _, _) => Container(
                color: const Color(0xFF1A2A3A),
                child: Image.asset(AppImages.programImages, fit: BoxFit.cover),
              ),
            )
                : _buildNoPhotoImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildNoPhotoImage() {

    return Container(
      color: const Color(0xFF1A2A3A),
      child: Image.asset(
        AppImages.noPhoto,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}