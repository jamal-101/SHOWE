import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../favorites/controller/favorite_controller.dart';
import '../model/event_details_model.dart';
import '../model/event_model.dart' hide Data;
import '../model/venue_details_model.dart' hide Data;
import '../model/venue_model.dart' as VenueModel;
import '../model/event_model.dart' as EventModel;
import '../model/venue_details_model.dart' as VenueDetails;
import '../../favorites/model/favourite_event_model.dart' as ev;
import '../../favorites/model/favourite_venue_model.dart' as vn;


class HomController extends GetxController{
  var selectedTabIndex = 0.obs;

  var isEventLoading = false.obs;
  var isLoadMore = false.obs;
  var isVenueLoadMore = false.obs;
  int currentPage = 1;
  int currentVenuePage = 1;
  Event_model eventModel = Event_model(data: []);
  final ScrollController scrollController = ScrollController();

  List<VenueModel.Data> venueList = [];
  var isVenueLoading = false.obs;
  VenueModel.Pagination? venuePagination;

  var isDetailsLoading = false.obs;
  Event_details_model? eventDetailsModel;



  @override
  void onInit() {
    super.onInit();
    fetchEvents(isRefresh: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (selectedTabIndex.value == 0) {
          // ইভেন্ট লোড মোর
          int totalPage = eventModel.pagination?.totalPage ?? 1;
          if (currentPage <= totalPage && !isLoadMore.value) {
            fetchEvents(isRefresh: false);
          }
        } else if (selectedTabIndex.value == 2) {
          // ভেন্যু লোড মোর
          int totalPage = venuePagination?.totalPage ?? 1;
          if (currentVenuePage <= totalPage && !isVenueLoadMore.value) {
            fetchVenues(isRefresh: false);
          }
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
    selectedTabIndex.value = index;
    update();
    if (index == 2 && venueList.isEmpty) {
      fetchVenues();
    }
  }


  Future<void> fetchEvents({bool isRefresh = true}) async {
    if (isRefresh) {
      currentPage = 1;
      isEventLoading.value = true;
      eventModel.data = [];
    } else {
      isLoadMore.value = true;
    }
    update();
    try {
      String url = "/event/search?page=$currentPage&limit=10";
      ApiResponseModel response = await ApiService.get(url);
      if (response.isSuccess) {
        Event_model incomingModel = Event_model.fromJson(Map<String, dynamic>.from(response.data));
        if (incomingModel.success == true && incomingModel.data != null) {
          eventModel.success = incomingModel.success;
          eventModel.message = incomingModel.message;
          eventModel.pagination = incomingModel.pagination;
          eventModel.data!.addAll(incomingModel.data!);
          currentPage++;
        }
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
    } finally {
      isEventLoading.value = false;
      isLoadMore.value = false;
      update();
    }
  }


  Future<void> fetchEventDetails(String eventId) async {
    try {
      isDetailsLoading.value = true;
      eventDetailsModel = null;
      update();

      String url = "/event/$eventId";
      ApiResponseModel response = await ApiService.get(url);
      if (response.isSuccess) {
        eventDetailsModel = Event_details_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching event details: $e");
    } finally {
      isDetailsLoading.value = false;
      update();
    }
  }


  Future<void> fetchVenues({bool isRefresh = true}) async {
    if (isRefresh) {
      currentVenuePage = 1;
      isVenueLoading.value = true;
      venueList = [];
    } else {
      isVenueLoadMore.value = true;
    }
    update();

    try {
      String url = "${ApiEndPoint.getVenues}?page=$currentVenuePage&limit=10";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        VenueModel.Venue_model incomingVenueModel = VenueModel.Venue_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        if (incomingVenueModel.success == true && incomingVenueModel.data != null) {
          venueList.addAll(incomingVenueModel.data!);
          venuePagination = incomingVenueModel.pagination;
          currentVenuePage++;
        }
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching venues: $e");
    } finally {
      isVenueLoading.value = false;
      isVenueLoadMore.value = false;
      update();
    }
  }


  var isVenueDetailsLoading = false.obs;
  venue_Details_Model? venueDetailsModel;

  Future<void> fetchVenueDetails(String venueId) async {
    try {
      isVenueDetailsLoading.value = true;
      venueDetailsModel = null;
      update();

      String url = "/vanue/$venueId"; // তোমার স্ক্রিনশটের রুট অনুযায়ী
      ApiResponseModel response = await ApiService.get(url);
      if (response.isSuccess) {
        venueDetailsModel = venue_Details_Model.fromJson(
          Map<String, dynamic>.from(response.data),
        );
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching venue details: $e");
    } finally {
      isVenueDetailsLoading.value = false;
      update();
    }
  }
  ///>>>>>>>>>>>>>>>>> togoleFavorite <<<<<<<<<<<<<///

  // Future<void> toggleFavorite(dynamic item) async {
  //   String? itemId;
  //   String? itemType;
  //   if (item is EventModel.Data) {
  //     item.isFavorited = !(item.isFavorited ?? false);
  //     itemId = item.sId;
  //     itemType = 'Event';
  //   }
  //   else if (item is VenueModel.Data) {
  //     item.isFavorited = !(item.isFavorited ?? false);
  //     itemId = item.sId;
  //     itemType = 'Venue';
  //   }
  //   else if (item is VenueDetails.Data) {
  //     item.isFavorited = !(item.isFavorited ?? false);
  //     itemId = item.sId;
  //     itemType = 'Venue';
  //   }
  //   else if (item is Data) {
  //     item.isFavorited = !(item.isFavorited ?? false);
  //     itemId = item.sId;
  //     itemType = 'Event';
  //   }
  //   if (itemId == null || itemId.isEmpty || itemType == null) return;
  //
  //   update();
  //
  //   try {
  //
  //     String url = "/event/interest/$itemId";
  //     Map<String, dynamic> body = {
  //       "type": itemType
  //     };
  //
  //     ApiResponseModel response = await ApiService.post(url,body: body);
  //
  //     if (response.isSuccess) {
  //       debugPrint("Successfully toggled favorite for $itemType: $itemId");
  //       if (Get.isRegistered<FavoriteController>()) {
  //         final favController = Get.find<FavoriteController>();
  //         favController.favoriteList.removeWhere((element) {
  //           if (element is ev.Data) return element.sId == itemId;
  //           if (element is vn.Data) return element.sId == itemId;
  //           return false;
  //         });
  //         favController.update();
  //       }
  //     } else {
  //       _rollbackStatus(item);
  //       Get.snackbar("Error", "Could not update favorite status");
  //     }
  //   } catch (e) {
  //     debugPrint("Favorite Error: $e");
  //     _rollbackStatus(item);
  //   }
  // }


  // lib/fetures/home/controller/hom_controller.dart

  Future<void> toggleFavorite(dynamic item) async {
    String? itemId;
    String? itemType;

    if (item is EventModel.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Event';
    }
    else if (item is VenueModel.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Venue';
    }
    else if (item is VenueDetails.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Venue';
    }
    // >>> ফেভারিট স্ক্রিন থেকে আসা ইভেন্টের জন্য নিচের অংশটুকু যোগ করুন <<<
    else if (item is ev.Data) {
      itemId = item.sId;
      itemType = 'Event';
      // যেহেতু ফেভারিট লিস্টে আছে, তাই এটি ডিফল্ট ট্রু ধরে নেওয়া যায়
    }
    // >>> ফেভারিট স্ক্রিন থেকে আসা ভেন্যুর জন্য নিচের অংশটুকু যোগ করুন <<<
    else if (item is vn.Data) {
      itemId = item.sId;
      itemType = 'Venue';
    }

    // যদি আইডি না পায় তবে এখানেই থেমে যাবে (আপনার ক্ষেত্রে এটিই হচ্ছিল)
    if (itemId == null || itemId.isEmpty || itemType == null) {
      debugPrint("Error: Item ID or Type not found for ${item.runtimeType}");
      return;
    }

    update(); // UI রিফ্রেশ

    try {
      String url = "/event/interest/$itemId";
      Map<String, dynamic> body = {"type": itemType};

      ApiResponseModel response = await ApiService.post(url, body: body);

      if (response.isSuccess) {
        debugPrint("Successfully toggled favorite for $itemType: $itemId");

        // ফেভারিট স্ক্রিন থেকে রিমুভ করার লজিক
        if (Get.isRegistered<FavoriteController>()) {
          final favController = Get.find<FavoriteController>();
          favController.favoriteList.removeWhere((element) {
            if (element is ev.Data) return element.sId == itemId;
            // if (element is vn.Data) return element.sId == itemId;
            return false;
          });
          favController.update();
        }
      } else {
        Get.snackbar("Error", "Could not update favorite status");
      }
    } catch (e) {
      debugPrint("Favorite Error: $e");
    }
  }


  void _rollbackStatus(dynamic item) {
    if (item is EventModel.Data || item is VenueModel.Data || item is VenueDetails.Data || item is Data) {
      item.isFavorited = !(item.isFavorited ?? false);
    }
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
      'name': 'Song',
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



  List<Map<String, dynamic>> venues = [];

  // @override
  // void onInit() {
  //   super.onInit();
  //   venues = List.from(venues);
  // }


  void searchVenue(String query) {
    if (query.isEmpty) {
      venues = List.from(venues);
    } else {
      venues = venues
          .where((venue) =>
      venue['name'].toLowerCase().contains(query.toLowerCase()) ||
          venue['address'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void onDaySelected(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    update();
  }

}

