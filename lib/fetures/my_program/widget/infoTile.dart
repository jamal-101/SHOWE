// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../model/theatre_model.dart';
//
// class InfoTile extends StatelessWidget {
//   final TheatreItem item;
//
//   const InfoTile({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           item.title,
//           style: GoogleFonts.montserrat(
//             color: Color(0xFFF2A900),
//             fontWeight: FontWeight.w600,
//             fontSize: 12.sp,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           item.description,
//           style: GoogleFonts.montserrat(
//             color: Color(0xFF979797),
//             fontSize: 12,
//             fontWeight: FontWeight.w400
//           ),
//           maxLines: 6,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
// }