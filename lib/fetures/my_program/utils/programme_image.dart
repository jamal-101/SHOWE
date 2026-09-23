import '../../../core/utils/api_enpoint.dart';

/// Resolves relative programme media paths to absolute URLs (React `getImageUrl`).
String getProgrammeImageUrl(String? src) {
  return ApiEndPoint.getImageUrl(src);
}

bool isProgrammeVideoUrl(String? url) {
  if (url == null || url.isEmpty) return false;
  final lower = url.toLowerCase();
  return lower.endsWith('.mp4') ||
      lower.endsWith('.mov') ||
      lower.endsWith('.webm') ||
      lower.endsWith('.m3u8') ||
      lower.contains('/video/') ||
      lower.startsWith('data:video');
}
