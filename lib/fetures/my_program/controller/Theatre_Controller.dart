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
    CategoryModel(name: 'Games', backgroundAsset: AppImages.myProgramImag),
  ].obs;



  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
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

  final RxInt currentOffset = 0.obs;

  TheatreItem get leftItem => allItems[currentOffset.value % allItems.length];
  TheatreItem get middleItem => allItems[(currentOffset.value + 1) % allItems.length];
  TheatreItem get rightItem => allItems[(currentOffset.value + 2) % allItems.length];

  void onSwipeLeft() {
    currentOffset.value = (currentOffset.value + 1) % allItems.length;
  }

  void onSwipePrev() {
    currentOffset.value = (currentOffset.value - 1 + allItems.length) % allItems.length;
  }

  void onItemTap(TheatreItem item) {}
}