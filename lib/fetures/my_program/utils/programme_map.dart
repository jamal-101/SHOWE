import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/single_proram_model.dart';

/// Offline map support: cache geocoded coords + static map snapshot per address.
class ProgrammeMapCache {
  ProgrammeMapCache._();

  static const _coordsKey = 'programme_map_coords_v1';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 30),
      headers: const {'User-Agent': 'DigitalEventApp/1.0 (programme-reader)'},
    ),
  );

  static String _norm(String address) => address.trim().toLowerCase();

  static String _coordsCacheKey(String address) =>
      _norm(address).hashCode.toString();

  static String snapshotFileName(String address) =>
      'map_${_norm(address).hashCode.abs()}.png';

  static Future<Directory> _mapDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/programme_maps');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  static Future<Map<String, dynamic>> _loadCoordsStore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_coordsKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return {};
  }

  static Future<void> _saveCoords(String address, LatLng coords) async {
    final prefs = await SharedPreferences.getInstance();
    final store = await _loadCoordsStore();
    store[_coordsCacheKey(address)] = {
      'lat': coords.latitude,
      'lng': coords.longitude,
      'address': address.trim(),
    };
    await prefs.setString(_coordsKey, jsonEncode(store));
  }

  static Future<LatLng?> getCachedCoords(String address) async {
    final store = await _loadCoordsStore();
    final entry = store[_coordsCacheKey(address)];
    if (entry is! Map) return null;
    final lat = (entry['lat'] as num?)?.toDouble();
    final lng = (entry['lng'] as num?)?.toDouble();
    if (lat == null || lng == null) return null;
    return LatLng(lat, lng);
  }

  static Future<File?> getSnapshotFile(String address) async {
    if (address.trim().isEmpty) return null;
    try {
      final dir = await _mapDir();
      final file = File('${dir.path}/${snapshotFileName(address)}');
      if (await file.exists() && await file.length() > 512) return file;
    } catch (_) {}
    return null;
  }

  static String _staticMapUrl(LatLng coords) {
    final lat = coords.latitude;
    final lng = coords.longitude;
    return 'https://staticmap.openstreetmap.de/staticmap.php'
        '?center=$lat,$lng'
        '&zoom=15'
        '&size=640x480'
        '&scale=2'
        '&markers=$lat,$lng,red';
  }

  static Future<File?> downloadSnapshot(String address, LatLng coords) async {
    if (address.trim().isEmpty) return null;
    final existing = await getSnapshotFile(address);
    if (existing != null) return existing;

    try {
      final dir = await _mapDir();
      final file = File('${dir.path}/${snapshotFileName(address)}');
      await _dio.download(_staticMapUrl(coords), file.path);
      if (await file.exists() && await file.length() > 512) {
        await _saveCoords(address, coords);
        return file;
      }
    } catch (e) {
      debugPrint('ProgrammeMapCache snapshot failed: $e');
    }
    return null;
  }

  /// Cache-first geocode; saves coords for offline reuse.
  static Future<LatLng?> resolveCoords(String address) async {
    final query = address.trim();
    if (query.isEmpty) return null;

    final cached = await getCachedCoords(query);
    if (cached != null) return cached;

    final online = await geocodeAddressOnline(query);
    if (online != null) {
      await _saveCoords(query, online);
    }
    return online;
  }

  static Future<void> prefetchAddress(String address) async {
    final query = address.trim();
    if (query.isEmpty) return;

    final coords = await resolveCoords(query);
    if (coords == null) return;

    final snap = await getSnapshotFile(query);
    if (snap != null) return;

    await downloadSnapshot(query, coords);
  }

  static Future<void> prefetchProgramme(single_programm_model programme) async {
    for (final page in programme.data?.pages ?? const []) {
      for (final block in page.blocks ?? const []) {
        if (block.type != 'map') continue;
        final d = block.data;
        final address = d?.address?.trim() ?? '';
        if (address.isNotEmpty) {
          prefetchAddress(address);
          continue;
        }
        if (d?.lat != null && d?.lng != null) {
          prefetchAddress('${d!.lat},${d.lng}');
        }
      }
    }
  }
}

Future<LatLng?> geocodeAddressOnline(String address) async {
  final query = address.trim();
  if (query.isEmpty) return null;
  try {
    final res = await ProgrammeMapCache._dio.get<List<dynamic>>(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: {'q': query, 'format': 'json', 'limit': 1},
    );
    final list = res.data;
    if (list == null || list.isEmpty) return null;
    final item = list.first;
    if (item is! Map) return null;
    final lat = double.tryParse('${item['lat']}');
    final lon = double.tryParse('${item['lon']}');
    if (lat == null || lon == null) return null;
    return LatLng(lat, lon);
  } catch (_) {
    return null;
  }
}

String googleMapsEmbedUrl(String address) {
  final q = Uri.encodeComponent(address.trim());
  return 'https://www.google.com/maps?q=$q&output=embed';
}

String googleMapsSearchUrl(String query) {
  return 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query.trim())}';
}

/// Backwards-compatible alias used by map preview.
Future<LatLng?> geocodeAddress(String address) => ProgrammeMapCache.resolveCoords(address);
