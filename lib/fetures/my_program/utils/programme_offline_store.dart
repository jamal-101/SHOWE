import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/single_proram_model.dart';
import '../model/theatre_model.dart';
import 'programme_map.dart';
import 'programme_video_cache.dart';

/// Handles everything about what's available offline. Two separate ideas,
/// kept as two separate stores on purpose because they now behave
/// differently (per client's clarified requirement):
///
/// 1. CATALOG — which programme CARDS show up in the offline list.
///    This is cumulative: every programme the app has ever fetched from the
///    server for a category stays in the catalog, even across many online
///    sessions (session 1: A,B,C  session 2 adds D,E  -> catalog has
///    A,B,C,D,E...), so nothing disappears just because a later fetch
///    didn't happen to include it again (pagination, list re-ordering etc).
///    The ONLY thing that removes a card from the catalog is the server no
///    longer returning it at all — i.e. it was unpublished/deleted. That
///    removal is immediate, it does not wait for any expiry window.
///
/// 2. CONTENT — whether TAPPING a card actually opens something offline.
///    This is only true for programmes the user has actually opened at
///    least once. That downloaded content (reader doc + video + map) is
///    kept for 7 days after the LAST time it was opened, then deleted to
///    keep storage down. The card itself is unaffected by this — it still
///    shows in the list; tapping it will just show the "not available
///    offline" screen until the user opens it again while online.
class ProgrammeOfflineStore {
  ProgrammeOfflineStore._();

  static const _catalogKey = 'programme_catalog_index_v1';
  static const _viewedAtKey = 'programme_viewed_at_v1';
  static const Duration contentRetention = Duration(days: 7);

  // ---- catalog: { id: { 'category': String, 'card': {...ProgrammeData} } }

  static Future<Map<String, dynamic>> _loadCatalog() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_catalogKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
    return {};
  }

  static Future<void> _saveCatalog(Map<String, dynamic> catalog) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_catalogKey, jsonEncode(catalog));
  }

  // ---- viewed-at: { id: lastViewedAtMs }

  static Future<Map<String, dynamic>> _loadViewedAt() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_viewedAtKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
    return {};
  }

  static Future<void> _saveViewedAt(Map<String, dynamic> viewedAt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_viewedAtKey, jsonEncode(viewedAt));
  }

  /// Call after every successful ONLINE fetch of a category.
  /// - Adds/refreshes every item the server just returned into the
  ///   cumulative catalog for that category (so it shows offline).
  /// - Removes any previously-known card in that category that the server
  ///   no longer returns at all — immediately, plus deletes its downloaded
  ///   content (reader doc / video / map) since it's gone for good.
  static Future<void> mergeCatalog(
      String category, List<ProgrammeData> serverItems) async {
    final catalog = await _loadCatalog();
    final liveIds = <String>{};

    for (final item in serverItems) {
      final id = item.sId;
      if (id == null || id.isEmpty) continue;
      liveIds.add(id);
      catalog[id] = {
        'category': category,
        'card': item.toJson(),
      };
    }

    final removedIds = <String>[];
    catalog.forEach((id, v) {
      if (v is! Map) return;
      if (v['category'] != category) return;
      if (!liveIds.contains(id)) removedIds.add(id);
    });

    for (final id in removedIds) {
      catalog.remove(id);
      await _deleteStoredContent(id);
    }

    await _saveCatalog(catalog);
  }

  /// Every card known for a category (viewed or not), for offline display.
  static Future<List<ProgrammeData>> getCatalogForCategory(
      String category) async {
    final catalog = await _loadCatalog();
    return catalog.entries
        .where((e) => e.value is Map && e.value['category'] == category)
        .map((e) => ProgrammeData.fromJson(
            Map<String, dynamic>.from(e.value['card'] as Map)))
        .toList();
  }

  /// Call the moment a programme is actually opened online. Makes sure it's
  /// in the catalog (covers a direct/deep-link open that skipped the list)
  /// and (re)starts its 7-day content-availability timer.
  static Future<void> markViewed(String category, ProgrammeData card) async {
    final id = card.sId;
    if (id == null || id.isEmpty) return;

    final catalog = await _loadCatalog();
    catalog[id] = {'category': category, 'card': card.toJson()};
    await _saveCatalog(catalog);

    final viewedAt = await _loadViewedAt();
    viewedAt[id] = DateTime.now().millisecondsSinceEpoch;
    await _saveViewedAt(viewedAt);
  }

  /// Deletes downloaded content (reader doc / video / map) for anything not
  /// opened in the last 7 days. Cards themselves are NOT touched — they
  /// keep showing offline, they just won't open until viewed again online.
  static Future<void> purgeExpiredContent() async {
    final viewedAt = await _loadViewedAt();
    final now = DateTime.now().millisecondsSinceEpoch;

    final expiredIds = <String>[];
    viewedAt.forEach((id, ts) {
      final lastViewedAt = (ts as num?)?.toInt() ?? 0;
      if (now - lastViewedAt > contentRetention.inMilliseconds) {
        expiredIds.add(id);
      }
    });

    if (expiredIds.isEmpty) return;

    for (final id in expiredIds) {
      viewedAt.remove(id);
      await _deleteStoredContent(id);
    }
    await _saveViewedAt(viewedAt);
  }

  static Future<void> _deleteStoredContent(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('reader_doc_$id');

    if (jsonString != null) {
      try {
        final doc = single_programm_model.fromJson(
            Map<String, dynamic>.from(jsonDecode(jsonString)));
        await ProgrammeVideoCache.deleteProgrammeVideos(doc);
        await ProgrammeMapCache.deleteProgrammeMaps(doc);
      } catch (_) {}
    }

    await prefs.remove('reader_doc_$id');
  }
}
