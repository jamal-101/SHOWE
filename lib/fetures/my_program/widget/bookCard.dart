// // import 'package:digital_event/core/constans/app_images.dart';
// // import 'package:digital_event/core/utils/api_enpoint.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import '../model/theatre_model.dart';
// //
// // class BookCard extends StatelessWidget {
// //   final ProgrammeData item;
// //   final double width;
// //   final double height;
// //   final VoidCallback onTap;
// //
// //   const BookCard({
// //     super.key,
// //     required this.item,
// //     required this.width,
// //     required this.height,
// //     required this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final bool hasImage = item.coverImage != null && item.coverImage!.trim().isNotEmpty;
// //     String fullImageUrl = "${ApiEndPoint.imageUrl}${item.coverImage ?? ""}";
// //
// //
// //     return GestureDetector(
// //       onTap: () {
// //         if (hasImage) {
// //           onTap();
// //         } else {
// //           Get.snackbar(
// //             "Notice",
// //             "No programme available",
// //             snackPosition: SnackPosition.TOP,
// //             backgroundColor: Color(0xFFF5A623),
// //             colorText: Color(0xFFFFFFFF),
// //             margin: EdgeInsets.all(12),
// //             borderRadius: 12.r,
// //             duration: Duration(seconds: 2),
// //           );
// //         }
// //       },
// //       child: Hero(
// //         tag: item.sId ?? item.title ?? UniqueKey().toString(),
// //         child: Container(
// //           width: width,
// //           height: height,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(6),
// //             border: Border.all(color: const Color(0xFFF5A623), width: 1.5),
// //           ),
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(6),
// //             child: hasImage ? Image.network(
// //               fullImageUrl,
// //               fit: BoxFit.cover,
// //               loadingBuilder: (context, child, loadingProgress) {
// //                 if (loadingProgress == null) return child;
// //                 return Container(
// //                   color: const Color(0xFF1A2A3A),
// //                   child: Center(
// //                     child: CircularProgressIndicator(
// //                       value: loadingProgress.expectedTotalBytes != null
// //                           ? loadingProgress.cumulativeBytesLoaded /
// //                           loadingProgress.expectedTotalBytes!
// //                           : null,
// //                       color: const Color(0xFFF5A623),
// //                       strokeWidth: 2,
// //                     ),
// //                   ),
// //                 );
// //               },
// //               errorBuilder: (_, __, ___) => Container(
// //                 color: const Color(0xFF1A2A3A),
// //                 child: Image.asset(AppImages.programImages, fit: BoxFit.cover),
// //               ),
// //             ) : _buildNoPhotoImage(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //   Widget _buildNoPhotoImage() {
// //     return Container(
// //       color: const Color(0xFF1A2A3A),
// //       child: Image.asset(
// //         AppImages.noPhoto,
// //         fit: BoxFit.cover,
// //         width: width,
// //         height: height,
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/utils/api_enpoint.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../controller/Theatre_Controller.dart';
// import '../model/theatre_model.dart';
//
// class BookCard extends StatelessWidget {
//   final ProgrammeData item;
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
//     final bool hasImage = item.coverImage != null && item.coverImage!.trim().isNotEmpty;
//     String fullImageUrl = "${ApiEndPoint.imageUrl}${item.coverImage ?? ""}";
//
//     return GetBuilder<TheatreController>(
//       builder: (controller) {
//         String programId = item.sId ?? "";
//         bool offLineProgram = controller.isOffLine(programId);
//
//         return GestureDetector(
//           onTap: () {
//             if (offLineProgram) {
//               controller.openReaderUrl(context, programId, title: item.title);
//             } else if (hasImage) {
//               onTap();
//             } else {
//               Get.snackbar(
//                 "Notice",
//                 "No programme available",
//                 snackPosition: SnackPosition.TOP,
//                 backgroundColor: const Color(0xFFF5A623),
//                 colorText: const Color(0xFFFFFFFF),
//                 margin: const EdgeInsets.all(12),
//                 borderRadius: 12.r,
//                 duration: const Duration(seconds: 2),
//               );
//             }
//           },
//           child: Hero(
//             tag: item.sId ?? item.title ?? UniqueKey().toString(),
//             child: Container(
//               width: width,
//               height: height,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 border: Border.all(
//                   color: offLineProgram ? Colors.greenAccent : const Color(0xFFF5A623),
//                   width: 1.5,
//                 ),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: hasImage
//                           ? CachedNetworkImage(
//                         imageUrl: fullImageUrl,
//                         fit: BoxFit.cover,
//                         memCacheWidth: (width * 2).toInt(),
//                         progressIndicatorBuilder: (context, url, downloadProgress) {
//                           return Container(
//                             color: const Color(0xFF1A2A3A),
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 value: downloadProgress.totalSize != null
//                                     ? downloadProgress.downloaded / downloadProgress.totalSize!
//                                     : null,
//                                 color: const Color(0xFFF5A623),
//                                 strokeWidth: 2,
//                               ),
//                             ),
//                           );
//                         },
//                         errorWidget: (_, __, ___) => Container(
//                           color: const Color(0xFF1A2A3A),
//                           child: Image.asset(AppImages.programImages, fit: BoxFit.cover),
//                         ),
//                       )
//                           : _buildNoPhotoImage(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildNoPhotoImage() {
//     return Container(
//       color: const Color(0xFF1A2A3A),
//       child: Image.asset(
//         AppImages.noPhoto,
//         fit: BoxFit.cover,
//         width: width,
//         height: height,
//       ),
//     );
//   }
// }


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
              errorWidget: (_, __, ___) => Container(
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