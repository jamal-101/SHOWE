import '../../../core/utils/api_enpoint.dart';

/// Resolves relative programme media paths to absolute URLs (React `getImageUrl`).
String getProgrammeImageUrl(String? src) {
  if (src == null) return '';
  final value = src.trim();
  if (value.isEmpty) return '';
  if (value.startsWith('http://') ||
      value.startsWith('https://') ||
      value.startsWith('data:')) {
    return value;
  }
  final base = ApiEndPoint.imageUrl.endsWith('/')
      ? ApiEndPoint.imageUrl.substring(0, ApiEndPoint.imageUrl.length - 1)
      : ApiEndPoint.imageUrl;
  final path = value.startsWith('/') ? value : '/$value';
  return '$base$path';
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
