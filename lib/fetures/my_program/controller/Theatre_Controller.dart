import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/single_proram_model.dart';
import '../model/theatre_model.dart';
import 'package:digital_event/core/constans/app_images.dart';
import '../screen/reader_page.dart';
import '../screen/red_web_screen.dart';


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
    fetchProgrammes();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    update();
    fetchProgrammes();
  }

  String get currentBackground => categories[selectedCategoryIndex.value].backgroundAsset;
  String _getCategoryCacheKey(String category) => "cached_programmes_$category";

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
          _saveToLocalCache(category, response.data);
        } else {
          await _loadFromLocalCache(category);
        }
      } else {
        await _loadFromLocalCache(category);
      }
    } catch (e) {
      debugPrint("Offline mode: Loading local cache for $category");
      await _loadFromLocalCache(category);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> _saveToLocalCache(String category, dynamic rawData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getCategoryCacheKey(category), jsonEncode(rawData));
  }

  Future<void> _loadFromLocalCache(String category) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_getCategoryCacheKey(category));

    if (jsonString != null) {
      dynamic jsonMap = jsonDecode(jsonString);
      ProgrammeModel model = ProgrammeModel.fromJson(Map<String, dynamic>.from(jsonMap));
      if (model.data != null && model.data!.isNotEmpty) {
        programmeList.assignAll(model.data!);
        return;
      }
    }
    programmeList.assignAll(fallbackData);
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


  void openReaderUrl(BuildContext context, String? id, {String? title, String? heroTag}) async {
    if (id == null || id.trim().isEmpty) return;

    try {
      isLoading.value = true;
      update();

      ApiResponseModel response = await ApiService.get(ApiEndPoint.getProgramme(id));

      single_programm_model programmeDoc;

      if (response.isSuccess) {
        programmeDoc = single_programm_model.fromJson(Map<String, dynamic>.from(response.data));
        _saveReaderDocToCache(id, response.data);
      } else {
        programmeDoc = await _loadReaderDocFromCache(id);
      }

      Get.to(() => ReaderPage(
        programme: programmeDoc,
        heroTag: heroTag ?? 'reader_cover_$id',
      ));

    } catch (e) {
      debugPrint("Error opening reader: $e");
      single_programm_model cachedDoc = await _loadReaderDocFromCache(id);
      Get.to(() => ReaderPage(
        programme: cachedDoc,
        heroTag: heroTag ?? 'reader_cover_$id',
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
