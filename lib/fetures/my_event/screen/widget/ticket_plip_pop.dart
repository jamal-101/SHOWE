import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TicketFilePopup extends StatefulWidget {
  final String fileUrl;

  const TicketFilePopup({super.key, required this.fileUrl});

  @override
  State<TicketFilePopup> createState() => _TicketFilePopupState();
}

class _TicketFilePopupState extends State<TicketFilePopup> {
  String? localPdfPath;
  bool isPdfLoading = false;
  bool isPdfHasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.fileUrl.toLowerCase().endsWith('.pdf')) {
      _downloadAndSavePdf();
    }
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      setState(() {
        isPdfLoading = true;
      });
      final url = widget.fileUrl;
      final filename = url.split('/').last;
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(response);
      final dir = RegExp(r'android|ios/i').hasMatch(Platform.operatingSystem)
          ? Directory.systemTemp
          : Directory.current;

      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        localPdfPath = file.path;
        isPdfLoading = false;
      });
    } catch (e) {
      debugPrint("PDF Download Error: $e");
      setState(() {
        isPdfLoading = false;
        isPdfHasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPdf = widget.fileUrl.toLowerCase().endsWith('.pdf');
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.all(20.w),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32),
                Text(
                  isPdf ? "PDF" : "Image",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: const Color(0xFF0F4C5C),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 480.h,
              ),
              child: isPdf
                  ? _buildPdfWidget()
                  : _buildImageWidget(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPdfWidget() {
    if (isPdfLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
      );
    }
    if (isPdfHasError || localPdfPath == null) {
      return Center(
        child: Text(
          "Failed to load PDF Ticket",
          style: GoogleFonts.montserrat(color: Colors.red, fontSize: 14.sp),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: PDFView(
        filePath: localPdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          debugPrint("PDF View Error: $error");
        },
      ),
    );
  }
  Widget _buildImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: InteractiveViewer(
        maxScale: 4.0,
        child: Image.network(
          widget.fileUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
            );
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                SizedBox(height: 8.h),
                Text(
                  "Failed to load image ticket",
                  style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}