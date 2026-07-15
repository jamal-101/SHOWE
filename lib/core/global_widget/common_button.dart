import 'package:digital_event/core/common_text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? fontSize;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.fontSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFFF2A900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.w,
          child: const CircularProgressIndicator(
            color: Colors.white, // লোডারের কালার সাদা
            strokeWidth: 2.5,   // লোডারের লাইনের পুরুত্ব
          ),
        )
            : CommonText(
          text: title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: fontSize ?? 16.sp,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

