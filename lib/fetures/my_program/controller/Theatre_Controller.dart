import 'package:digital_event/core/constans/app_images.dart';
import 'package:get/get.dart';
import '../model/theatre_model.dart';

class TheatreController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[
    CategoryModel(name: 'Theatre', backgroundAsset: AppImages.myProgramImag),
    CategoryModel(name: 'Sports', backgroundAsset: AppImages.myProgramImag),
    CategoryModel(name: 'Music', backgroundAsset: AppImages.myProgramImag),
    CategoryModel(name: 'Events', backgroundAsset: AppImages.myProgramImag),
    CategoryModel(name: 'Community', backgroundAsset: AppImages.myProgramImag),
    CategoryModel(name: 'Ceremonies', backgroundAsset: AppImages.myProgramImag),
  ].obs;



  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    currentOffset.value = 0;
    update();
  }
  String get currentBackground =>
      categories[selectedCategoryIndex.value].backgroundAsset;

  final List<TheatreItem> allItems = [
    TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.singleImage),
    TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.singleImage),
  ];
  final List<TheatreItem> sportData = [
    TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.sportsImage),
    TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.sportsImage),
  ];
  final List<TheatreItem> musicData = [
    TheatreItem(title: 'Until We Shatter 1', description: 'Leadership & Development...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 2', description: 'A powerful story...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 3', description: 'An epic journey...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 4', description: 'A gripping tale...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 5', description: 'The most anticipated...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 6', description: 'A heartfelt narrative...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 7', description: 'An unforgettable experience...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 8', description: 'Brilliant storytelling...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 9', description: 'A tour de force...', imageAsset: AppImages.musicImage),
    TheatreItem(title: 'Until We Shatter 10', description: 'The final chapter...', imageAsset: AppImages.musicImage),
  ];

  final RxInt currentOffset = 0.obs;

  // TheatreItem get leftItem => allItems[currentOffset.value % allItems.length];
  // TheatreItem get middleItem => allItems[(currentOffset.value + 1) % allItems.length];
  // TheatreItem get rightItem => allItems[(currentOffset.value + 2) % allItems.length];


  TheatreItem get leftItem => currentItems[currentOffset.value % currentItems.length];
  TheatreItem get middleItem => currentItems[(currentOffset.value + 1) % currentItems.length];
  TheatreItem get rightItem => currentItems[(currentOffset.value + 2) % currentItems.length];

  List<TheatreItem> get currentItems {
    switch (selectedCategoryIndex.value) {
      case 0:
        return allItems;
      case 1:
        return sportData;
      case 2:
        return musicData;
      case 3:
        return sportData;
      case 4:
        return musicData;
      case 5:
        return sportData;
      default:
        return allItems;
    }
  }

  void onSwipeLeft() {
    // currentOffset.value = (currentOffset.value + 1) % allItems.length;
    currentOffset.value = (currentOffset.value + 1) % currentItems.length;
  }

  void onSwipePrev() {
    // currentOffset.value = (currentOffset.value - 1 + allItems.length) % allItems.length;
    currentOffset.value = (currentOffset.value - 1 + currentItems.length) % currentItems.length;
    update();
  }

  void onItemTap(TheatreItem item) {}
}