import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/theatre_model.dart';
import 'package:digital_event/core/constans/app_images.dart';

import '../screen/red_web_screen.dart';

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


  // Future<void> openReaderUrl(String? id) async {
  //   if (id == null || id.isEmpty) return;
  //
  //   final String urlString = "https://yead3001.binarybards.online/reader/$id";
  //   final Uri url = Uri.parse(urlString);
  //
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     debugPrint("Could not launch $url");
  //   }
  // }

  // Future<void> openReaderUrl(String? id) async {
  //   if (id == null || id.isEmpty) return;
  //
  //   final String token = LocalStorage.token;
  //   final String urlString = "https://yead3001.binarybards.online/reader/$id?token=$token";
  //
  //   final Uri url = Uri.parse(urlString);
  //
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(
  //       url,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   } else {
  //     debugPrint("Could not launch $url");
  //   }
  // }

  void openReaderUrl(BuildContext context, String? id, {String? title}) {
    if (id == null || id.isEmpty) return;

    final String token = LocalStorage.token;
    // 🔹 টোকেনসহ লিঙ্ক
    final String urlString = "https://yead3001.binarybards.online/reader/$id?token=${Uri.encodeComponent(token)}";

    // 🔹 অ্যাপের ভেতরেই WebView স্ক্রিনে নিয়ে যাওয়া
    Get.to(() => ReaderWebScreen(
      readerUrl: urlString,
      title: title ?? "Reader",
    ));
  }

}
