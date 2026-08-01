//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/constans/app_images.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
// import '../model/favourite_event_model.dart' as ev;
// import '../model/favourite_venue_model.dart' as vn;
//
//
// class FavoriteController extends GetxController {
//   var selectedFavouriteTabIndex = 0.obs;
//
//   var isLoading = false.obs;
//   var isLoadMore = false.obs;
//   int currentPage = 1;
//   ev.Pagination? pagination;
//   List<dynamic> favoriteList = [];
//
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchFavorites(isRefresh: true);
//     scrollController.addListener(() {
//       if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//         int totalPage = pagination?.totalPage ?? 1;
//         if (currentPage <= totalPage && !isLoadMore.value && !isLoading.value) {
//           fetchFavorites(isRefresh: false);
//         }
//       }
//     });
//   }
//
//   @override
//   void onClose() {
//     scrollController.dispose();
//     super.onClose();
//   }
//
//   void changeTab(int index) {
//     selectedFavouriteTabIndex.value = index;
//     fetchFavorites(isRefresh: true);
//   }
//
//   Future<void> fetchFavorites({bool isRefresh = true}) async {
//     if (isRefresh) {
//       currentPage = 1;
//       isLoading.value = true;
//       favoriteList.clear();
//     } else {
//       isLoadMore.value = true;
//     }
//     update();
//
//     try {
//       String type = 'Event';
//       if (selectedFavouriteTabIndex.value == 1) {
//         type = 'Recommendations';
//       } else if (selectedFavouriteTabIndex.value == 2) {
//         type = 'Venue';
//       }
//       String url = "/event/interest?type=$type&page=$currentPage&limit=10";
//
//       ApiResponseModel response = await ApiService.get(url);
//
//       if (response.isSuccess) {
//         final rawData = Map<String, dynamic>.from(response.data);
//
//         if (selectedFavouriteTabIndex.value == 0) {
//           ev.Favourite_event_model incomingModel = ev.Favourite_event_model.fromJson(rawData);
//           if (incomingModel.success == true && incomingModel.data != null) {
//             // 💡 নাল অবজেক্ট ফিল্টার করে শুধু ভ্যালিড ডেটা অ্যাড করা হচ্ছে
//             var validData = incomingModel.data!.where((element) => element != null).toList();
//             favoriteList.addAll(validData);
//
//             pagination = ev.Pagination(
//               total: incomingModel.pagination?.total,
//               limit: incomingModel.pagination?.limit,
//               page: incomingModel.pagination?.page,
//               totalPage: incomingModel.pagination?.totalPage,
//             );
//             currentPage++;
//           }
//         }
//         else if (selectedFavouriteTabIndex.value == 2) {
//           // 💡 ফিক্সড: 'ev.' এর জায়গায় সঠিক প্রিফিক্স 'vn.' ব্যবহার করা হলো
//           vn.Favourite_venue_model incomingModel = vn.Favourite_venue_model.fromJson(rawData);
//           if (incomingModel.success == true && incomingModel.data != null) {
//             // 💡 ভেন্যু ডেটার জন্যও নাল চেক রাখা হলো
//             var validData = incomingModel.data!.where((element) => element != null).toList();
//             favoriteList.addAll(validData);
//
//             // pagination অ্যাসাইন করার সময় টাইপ মিসম্যাচ এড়াতে ইভেন্টের ফর্ম্যাটে কনভার্ট করা হলো
//             pagination = ev.Pagination(
//               total: incomingModel.pagination?.total,
//               limit: incomingModel.pagination?.limit,
//               page: incomingModel.pagination?.page,
//               totalPage: incomingModel.pagination?.totalPage,
//             );
//             currentPage++;
//           }
//         }
//       } else {
//         Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       debugPrint("Error fetching favorites: $e");
//     }
//     finally {
//       isLoading.value = false;
//       isLoadMore.value = false;
//       update();
//     }
//   }
//
//   final List<Map<String, dynamic>> artistData = [
//     {
//       'name': 'Song',
//       'title': 'Chester Bennington',
//       'subtitle': 'The Rolling Stones Live in Concert',
//       'time': '07:00 PM',
//       'price': '200.00',
//       'image': AppImages.artistImage,
//       'date': 'Dec 18',
//       'isFavorite': false,
//     },
//   ];
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/favourite_event_model.dart' as ev;
import '../model/favourite_venue_model.dart' as vn;

class FavoriteController extends GetxController {
  var selectedFavouriteTabIndex = 0.obs;

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  ev.Pagination? pagination;
  RxList<dynamic> favoriteList = <dynamic>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchFavorites(isRefresh: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int totalPage = pagination?.totalPage ?? 1;
        if (currentPage <= totalPage && !isLoadMore.value && !isLoading.value) {
          fetchFavorites(isRefresh: false);
        }
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    selectedFavouriteTabIndex.value = index;
    fetchFavorites(isRefresh: true);
  }

  Future<void> fetchFavorites({bool isRefresh = true}) async {
    if (isRefresh) {
      currentPage = 1;
      isLoading.value = true;
      favoriteList.clear();
    } else {
      isLoadMore.value = true;
    }
    update();

    try {
      String type = 'Event';
      if (selectedFavouriteTabIndex.value == 1) {
        type = 'Recommendations';
      } else if (selectedFavouriteTabIndex.value == 2) {
        type = 'Venue';
      }

      String url = "/event/interest?type=$type&page=$currentPage&limit=10";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        final rawData = Map<String, dynamic>.from(response.data);
        if (selectedFavouriteTabIndex.value == 0 || selectedFavouriteTabIndex.value == 1) {
          ev.Favourite_event_model incomingModel = ev.Favourite_event_model.fromJson(rawData);
          if (incomingModel.success == true && incomingModel.data != null) {
            for (var newItem in incomingModel.data!) {
              bool isExist = favoriteList.any((element) =>
              element is ev.Data && element.sId == newItem.sId);

              if (!isExist) {
                favoriteList.add(newItem);
              }
                        }

            pagination = ev.Pagination(
              total: incomingModel.pagination?.total,
              limit: incomingModel.pagination?.limit,
              page: incomingModel.pagination?.page,
              totalPage: incomingModel.pagination?.totalPage,
            );
            currentPage++;
          }
        }
        else if (selectedFavouriteTabIndex.value == 2) {
          vn.Favourite_venue_model incomingModel = vn.Favourite_venue_model.fromJson(rawData);
          if (incomingModel.success == true && incomingModel.data != null) {
            for (var newItem in incomingModel.data!) {
              bool isExist = favoriteList.any((element) =>
              element is vn.Data && element.sId == newItem.sId);

              if (!isExist) {
                favoriteList.add(newItem);
              }
                        }

            pagination = ev.Pagination(
              total: incomingModel.pagination?.total,
              limit: incomingModel.pagination?.limit,
              page: incomingModel.pagination?.page,
              totalPage: incomingModel.pagination?.totalPage,
            );
            currentPage++;
          }
        }
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching favorites: $e");
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
    }
  }

  // আর্টিস্টদের জন্য স্ট্যাটিক ডাটা
  final List<Map<String, dynamic>> artistData = [
    {
      'name': 'Song',
      'title': 'Chester Bennington',
      'subtitle': 'The Rolling Stones Live in Concert',
      'time': '07:00 PM',
      'price': '200.00',
      'image': AppImages.artistImage,
      'date': 'Dec 18',
      'isFavorite': true,
    },
  ];
}