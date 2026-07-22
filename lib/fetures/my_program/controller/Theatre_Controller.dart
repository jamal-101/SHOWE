// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:get/get.dart';
// import '../model/theatre_model.dart';
//
// class TheatreController extends GetxController {
//   var selectedCategoryIndex = 0.obs;
//   final RxList<CategoryModel> categories = <CategoryModel>[
//     CategoryModel(name: 'Theatre', backgroundAsset: AppImages.theatre),
//     CategoryModel(name: 'Sports', backgroundAsset: AppImages.sport),
//     CategoryModel(name: 'Music', backgroundAsset: AppImages.music),
//     CategoryModel(name: 'Events', backgroundAsset: AppImages.events),
//     CategoryModel(name: 'Community', backgroundAsset: AppImages.community),
//     CategoryModel(name: 'Museum', backgroundAsset: AppImages.museum),
//     CategoryModel(name: 'Ceremonies', backgroundAsset: AppImages.ceremonies),
//   ].obs;
//
//
//
//   void selectCategory(int index) {
//     selectedCategoryIndex.value = index;
//     currentOffset.value = 0;
//     update();
//   }
//   String get currentBackground =>
//       categories[selectedCategoryIndex.value].backgroundAsset;
//
//   final List<TheatreItem> allItems = [
//     TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.singleImage),
//     TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.singleImage),
//   ];
//   final List<TheatreItem> sportData = [
//     TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.sportsImage),
//     TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.sportsImage),
//   ];
//   final List<TheatreItem> musicData = [
//     TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.musicImage),
//     TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.musicImage),
//   ];
//
//   final RxInt currentOffset = 0.obs;
//
//   TheatreItem get leftItem => currentItems[currentOffset.value % currentItems.length];
//   TheatreItem get middleItem => currentItems[(currentOffset.value + 1) % currentItems.length];
//   TheatreItem get rightItem => currentItems[(currentOffset.value + 2) % currentItems.length];
//
//   List<TheatreItem> get currentItems {
//     switch (selectedCategoryIndex.value) {
//       case 0:
//         return allItems;
//       case 1:
//         return sportData;
//       case 2:
//         return musicData;
//       case 3:
//         return sportData;
//       case 4:
//         return musicData;
//       case 5:
//         return sportData;
//       default:
//         return allItems;
//     }
//   }
//
//   void onSwipeLeft() {
//     // currentOffset.value = (currentOffset.value + 1) % allItems.length;
//     currentOffset.value = (currentOffset.value + 1) % currentItems.length;
//   }
//
//   void onSwipePrev() {
//     // currentOffset.value = (currentOffset.value - 1 + allItems.length) % allItems.length;
//     currentOffset.value = (currentOffset.value - 1 + currentItems.length) % currentItems.length;
//     update();
//   }
//
//   void onItemTap(TheatreItem item) {}
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/theatre_model.dart';
import 'package:digital_event/core/constans/app_images.dart';

class TheatreController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  var isLoading = false.obs;
  RxList<ProgrammeData> programmeList = <ProgrammeData>[].obs;

  final List<ProgrammeData> fallbackData = [
    ProgrammeData(sId: '1', title: 'Until We Shatter 1', description: 'Leadership & Development...', coverImage: null),
    ProgrammeData(sId: '2', title: 'Until We Shatter 2', description: 'A powerful story...', coverImage: null),
    ProgrammeData(sId: '3', title: 'Until We Shatter 3', description: 'An epic journey...', coverImage: null),
    ProgrammeData(sId: '4', title: 'Until We Shatter 4', description: 'A gripping tale...', coverImage: null),
    ProgrammeData(sId: '5', title: 'Until We Shatter 5', description: 'The most anticipated...', coverImage: null),
    ProgrammeData(sId: '6', title: 'Until We Shatter 6', description: 'A heartfelt narrative...', coverImage: null),
    ProgrammeData(sId: '7', title: 'Until We Shatter 7', description: 'An unforgettable experience...', coverImage: null),
    ProgrammeData(sId: '8', title: 'Until We Shatter 8', description: 'Brilliant storytelling...', coverImage: null),
    ProgrammeData(sId: '9', title: 'Until We Shatter 9', description: 'A tour de force...', coverImage: null),
    ProgrammeData(sId: '10', title: 'Until We Shatter 10', description: 'The final chapter...', coverImage: null),
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
    fetchProgrammes();
    update();
  }

  String get currentBackground => categories[selectedCategoryIndex.value].backgroundAsset;

  Future<void> fetchProgrammes() async {
    try {
      isLoading.value = true;
      update();

      String category = categories[selectedCategoryIndex.value].apiValue;
      String url = "/booking?category=$category";

      ApiResponseModel response = await ApiService.get(url);
      //
      // if (response.isSuccess) {
      //   ProgrammeModel model = ProgrammeModel.fromJson(Map<String, dynamic>.from(response.data));
      //   programmeList.assignAll(model.data ?? []);
      // } else {
      //   programmeList.clear();
      // }
      if (response.isSuccess) {
        ProgrammeModel model = ProgrammeModel.fromJson(Map<String, dynamic>.from(response.data));
        if (model.data != null && model.data!.isNotEmpty) {
          programmeList.assignAll(model.data!);
        } else {
          programmeList.assignAll(fallbackData);
        }
      } else {
        programmeList.assignAll(fallbackData);
      }
    } catch (e) {
      debugPrint("Error fetching programmes: $e");
      programmeList.clear();
    } finally {
      isLoading.value = false;
      update();
    }
  }

  ProgrammeData? getItem(int index) {
    if (programmeList.isEmpty) return null;
    return programmeList[index % programmeList.length];
  }
}