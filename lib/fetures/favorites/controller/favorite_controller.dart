import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/favourite_event_model.dart' as ev;
import '../model/favourite_venue_model.dart' as vn;
import '../model/artist_favourite_model.dart' as af;




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
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
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
        type = 'Artist';
      } else if (selectedFavouriteTabIndex.value == 2) {
        type = 'Venue';
      }

      String url = "/event/interest?type=$type&page=$currentPage&limit=10";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        final rawData = Map<String, dynamic>.from(response.data);

        if (selectedFavouriteTabIndex.value == 0) {
          ev.Favourite_event_model incomingModel = ev.Favourite_event_model.fromJson(rawData);
          if (incomingModel.success == true && incomingModel.data != null) {
            for (var newItem in incomingModel.data!) {
              if (!favoriteList.any((e) => e is ev.Data && e.sId == newItem.sId)) {
                favoriteList.add(newItem);
              }
            }
            _updatePagination(incomingModel.pagination);
          }
        }
        else if (selectedFavouriteTabIndex.value == 1) {
          af.artist_favourite incomingModel = af.artist_favourite.fromJson(rawData);
          if (incomingModel.data != null) {
            for (var newItem in incomingModel.data!) {
              if (!favoriteList.any((e) => e is af.Data && e.sId == newItem.sId)) {
                favoriteList.add(newItem);
              }
            }
            _updatePagination(incomingModel.pagination);
          }
        }
        else if (selectedFavouriteTabIndex.value == 2) {
          vn.Favourite_venue_model incomingModel = vn.Favourite_venue_model.fromJson(rawData);
          if (incomingModel.data != null) {
            for (var newItem in incomingModel.data!) {
              if (!favoriteList.any((e) => e is vn.Data && e.sId == newItem.sId)) {
                favoriteList.add(newItem);
              }
            }
            _updatePagination(incomingModel.pagination);
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

  void _updatePagination(dynamic incomingPagination) {
    if (incomingPagination != null) {
      pagination = ev.Pagination(
        total: incomingPagination.total,
        limit: incomingPagination.limit,
        page: incomingPagination.page,
        totalPage: incomingPagination.totalPage,
      );
      currentPage++;
    }
  }

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
