// import 'package:flutter/material.dart';
// import '../model/theatre_model.dart';
//
// class BookCard extends StatelessWidget {
//   final TheatreItem item;
//   final double width;
//   final double height;
//   final VoidCallback onTap;
//
//   const BookCard({
//     super.key,
//     required this.item,
//     required this.width,
//     required this.height,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Hero(
//         tag: item.title,
//         child: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//             border: Border.all(color: const Color(0xFFF5A623), width: 1.5),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFF5A623).withAlpha(55),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: Image.asset(
//               item.imageAsset,
//               key: ValueKey(item.imageAsset),
//               fit: BoxFit.cover,
//               errorBuilder: (_, _, _) => Container(
//                 color: const Color(0xFF1A2A3A),
//                 child: const Center(
//                   child: Icon(Icons.image, color: Colors.white24, size: 32),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

  const BookCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = item.coverImage != null && item.coverImage!.trim().isNotEmpty;
    String fullImageUrl = "${ApiEndPoint.imageUrl}${item.coverImage ?? ""}";


    return GestureDetector(
      // onTap: hasImage ? onTap : null,
      onTap: () {
        if (hasImage) {
          onTap();
        } else {
          Get.snackbar(
            "Notice",
            "No programme available",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color(0xFFF5A623),
            colorText: Color(0xFFFFFFFF),
            margin: EdgeInsets.all(12),
            borderRadius: 12.r,
            duration: Duration(seconds: 2),
          );
        }
      },
      child: Hero(
        tag: item.sId ?? item.title ?? UniqueKey().toString(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFF5A623), width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: hasImage ? Image.network(
              fullImageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFF1A2A3A),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      color: const Color(0xFFF5A623),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF1A2A3A),
                child: Image.asset(AppImages.programImages, fit: BoxFit.cover),
              ),
            ) : _buildNoPhotoImage(),
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
