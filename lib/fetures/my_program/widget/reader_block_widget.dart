// // import 'package:flutter/material.dart';
// // import '../model/single_proram_model.dart';
// //
// // class ReaderBlockWidget extends StatelessWidget {
// //   final Blocks block;
// //   final String? heroTag;
// //
// //   const ReaderBlockWidget({
// //     super.key,
// //     required this.block,
// //     this.heroTag,
// //   });
// //
// //   Color _resolveBg(Layout? layout) {
// //     if (layout == null || layout.background == null) return Colors.transparent;
// //
// //     switch (layout.background) {
// //       case 'sunken':
// //         return const Color(0xFFF2EFE9);
// //       case 'surface':
// //         return const Color(0xFFFBFAF7);
// //       case 'primary':
// //         return const Color(0xFF014B52);
// //       case 'accent':
// //         return const Color(0xFFF5A800);
// //       case 'dark':
// //         return Colors.black;
// //       default:
// //         if (layout.background!.startsWith('#')) {
// //           final hex = layout.background!.replaceAll('#', '');
// //           return Color(int.parse('FF$hex', radix: 16));
// //         }
// //         return Colors.transparent;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final layout = block.layout;
// //     final bgColor = _resolveBg(layout);
// //
// //     return Container(
// //       padding: EdgeInsets.only(
// //         top: (layout?.paddingTop ?? 16).toDouble(),
// //         bottom: (layout?.paddingBottom ?? 16).toDouble(),
// //         left: (layout?.paddingX ?? 16).toDouble(),
// //         right: (layout?.paddingX ?? 16).toDouble(),
// //       ),
// //       color: bgColor,
// //       child: _buildBlockContent(context, block),
// //     );
// //   }
// //
// //   Widget _buildBlockContent(BuildContext context, Blocks block) {
// //     final data = block.data;
// //     if (data == null) return const SizedBox.shrink();
// //
// //     switch (block.type) {
// //       case 'hero':
// //         return _HeroBlock(data: data, heroTag: heroTag);
// //       case 'welcome':
// //         return _WelcomeBlock(data: data);
// //       case 'poll':
// //         return _PollBlock(data: data);
// //       default:
// //         return const SizedBox.shrink();
// //     }
// //   }
// // }
// //
// // // ----------------- BLOCK PREVIEWS -----------------
// //
// // class _HeroBlock extends StatelessWidget {
// //   final BlockData data;
// //   final String? heroTag;
// //
// //   const _HeroBlock({required this.data, this.heroTag});
// //
// //   double _getHeight(String? h) {
// //     switch (h) {
// //       case 'short':
// //         return 160.0;
// //       case 'tall':
// //         return 320.0;
// //       case 'full':
// //         return 500.0;
// //       case 'medium':
// //       default:
// //         return 224.0;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final String? coverUrl = data.coverImage;
// //     final bool isVideo = coverUrl != null &&
// //         (coverUrl.toLowerCase().endsWith('.mp4') || coverUrl.toLowerCase().contains('/video/'));
// //     final bool isValidUrl = coverUrl != null && coverUrl.startsWith('http');
// //
// //     Widget imageWidget;
// //     if (isValidUrl && !isVideo) {
// //       imageWidget = Image.network(
// //         coverUrl,
// //         fit: BoxFit.cover,
// //         errorBuilder: (context, error, stackTrace) => _fallbackBg(),
// //       );
// //     } else if (isVideo) {
// //       imageWidget = Container(
// //         color: const Color(0xFF014B52),
// //         child: const Center(
// //           child: Icon(Icons.play_circle_outline, color: Colors.white70, size: 48),
// //         ),
// //       );
// //     } else {
// //       imageWidget = _fallbackBg();
// //     }
// //
// //     final bool canUseHero = heroTag != null && heroTag!.isNotEmpty && isValidUrl && !isVideo;
// //
// //     return Container(
// //       height: _getHeight(data.height),
// //       width: double.infinity,
// //       clipBehavior: Clip.antiAlias,
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF014B52),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           canUseHero ? Hero(tag: heroTag!, child: imageWidget) : imageWidget,
// //           if (data.overlay == true)
// //             Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Colors.black87, Colors.transparent],
// //                   begin: Alignment.bottomCenter,
// //                   end: Alignment.topCenter,
// //                 ),
// //               ),
// //             ),
// //           Positioned(
// //             bottom: 16,
// //             left: 16,
// //             right: 16,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 if (data.title != null)
// //                   Text(
// //                     data.title!,
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 if (data.subtitle != null) ...[
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     data.subtitle!,
// //                     style: const TextStyle(color: Colors.white70, fontSize: 14),
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _fallbackBg() => Container(color: const Color(0xFF014B52));
// // }
// //
// // class _WelcomeBlock extends StatelessWidget {
// //   final BlockData data;
// //   const _WelcomeBlock({required this.data});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         if (data.heading != null)
// //           Text(
// //             data.heading!,
// //             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
// //           ),
// //         if (data.body != null) ...[
// //           const SizedBox(height: 12),
// //           Text(
// //             data.body!,
// //             style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black54),
// //           ),
// //         ],
// //         if (data.signature != null) ...[
// //           const SizedBox(height: 12),
// //           Text(
// //             "— ${data.signature!}",
// //             style: const TextStyle(
// //               fontSize: 12,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF014B52),
// //             ),
// //           ),
// //         ],
// //       ],
// //     );
// //   }
// // }
// //
// // class _PollBlock extends StatefulWidget {
// //   final BlockData data;
// //   const _PollBlock({required this.data});
// //
// //   @override
// //   State<_PollBlock> createState() => _PollBlockState();
// // }
// //
// // class _PollBlockState extends State<_PollBlock> {
// //   String? _selectedId;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final List<Options> options = widget.data.options ?? [];
// //
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFF2EFE9),
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: Colors.black12),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           if (widget.data.question != null)
// //             Text(
// //               widget.data.question!,
// //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //           const SizedBox(height: 12),
// //           GridView.builder(
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               childAspectRatio: 2.8,
// //               crossAxisSpacing: 8,
// //               mainAxisSpacing: 8,
// //             ),
// //             itemCount: options.length,
// //             itemBuilder: (context, index) {
// //               final opt = options[index];
// //               final isSelected = _selectedId == opt.id;
// //
// //               return GestureDetector(
// //                 onTap: () => setState(() => _selectedId = opt.id),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: isSelected ? const Color(0xFF014B52) : Colors.white,
// //                     borderRadius: BorderRadius.circular(8),
// //                     border: Border.all(
// //                       color: isSelected ? const Color(0xFF014B52) : Colors.black12,
// //                     ),
// //                   ),
// //                   alignment: Alignment.center,
// //                   child: Text(
// //                     "${opt.emoji ?? ''} ${opt.label ?? ''}".trim(),
// //                     style: TextStyle(
// //                       color: isSelected ? Colors.white : Colors.black87,
// //                       fontWeight: FontWeight.w600,
// //                       fontSize: 13,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //           if (_selectedId != null && widget.data.thankYouMessage != null) ...[
// //             const SizedBox(height: 12),
// //             Text(
// //               widget.data.thankYouMessage!,
// //               style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../model/single_proram_model.dart'; // আপনার মডেলের সঠিক পাথ ব্যবহার করুন
//
// class ReaderBlockWidget extends StatelessWidget {
//   final Blocks block;
//   final String? heroTag;
//
//   const ReaderBlockWidget({
//     super.key,
//     required this.block,
//     this.heroTag,
//   });
//
//   Color _resolveBg(Layout? layout) {
//     if (layout == null || layout.background == null) return Colors.transparent;
//
//     switch (layout.background) {
//       case 'sunken':
//         return const Color(0xFFF2EFE9);
//       case 'surface':
//         return const Color(0xFFFBFAF7);
//       case 'primary':
//         return const Color(0xFF014B52);
//       case 'accent':
//         return const Color(0xFFF5A800);
//       case 'dark':
//         return Colors.black;
//       default:
//         if (layout.background!.startsWith('#')) {
//           final hex = layout.background!.replaceAll('#', '');
//           return Color(int.parse('FF$hex', radix: 16));
//         }
//         return Colors.transparent;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final layout = block.layout;
//     final bgColor = _resolveBg(layout);
//
//     return Container(
//       padding: EdgeInsets.only(
//         top: (layout?.paddingTop ?? 12).toDouble().h,
//         bottom: (layout?.paddingBottom ?? 12).toDouble().h,
//         left: (layout?.paddingX ?? 16).toDouble().w,
//         right: (layout?.paddingX ?? 16).toDouble().w,
//       ),
//       color: bgColor,
//       child: _buildBlockContent(context, block),
//     );
//   }
//
//   Widget _buildBlockContent(BuildContext context, Blocks block) {
//     // block.data null হলেও fallback অবজেক্ট পাঠাবে
//     final data = block.data ?? BlockData();
//
//     switch (block.type) {
//       case 'hero':
//         return _HeroBlock(data: data, heroTag: heroTag);
//       case 'welcome':
//         return _WelcomeBlock(data: data);
//       case 'schedule':
//         return _ScheduleBlock(data: data);
//       case 'accessibility':
//         return _AccessibilityBlock(data: data);
//       case 'poll':
//         return _PollBlock(data: data);
//       case 'review':
//         return _ReviewBlock(data: data);
//       case 'merchandise':
//         return _MerchandiseBlock(data: data);
//       default:
//         return const SizedBox.shrink();
//     }
//   }
// }
//
// // ----------------- HERO BLOCK -----------------
// class _HeroBlock extends StatelessWidget {
//   final BlockData data;
//   final String? heroTag;
//
//   const _HeroBlock({required this.data, this.heroTag});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = data.title ?? "Grand Opening Gala";
//     final String subtitle = data.subtitle ?? "Join us for an unforgettable evening";
//     final String coverUrl = (data.coverImage != null && data.coverImage!.startsWith('http'))
//         ? data.coverImage!
//         : "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=1000";
//
//     final bool canUseHero = heroTag != null && heroTag!.isNotEmpty;
//
//     Widget imageWidget = Image.network(
//       coverUrl,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF014B52)),
//     );
//
//     return Container(
//       height: 220.h,
//       width: double.infinity,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: const Color(0xFF014B52),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           canUseHero ? Hero(tag: heroTag!, child: imageWidget) : imageWidget,
//           Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               gradient: const LinearGradient(
//                 colors: [Colors.black87, Colors.transparent],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   subtitle,
//                   style: TextStyle(color: Colors.white70, fontSize: 13.sp),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ----------------- WELCOME BLOCK -----------------
// class _WelcomeBlock extends StatelessWidget {
//   final BlockData data;
//   const _WelcomeBlock({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final String heading = data.heading ?? "Welcome Music Lovers!";
//     final String body = data.body ?? "We are thrilled to present this year's lineup featuring top international artists.";
//     final String signature = data.signature ?? "The Event Team";
//
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFBFAF7),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(heading, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
//           SizedBox(height: 8.h),
//           Text(body, style: TextStyle(fontSize: 13.sp, color: Colors.black54, height: 1.4)),
//           SizedBox(height: 10.h),
//           Text("— $signature", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF014B52))),
//         ],
//       ),
//     );
//   }
// }
//
// // ----------------- SCHEDULE BLOCK -----------------
// class _ScheduleBlock extends StatelessWidget {
//   final BlockData data;
//   const _ScheduleBlock({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = data.title ?? "SCHEDULE";
//     // ব্যাকএন্ডে লিস্ট ফাঁকা থাকলে ডিফল্ট শিডিউল
//     final List items = (data.options != null && data.options!.isNotEmpty)
//         ? data.options!
//         : [
//       {"time": "10:00 AM", "label": "Opening Ceremony", "note": "Main Stage"},
//       {"time": "02:00 PM", "label": "Live Performance", "note": "Auditorium"},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title.toUpperCase(),
//           style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.black45),
//         ),
//         SizedBox(height: 12.h),
//         ...items.map((item) {
//           final isMap = item is Map;
//           final time = isMap ? item['time'] : "12:00 PM";
//           final label = isMap ? item['label'] : (item.label ?? "Event Session");
//           final note = isMap ? item['note'] : "General Hall";
//
//           return Container(
//             padding: EdgeInsets.symmetric(vertical: 10.h),
//             decoration: const BoxDecoration(
//               border: Border(top: BorderSide(color: Colors.black12)),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 70.w,
//                   child: Text(time ?? "12:00 PM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: const Color(0xFF014B52))),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(label ?? "Session", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
//                       if (note != null)
//                         Text(note, style: TextStyle(fontSize: 11.sp, color: Colors.black45)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
//
// // ----------------- ACCESSIBILITY BLOCK -----------------
// class _AccessibilityBlock extends StatelessWidget {
//   final BlockData data;
//   const _AccessibilityBlock({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = data.title ?? "ACCESSIBILITY";
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title.toUpperCase(),
//           style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black45),
//         ),
//         SizedBox(height: 12.h),
//         Row(
//           children: [
//             Container(
//               width: 36.w,
//               height: 36.h,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF014B52).withValues(alpha: 0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.accessibility, color: const Color(0xFF014B52), size: 18.sp),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Wheelchair Accessible", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
//                   Text("Ramps available at all main entrances.", style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// // ----------------- POLL BLOCK -----------------
// class _PollBlock extends StatefulWidget {
//   final BlockData data;
//   const _PollBlock({required this.data});
//
//   @override
//   State<_PollBlock> createState() => _PollBlockState();
// }
//
// class _PollBlockState extends State<_PollBlock> {
//   String? _selectedId;
//
//   @override
//   Widget build(BuildContext context) {
//     final String question = widget.data.question ?? "Which genre are you most excited about?";
//     final String thankYouMessage = widget.data.thankYouMessage ?? "Thanks for voting! Enjoy the show.";
//
//     final List<Options> options = (widget.data.options != null && widget.data.options!.isNotEmpty)
//         ? widget.data.options!
//         : [
//       Options(id: "opt_1", label: "Rock / Metal", emoji: "🎸"),
//       Options(id: "opt_2", label: "Electronic / EDM", emoji: "🎧"),
//       Options(id: "opt_3", label: "Jazz & Blues", emoji: "🎷"),
//       Options(id: "opt_4", label: "Acoustic Pop", emoji: "🎤"),
//     ];
//
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF2EFE9),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.black12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(question, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
//           SizedBox(height: 12.h),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 2.8,
//               crossAxisSpacing: 8.w,
//               mainAxisSpacing: 8.h,
//             ),
//             itemCount: options.length,
//             itemBuilder: (context, index) {
//               final opt = options[index];
//               final isSelected = _selectedId == opt.id;
//
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedId = opt.id ?? "$index"),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: isSelected ? const Color(0xFF014B52) : Colors.white,
//                     borderRadius: BorderRadius.circular(8.r),
//                     border: Border.all(
//                       color: isSelected ? const Color(0xFF014B52) : Colors.black12,
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     "${opt.emoji ?? ''} ${opt.label ?? ''}".trim(),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black87,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12.sp,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           if (_selectedId != null) ...[
//             SizedBox(height: 12.h),
//             Text(
//               thankYouMessage,
//               style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12.sp),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
//
// // ----------------- REVIEW BLOCK -----------------
// class _ReviewBlock extends StatelessWidget {
//   final BlockData data;
//   const _ReviewBlock({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           data.heading ?? 'Leave a Review',
//           style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           maxLines: 3,
//           decoration: InputDecoration(
//             hintText: 'Write your thoughts...',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//         ),
//         SizedBox(height: 12.h),
//         SizedBox(
//           width: double.infinity,
//           height: 40.h,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF014B52),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//             ),
//             onPressed: () {},
//             child: Text(
//               'Submit',
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.sp),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ----------------- MERCHANDISE BLOCK -----------------
// class _MerchandiseBlock extends StatelessWidget {
//   final BlockData data;
//   const _MerchandiseBlock({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = data.title ?? "OFFICIAL MERCHANDISE";
//
//     final List items = [
//       {"name": "Fest T-Shirt", "price": "\$25"},
//       {"name": "Custom Cap", "price": "\$15"},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title.toUpperCase(),
//           style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black45),
//         ),
//         SizedBox(height: 12.h),
//         ...items.map((it) => Container(
//           margin: EdgeInsets.only(bottom: 8.h),
//           padding: EdgeInsets.all(12.w),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.r),
//             border: Border.all(color: Colors.black12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(it['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
//               Text(it['price']!, style: TextStyle(color: const Color(0xFF014B52), fontWeight: FontWeight.bold, fontSize: 13.sp)),
//             ],
//           ),
//         )),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:video_player/video_player.dart';
import '../model/single_proram_model.dart'; // আপনার মডেলের সঠিক পাথ ব্যবহার করুন

class ReaderBlockWidget extends StatelessWidget {
  final Blocks block;
  final String? heroTag;

  const ReaderBlockWidget({
    super.key,
    required this.block,
    this.heroTag,
  });

  Color _resolveBg(Layout? layout) {
    if (layout == null || layout.background == null) return Colors.transparent;

    switch (layout.background) {
      case 'sunken':
        return const Color(0xFFF2EFE9);
      case 'surface':
        return const Color(0xFFFBFAF7);
      case 'primary':
        return const Color(0xFF014B52);
      case 'accent':
        return const Color(0xFFF5A800);
      case 'dark':
        return const Color(0xFF1A1A1A);
      case 'none':
        return Colors.transparent;
      default:
        if (layout.background!.startsWith('#')) {
          final hex = layout.background!.replaceAll('#', '');
          return Color(int.parse('FF$hex', radix: 16));
        }
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = block.layout;
    final bgColor = _resolveBg(layout);

    return Container(
      padding: EdgeInsets.only(
        top: (layout?.paddingTop ?? 12).toDouble().h,
        bottom: (layout?.paddingBottom ?? 12).toDouble().h,
        left: (layout?.paddingX ?? 16).toDouble().w,
        right: (layout?.paddingX ?? 16).toDouble().w,
      ),
      color: bgColor,
      child: _buildBlockContent(context, block),
    );
  }

  Widget _buildBlockContent(BuildContext context, Blocks block) {
    final data = block.data ?? BlockData();

    switch (block.type) {
      case 'hero':
        return _HeroBlock(data: data, heroTag: heroTag);
      case 'welcome':
        return _WelcomeBlock(data: data);
      case 'cast_grid':
        return _CastGridBlock(data: data);
      case 'poll':
        return _PollBlock(data: data);
      case 'map':
        return _MapBlock(data: data);
      case 'directions':
        return _DirectionsBlock(data: data);
      case 'schedule':
        return _ScheduleBlock(data: data);
      case 'accessibility':
        return _AccessibilityBlock(data: data);
      case 'review':
        return _ReviewBlock(data: data);
      case 'merchandise':
        return _MerchandiseBlock(data: data);
      default:
        return const SizedBox.shrink();
    }
  }
}




// class _HeroBlock extends StatelessWidget {
//   final BlockData data;
//   final String? heroTag;
//
//   const _HeroBlock({required this.data, this.heroTag});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = data.title ?? "Welcome to the show";
//     final String subtitle = data.subtitle ?? "Tonight at the Royal Crescent Theatre";
//
//     String coverUrl = data.coverImage ?? "";
//     if (coverUrl.startsWith('/')) {
//       coverUrl = "https://your-domain.com$coverUrl";
//     } else if (!coverUrl.startsWith('http')) {
//       coverUrl = "https://images.unsplash.com/photo-1503095396549-807759245b35?q=80&w=1600";
//     }
//
//     final bool isFullScreen = data.height == 'full';
//
//     return Container(
//       height: isFullScreen ? MediaQuery.of(context).size.height * 0.65 : 220.h,
//       width: double.infinity,
//       clipBehavior: Clip.antiAlias,
//       decoration: const BoxDecoration(
//         color: Colors.black,
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(
//             coverUrl,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: Colors.black,
//             ),
//           ),
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.black, Colors.transparent],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 stops: [0.0, 0.4],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 20.w,
//             right: 20.w,
//             bottom: 20.h,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 6.h),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _HeroBlock extends StatelessWidget {
  final BlockData data;
  final String? heroTag;

  const _HeroBlock({required this.data, this.heroTag});

  // URL টা সঠিক ফরম্যাটে আনবে (Relative path কে Full URL করবে)
  String _getFormattedUrl(String url) {
    if (url.startsWith('/')) {
      return "https://your-domain.com$url"; // আপনার আসল API Base URL দিয়ে দিন
    }
    return url;
  }

  // URL বা টাইপ দেখে ভিডিও নিশ্চিত করার হেলপার
  bool _isVideo(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.endsWith('.mp4') ||
        lowerUrl.endsWith('.mov') ||
        lowerUrl.endsWith('.m3u8') ||
        lowerUrl.endsWith('.webm');
  }

  @override
  Widget build(BuildContext context) {
    final String title = data.title ?? "Welcome to the show";
    final String subtitle = data.subtitle ?? "Tonight at the Royal Crescent Theatre";

    // API থেকে আসা ইমেজ বা ভিডিওর পথ
    final String rawMediaUrl = data.coverImage ?? "";
    final String mediaUrl = _getFormattedUrl(rawMediaUrl);
    final bool isVideoContent = _isVideo(mediaUrl);

    final bool isFullScreen = data.height == 'full';

    return Container(
      height: isFullScreen ? MediaQuery.of(context).size.height * 0.65 : 220.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🎥 ভিডিও অথবা 🖼️ ছবি রেন্ডারিং
          isVideoContent && mediaUrl.isNotEmpty
              ? _HeroVideoPlayer(videoUrl: mediaUrl)
              : _buildImageWidget(mediaUrl),

          // টেক্সট পড়ার সুবিধার জন্য ডার্ক গ্র্যাডিয়েন্ট ওভারলে
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.4],
              ),
            ),
          ),

          // টাইটেল এবং সাবটাইটেল
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String url) {
    final bool canUseHero = heroTag != null && heroTag!.isNotEmpty;

    Widget image = Image.network(
      url.isNotEmpty ? url : "https://images.unsplash.com/photo-1503095396549-807759245b35?q=80&w=1600",
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.broken_image, color: Colors.white38, size: 40),
        ),
      ),
    );

    return canUseHero ? Hero(tag: heroTag!, child: image) : image;
  }
}

// ----------------- VIDEO PLAYER WIDGET -----------------
class _HeroVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const _HeroVideoPlayer({required this.videoUrl});

  @override
  State<_HeroVideoPlayer> createState() => _HeroVideoPlayerState();
}

class _HeroVideoPlayerState extends State<_HeroVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true); // অটো লুপ হবে
        _controller.setVolume(0.0);   // মিউট অবস্থায় অটো প্লে হবে
        _controller.play();
      }).catchError((error) {
        debugPrint("Video initialization failed: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white38),
      ),
    );
  }
}

// ----------------- WELCOME BLOCK -----------------
class _WelcomeBlock extends StatelessWidget {
  final BlockData data;
  const _WelcomeBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final String heading = data.heading ?? "A warm welcome";
    final String body = data.body ?? "Thank you for joining us tonight.";
    final String signature = data.signature ?? "";

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
          SizedBox(height: 8.h),
          Text(body, style: TextStyle(fontSize: 13.sp, color: Colors.black54, height: 1.4)),
          if (signature.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text("— $signature", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF014B52))),
          ]
        ],
      ),
    );
  }
}

// ----------------- CAST GRID BLOCK -----------------
class _CastGridBlock extends StatelessWidget {
  final BlockData data;
  const _CastGridBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final String title = data.title ?? "Cast";
    final String description = data.description ?? "Tap a card to read performer’s biography.";
    final List members = data.members ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 2.h),
        Text(description, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: data.columns ?? 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
          ),
          itemBuilder: (context, index) {
            final member = members[index];
            final name = member.name ?? "";
            final role = member.role ?? "";
            final img = member.image ?? "";

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                      child: Image.network(
                        img,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp), maxLines: 1),
                        Text(role, style: TextStyle(fontSize: 11.sp, color: const Color(0xFF014B52))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}




class _PollBlock extends StatefulWidget {
  final BlockData data;
  const _PollBlock({required this.data});

  @override
  State<_PollBlock> createState() => _PollBlockState();
}

class _PollBlockState extends State<_PollBlock> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final String question = widget.data.question ?? "How did Act I land for you?";
    final List options = widget.data.options ?? [];

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F5EE),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemBuilder: (context, index) {
              final opt = options[index];
              final isSelected = _selectedId == opt.id;

              return GestureDetector(
                onTap: () => setState(() => _selectedId = opt.id ?? "$index"),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF014B52) : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (opt.emoji != null) ...[
                        Text(opt.emoji, style: TextStyle(fontSize: 14.sp)),
                        SizedBox(width: 6.w),
                      ],
                      Text(
                        opt.label ?? '',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
// ----------------- MAP BLOCK (UPDATED) -----------------
class _MapBlock extends StatelessWidget {
  final BlockData data;
  const _MapBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final String title = data.title ?? "FIND US";
    final String address = data.address ?? "";
    final double lat = data.lat ?? 51.3873;
    final double lng = data.lng ?? -2.3669;
    final bool showParking = data.showParking ?? false;
    final bool showAccessibility = data.showAccessibilityRoute ?? false;

    final LatLng locationLatLng = LatLng(lat, lng);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header
        Padding(
          padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF014B52),
              letterSpacing: 1.5,
            ),
          ),
        ),

        // Main Container Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F2EC),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Interactive Google Map View
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: locationLatLng,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('venue_location'),
                        position: locationLatLng,
                        infoWindow: InfoWindow(
                          title: "Royal Crescent Theatre",
                          snippet: address,
                        ),
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                ),
              ),

              // Content Details Section
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address Box
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFECE4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Royal Crescent Theatre",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Badge Tags
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        if (showParking)
                          _buildBadge(Icons.local_parking_rounded, "Parking available"),
                        if (showAccessibility)
                          _buildBadge(Icons.accessible_forward_rounded, "Accessibility route shown"),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Co-ordinates Footer Text
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, size: 14.sp, color: const Color(0xFF014B52)),
                        SizedBox(width: 4.w),
                        Text(
                          "Preview anchored at ${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF014B52),
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
      ],
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE8E5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFB8D3CE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF014B52)),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF014B52),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- DIRECTIONS BLOCK (PIXEL PERFECT) -----------------
class _DirectionsBlock extends StatelessWidget {
  final BlockData data;
  const _DirectionsBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final String title = data.title ?? "GETTING HERE";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header
        Padding(
          padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF014B52),
              letterSpacing: 1.5,
            ),
          ),
        ),

        // List of Direction Cards
        if (data.byTrain != null) _buildDirectionCard("BY TRAIN", data.byTrain!),
        if (data.byCar != null) _buildDirectionCard("BY CAR", data.byCar!),
        if (data.byBus != null) _buildDirectionCard("BY BUS", data.byBus!),
        if (data.parkingInfo != null) _buildDirectionCard("PARKING", data.parkingInfo!),
      ],
    );
  }

  Widget _buildDirectionCard(String label, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2EC),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black54,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

  Widget _buildDirectionCard(String label, String description) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F5EE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black54,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }


// ----------------- SCHEDULE BLOCK -----------------
class _ScheduleBlock extends StatelessWidget {
  final BlockData data;
  const _ScheduleBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data.title ?? "SCHEDULE", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
    );
  }
}

// ----------------- ACCESSIBILITY BLOCK -----------------
class _AccessibilityBlock extends StatelessWidget {
  final BlockData data;
  const _AccessibilityBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data.title ?? "ACCESSIBILITY", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
    );
  }
}

// ----------------- REVIEW BLOCK -----------------
class _ReviewBlock extends StatelessWidget {
  final BlockData data;
  const _ReviewBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data.heading ?? "Leave a Review", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
    );
  }
}

// ----------------- MERCHANDISE BLOCK -----------------
class _MerchandiseBlock extends StatelessWidget {
  final BlockData data;
  const _MerchandiseBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data.title ?? "MERCHANDISE", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
    );
  }
}