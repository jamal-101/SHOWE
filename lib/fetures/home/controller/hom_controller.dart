import 'package:get/get.dart';
import '../../../core/constans/app_images.dart';

class HomController extends GetxController{
  var selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
    update();
  }


  ///>>>>>>>>>>>>>>>>> togoleFavorite <<<<<<<<<<<<<///
  void toggleFavorite(Map<String, dynamic> item) {
    item['isFavorite'] = !(item['isFavorite'] ?? false);
    update();
  }

  ///>>>>>>>>>>>>>>>> Event <<<<<<<<<///

  final List<Map<String, dynamic>> eventData = [
    {
      'name': 'Music',
      'title': 'The Rolling Stones Live in Concert',
      'subtitle': 'Live Performance',
      'time': '08:00 PM',
      'price': '120.00',
      'image': AppImages.eventImage,
      'date': 'Dec 18',
      'isFavorite': false,
    },
  ];

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Artist <<<<<<<<<<<<<<<<<<<///

  final List<Map<String, dynamic>> artistData = [
    {
      'name': 'Music',
      'title': 'Chester Bennington',
      'subtitle': 'The Rolling Stones Live in Concert',
      'time': '07:00 PM',
      'price': '200.00',
      'image': AppImages.artistImage,
      'date': 'Dec 18',
      'isFavorite': false,
    },
  ];

  ///>>>>>>>>>>>>>>>>>>>>>>> Venue Data <<<<<<<<<<<<<<<<<<<<<<///
  final List<Map<String, dynamic>> venuesData = [
    {
      'name': 'Gala Convention Center',
      'address': '123 Golf Street, UK',
      'date': '12 April, 2026',
    },
  ];

}

