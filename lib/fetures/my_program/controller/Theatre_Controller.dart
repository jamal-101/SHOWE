import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';

import '../model/single_proram_model.dart';
import '../model/theatre_model.dart';
import '../utils/programme_map.dart';
import '../utils/programme_offline_store.dart';
import '../utils/programme_video_cache.dart';
import 'package:digital_event/core/constans/app_images.dart';
import '../screen/reader_page.dart';
import '../widget/program_name_error_varient.dart';


class TheatreController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  var isLoading = false.obs;
  RxList<ProgrammeData> programmeList = <ProgrammeData>[].obs;

  final List<ProgrammeData> fallbackData = [
    ProgrammeData(sId: '1', title: 'Until We Shatter 1', description: 'Leadership & Development...', coverImage: null),
    ProgrammeData(sId: '2', title: 'Until We Shatter 2', description: 'A powerful story...', coverImage: null),
  ];

  final RxList<CategoryModel> categories = <CategoryModel>[
    CategoryModel(name: 'Theatre', backgroundAsset: AppImages.theatre, apiValue: 'THEATRE'),
    CategoryModel(name: 'Sports', backgroundAsset: AppImages.sport, apiValue: 'SPORTS'),
    CategoryModel(name: 'Music', backgroundAsset: AppImages.music, apiValue: 'MUSIC'),
    CategoryModel(name: 'Events', backgroundAsset: AppImages.events, apiValue: 'EVENTS'),
    CategoryModel(name: 'Community', backgroundAsset: AppImages.community, apiValue: 'COMMUNITY'),
    CategoryModel(name: 'Museum', backgroundAsset: AppImages.museum, apiValue: 'MUSEUM'),
    CategoryModel(name: 'Ceremonies', backgroundAsset: AppImages.ceremonies, apiValue: 'CEREMONIES'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Drop only downloaded CONTENT for anything not opened in the last 7
    // days. Cards themselves are untouched by this — see
    // ProgrammeOfflineStore for why the two are separate.
    ProgrammeOfflineStore.purgeExpiredContent().whenComplete(fetchProgrammes);
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    update();
    fetchProgrammes();
  }

  String get currentBackground => categories[selectedCategoryIndex.value].backgroundAsset;

  Future<void> fetchProgrammes() async {
    String category = categories[selectedCategoryIndex.value].apiValue;
    try {
      isLoading.value = true;
      update();

      String url = "/booking?category=$category";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        ProgrammeModel model = ProgrammeModel.fromJson(Map<String, dynamic>.from(response.data));
        if (model.data != null && model.data!.isNotEmpty) {
          programmeList.assignAll(model.data!);
        } else {
          // Backend responded successfully — this category genuinely has
          // no programmes yet. This is NOT a failure, so we must not fall
          // back to dummy/cached data here; show a real empty state instead.
          programmeList.clear();
        }

        // Keep the cumulative offline catalog for this category in sync:
        // add/refresh whatever the server just returned, and immediately
        // drop anything previously known that the server no longer returns
        // at all (unpublished/deleted) — no 7-day wait for that removal.
        await ProgrammeOfflineStore.mergeCatalog(
            category, model.data ?? const <ProgrammeData>[]);
      } else {
        await _loadOfflineList(category);
      }
    } catch (e) {
      debugPrint("Offline mode: loading catalog for $category");
      await _loadOfflineList(category);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Offline entry point. Shows every card the app has ever seen for this
  /// category (the cumulative catalog), not just the last raw response —
  /// and not just the ones the user actually opened. Tapping a card whose
  /// content wasn't downloaded (never opened, or its 7-day content window
  /// lapsed) is handled separately in openReaderUrl, which falls back to
  /// the "not available offline" screen.
  Future<void> _loadOfflineList(String category) async {
    final catalog = await ProgrammeOfflineStore.getCatalogForCategory(category);
    programmeList.assignAll(catalog); // empty list -> real "no programmes" state
  }

  ProgrammeData? getItem(int index) {
    if (programmeList.isEmpty) return null;
    return programmeList[index % programmeList.length];
  }

  Future<void> _saveReaderDocToCache(String id, dynamic rawData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("reader_doc_$id", jsonEncode(rawData));
  }


  // void openReaderUrl(BuildContext context, String? id, {String? title}) {
  //   if (id == null || id.isEmpty) return;
  //
  //   final String token = LocalStorage.token;
  //
  //   final String urlString = "http://168.144.106.179:3009/reader/$id?token=${Uri.encodeComponent(token)}";
  //
  //   Get.to(() => ReaderWebScreen(
  //     readerUrl: urlString,
  //     title: title ?? "Reader",
  //   ));
  // }


  void openReaderUrl(BuildContext context, String? id, {String? title, String? heroTag, int? initialPageIndex, ProgrammeData? programmeData}) async {
    if (id == null || id.trim().isEmpty) return;

    final String category = categories[selectedCategoryIndex.value].apiValue;

    try {
      isLoading.value = true;
      update();

      ApiResponseModel response = await ApiService.get(ApiEndPoint.getProgramme(id));

      single_programm_model programmeDoc;

      if (response.isSuccess) {
        final raw = Map<String, dynamic>.from(response.data);
        programmeDoc = single_programm_model.fromJson(raw);
        _saveReaderDocToCache(id, raw);
        ProgrammeVideoCache.prefetchProgramme(programmeDoc);
        ProgrammeMapCache.prefetchProgramme(programmeDoc);

        // The user has now actually opened this programme — this is what
        // "viewed" means. Ensure it's in the offline catalog and
        // (re)start its 7-day content-availability timer.
        final card = programmeData ?? ProgrammeData(sId: id, title: title);
        await ProgrammeOfflineStore.markViewed(category, card);
      } else {
        final msg = (response.message).toLowerCase();
        final unauthorized = msg.contains('jwt') ||
            msg.contains('unauthorized') ||
            msg.contains('malformed') ||
            msg.contains('token');

        if (unauthorized) {
          Get.to(() => const ProgrammeNotFoundPage(
            variant: ProgrammeErrorVariant.unauthorized,
          ));
          return;
        }

        programmeDoc = await _loadReaderDocFromCache(id);
        if (programmeDoc.data?.pages == null ||
            programmeDoc.data!.pages!.isEmpty) {
          Get.to(() => const ProgrammeNotFoundPage(
            variant: ProgrammeErrorVariant.notFound,
          ));
          return;
        }
      }

      Get.to(() => ReaderPage(
        programme: programmeDoc,
        heroTag: heroTag ?? 'reader_cover_$id',
        initialPageIndex: initialPageIndex,
      ));
    } catch (e) {
      debugPrint("Error opening reader: $e");
      single_programm_model cachedDoc = await _loadReaderDocFromCache(id);
      if (cachedDoc.data?.pages == null || cachedDoc.data!.pages!.isEmpty) {
        Get.to(() => const ProgrammeNotFoundPage(
          variant: ProgrammeErrorVariant.notFound,
        ));
        return;
      }
      Get.to(() => ReaderPage(
        programme: cachedDoc,
        heroTag: heroTag ?? 'reader_cover_$id',
        initialPageIndex: initialPageIndex,
      ));
    } finally {
      isLoading.value = false;
      update();
    }
  }


  Future<single_programm_model> _loadReaderDocFromCache(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("reader_doc_$id");

    if (jsonString != null) {
      dynamic jsonMap = jsonDecode(jsonString);
      return single_programm_model.fromJson(jsonMap);
    }
    return single_programm_model();
  }
}