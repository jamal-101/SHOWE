import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../model/single_proram_model.dart';
import 'programme_image.dart';

/// Local cache for programme videos so reader works offline after first view.
class ProgrammeVideoCache {
  ProgrammeVideoCache._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 5),
    ),
  );

  static Future<Directory> _cacheDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/programme_videos');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static String fileNameForUrl(String url) {
    final uri = Uri.tryParse(url);
    final last = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : '';
    if (last.isNotEmpty && last.contains('.')) {
      return last.replaceAll(RegExp(r'[^\w.\-]'), '_');
    }
    return 'video_${url.hashCode.abs()}.mp4';
  }

  static Future<File> _fileForUrl(String url) async {
    final dir = await _cacheDir();
    return File('${dir.path}/${fileNameForUrl(url)}');
  }

  static Future<File?> getCachedFile(String url) async {
    if (url.isEmpty) return null;
    try {
      final file = await _fileForUrl(url);
      if (await file.exists() && await file.length() > 1024) return file;
    } catch (_) {}
    return null;
  }

  static Future<File?> download(String url) async {
    if (url.isEmpty) return null;
    final existing = await getCachedFile(url);
    if (existing != null) return existing;

    try {
      final file = await _fileForUrl(url);
      await _dio.download(url, file.path);
      if (await file.exists() && await file.length() > 1024) {
        return file;
      }
    } catch (e) {
      debugPrint('ProgrammeVideoCache download failed: $e');
    }
    return null;
  }

  /// Warm cache for all videos in a programme (call after online fetch).
  static Future<void> prefetchProgramme(single_programm_model programme) async {
    final urls = collectProgrammeVideoUrls(programme);
    for (final url in urls) {
      final cached = await getCachedFile(url);
      if (cached != null) continue;
      download(url);
    }
  }

  /// Deletes any downloaded video files belonging to this programme.
  /// Used when a viewed programme's 7-day offline window expires, or when
  /// it's removed from the server, so storage doesn't grow forever.
  static Future<void> deleteProgrammeVideos(single_programm_model programme) async {
    final urls = collectProgrammeVideoUrls(programme);
    for (final url in urls) {
      try {
        final file = await _fileForUrl(url);
        if (await file.exists()) await file.delete();
      } catch (_) {}
    }
  }
}

List<String> collectProgrammeVideoUrls(single_programm_model programme) {
  final urls = <String>{};

  void add(String? src) {
    final resolved = getProgrammeImageUrl(src);
    if (isProgrammeVideoUrl(resolved)) urls.add(resolved);
  }

  for (final page in programme.data?.pages ?? const []) {
    for (final block in page.blocks ?? const []) {
      final d = block.data;
      add(d?.coverImage);
      add(d?.image);
      for (final img in d?.images ?? const []) {
        add(img);
      }
    }
  }

  return urls.toList();
}
