import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../favorites/controller/favorite_controller.dart';
import '../model/event_details_model.dart';
import 'package:intl/intl.dart';
import '../model/event_model.dart' hide Data;
import '../model/venue_details_model.dart' hide Data;
import '../model/venue_model.dart' as VenueModel;
import '../model/artist_model.dart' hide Data;
import '../model/event_model.dart' as EventModel;
import '../model/venue_details_model.dart' as VenueDetails;
import '../../favorites/model/favourite_event_model.dart' as ev;
import '../../favorites/model/favourite_venue_model.dart' as vn;
import 'dart:async';
import '../screen/payment_web_view.dart';
import '../model/artist_model.dart' as artist;
import '../../favorites/model/artist_favourite_model.dart' as af;
import '../model/event_model.dart' hide Data;
import '../model/event_model.dart' as EventModel;





class HomController extends GetxController {
  var selectedTabIndex = 0.obs;
  var isEventLoading = false.obs;
  var isLoadMore = false.obs;
  var isVenueLoadMore = false.obs;
  int currentPage = 1;
  int currentVenuePage = 1;
  Event_model eventModel = Event_model(data: []);
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  DateTime? selectedVenueDate;
  List<VenueModel.Data> venueList = [];
  var isVenueLoading = false.obs;
  VenueModel.Pagination? venuePagination;
  var isDetailsLoading = false.obs;
  Event_details_model? eventDetailsModel;
  var isArtistLoading = false.obs;
  var isArtistLoadMore = false.obs;
  int currentArtistPage = 1;
  Artist_model artistModel = Artist_model(data: []);

  @override
  void onInit() {
    super.onInit();
    fetchEvents(isRefresh: true);
    initDeepLinks();





    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        // Tab 0: Events
        if (selectedTabIndex.value == 0 && !isLoadMore.value && !isEventLoading.value) {
          if (eventModel.pagination != null && currentPage <= (eventModel.pagination!.totalPage ?? 1)) {
            fetchEvents(isRefresh: false);
          }
        }
        // Tab 1: Artists
        else if (selectedTabIndex.value == 1 && !isArtistLoadMore.value && !isArtistLoading.value) {
          if (artistModel.pagination != null && currentArtistPage <= (artistModel.pagination!.totalPage ?? 1)) {
            fetchArtists(isRefresh: false);
          }
        }
        // Tab 2: Venues
        else if (selectedTabIndex.value == 2 && !isVenueLoadMore.value && !isVenueLoading.value) {
          if (venuePagination != null && currentVenuePage <= (venuePagination!.totalPage ?? 1)) {
            fetchVenues(isRefresh: false);
          }
        }
      }
    });

  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }


  void changeTab(int index) {
    selectedTabIndex.value = index;
    update();

    if (index == 0 && eventModel.data!.isEmpty) fetchEvents();
    if (index == 1 && artistModel.data!.isEmpty) fetchArtists();
    if (index == 2 && venueList.isEmpty) fetchVenues();
  }

  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (selectedTabIndex.value == 0) {
        fetchEvents(isRefresh: true);
      } else if (selectedTabIndex.value == 1) {
        fetchArtists(isRefresh: true) ;

      } else if (selectedTabIndex.value == 2) {
        fetchVenues(isRefresh: true);
      }
    });
  }

  Future<void> refreshCurrentTab() async {
    if (selectedTabIndex.value == 0) {
      await fetchEvents(isRefresh: true);
    } else if (selectedTabIndex.value == 1) {
      await fetchArtists(isRefresh: true);
    }
    else if (selectedTabIndex.value == 2) {
      await fetchVenues(isRefresh: true);
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
      String searchText = searchController.text.trim();
      String url = "/event/search?page=$currentPage&limit=10";
      if (searchText.isNotEmpty) {
        url += "&searchTerm=$searchText";
      }
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
      String searchText = searchController.text.trim();
      String url = "${ApiEndPoint.getVenues}?page=$currentVenuePage&limit=10";
      if (searchText.isNotEmpty) {
        url += "&searchTerm=$searchText";
      }
      if (selectedVenueDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedVenueDate!);
        url += "&date=$formattedDate";
      }
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

  Future<void> fetchArtists({bool isRefresh = true}) async {
    if (isRefresh) {
      currentArtistPage = 1;
      isArtistLoading.value = true;
      artistModel.data = [];
    } else {
      isArtistLoadMore.value = true;
    }
    update();

    try {
      String url = "/artist?page=$currentArtistPage&limit=10";

      if (searchController.text.isNotEmpty) {
        url += "&searchTerm=${searchController.text.trim()}";
      }

      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        Artist_model incomingModel = Artist_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        if (incomingModel.success == true && incomingModel.data != null) {
          artistModel.success = incomingModel.success;
          artistModel.pagination = incomingModel.pagination;
          artistModel.data ??= [];
          artistModel.data!.addAll(incomingModel.data!);
          currentArtistPage++;
        }
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching artists: $e");
    } finally {
      isArtistLoading.value = false;
      isArtistLoadMore.value = false;
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

      String url = "/vanue/$venueId";
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



  Future<void> toggleFavorite(dynamic item) async {
    String? itemId;
    String? itemType;

    if (item is EventModel.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Event';
    } else if (item is VenueModel.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Venue';
    } else if (item is VenueDetails.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Venue';
    } else if (item is Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Event';
    } else if (item is artist.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Artist';
    } else if (item is af.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Artist';
    }
    else if (item is ev.Data) {
      item.isFavorited = !(item.isFavorited ?? false);
      itemId = item.sId;
      itemType = 'Event';
    }

    if (itemId == null || itemId.isEmpty || itemType == null) {
      debugPrint("Error: Item ID or Type not found for ${item.runtimeType}");
      return;
    }

    update();

    try {
      String url = "/event/interest/$itemId";
      Map<String, dynamic> body = {"type": itemType};

      ApiResponseModel response = await ApiService.post(url, body: body);
      if (response.isSuccess) {
        debugPrint("Successfully toggled favorite for $itemType: $itemId");
        if (Get.isRegistered<FavoriteController>()) {
          final favController = Get.find<FavoriteController>();
          favController.favoriteList.removeWhere((element) {
            if (element is af.Data) return element.sId == itemId;
            if (element is ev.Data) return element.sId == itemId;
            if (element is vn.Data) return element.sId == itemId;
            return false;
          });
          favController.update();
        }
      } else {
        _rollbackFavoriteState(item);
        update();
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      _rollbackFavoriteState(item);
      update();
      debugPrint("Favorite Error: $e");
    }
  }

  void _rollbackFavoriteState(dynamic item) {
    if (item is EventModel.Data) item.isFavorited = !(item.isFavorited ?? false);
    if (item is VenueModel.Data) item.isFavorited = !(item.isFavorited ?? false);
    if (item is VenueDetails.Data) item.isFavorited = !(item.isFavorited ?? false);
    if (item is artist.Data) item.isFavorited = !(item.isFavorited ?? false);
    if (item is af.Data) item.isFavorited = !(item.isFavorited ?? false);
    // if (item is ev.Data) item.isFavorited = !(item.isFavorited ?? false);
    // if (item is vn.Data) item.isFavorited = !(item.isFavorited ?? false);
  }

  final List<Map<String, dynamic>> eventData = [];

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

  var isPurchaseLoading = false.obs;
  var ticketIsPurchaseLoading = false.obs;

  Future<void> openTicketUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      Get.snackbar("Error", "Ticket URL is not available for this event",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      ticketIsPurchaseLoading.value = true;
      update();
      final Uri uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint("Error opening ticket URL: $e");
      Get.snackbar("Error", "Could not open ticket link",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      ticketIsPurchaseLoading.value = false;
      update();
    }
  }


  var isSingleArtistLoading = false.obs;
  var singleArtistData = {}.obs;

  Future<void> fetchSingleArtist(String artistId) async {
    try {
      isSingleArtistLoading.value = true;

      ApiResponseModel response = await ApiService.get("/artist/$artistId");

      if (response.isSuccess) {
        if (response.data['data'] != null) {
          singleArtistData.value = response.data['data'];
        }
      }
      else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching single artist: $e");
    } finally {
      isSingleArtistLoading.value = false;
    }
  }

  final AppLinks _appLinks = AppLinks();
  void initDeepLinks() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        debugPrint(">>>> Stream Deep Link Received: $uri");
        handlePaymentNavigation(uri);
      }
    }, onError: (err) {
      debugPrint(">>>> Deep Link Stream Error: $err");
    });
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        debugPrint(">>>> Initial Deep Link Received: $uri");
        handlePaymentNavigation(uri);
      }
    });
  }

  void handlePaymentNavigation(Uri uri) {
    String urlString = uri.toString();
    if (urlString.contains("payment/success")) {
      debugPrint(">>>> Payment Success Detected! Redirecting to My Program...");
      Future.delayed(const Duration(milliseconds: 200), () {
        Get.toNamed(AppRoutes.myProgramScreen);
      });
    }
  }

  Future<void> purchaseTicket(String eventId, dynamic price) async {
    debugPrint(">>>> purchaseTicket called with eventId: $eventId, price: $price");
    try {
      isPurchaseLoading.value = true;
      update();

      num numericPrice = 0;
      if (price is num) {
        numericPrice = price;
      } else if (price is String) {
        numericPrice = num.tryParse(price) ?? 0;
      }

      String url = "/event/purchase/$eventId";
      ApiResponseModel response = await ApiService.post(url, body: {});
      debugPrint(">>>> purchaseTicket response: ${response.statusCode}, data: ${response.data}");
      if (response.isSuccess) {
        final responseData = response.data['data'];
        bool isFreeOrDirectPurchase = numericPrice <= 0 || responseData is Map || (responseData is String && !responseData.startsWith('http'));

        if (isFreeOrDirectPurchase) {
          if (eventDetailsModel?.data != null) {
            eventDetailsModel!.data!.isAlreadyProgrammePurchased = true;
          }
          update();
          Get.snackbar(
            "Success",
            response.data['message']?.toString() ?? "Programme successfully purchased!",
            backgroundColor: const Color(0xFF009661),
            colorText: Colors.white,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            fetchEvents(isRefresh: true);
            if (Get.context != null) {
              Navigator.pop(Get.context!);
            } else {
              Get.back();
            }
          });
        } else {
          String paymentUrl = responseData?.toString() ?? "";
          if (paymentUrl.isNotEmpty && paymentUrl.startsWith('http')) {

            Get.to(() => PaymentWebViewScreen(paymentUrl: paymentUrl));

          } else {
            if (eventDetailsModel?.data != null) {
              eventDetailsModel!.data!.isAlreadyProgrammePurchased = true;
            }
            update();
            Get.snackbar(
              "Success",
              response.data['message']?.toString() ?? "Programme successfully purchased!",
              backgroundColor: const Color(0xFF009661),
              colorText: Colors.white,
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              fetchEvents(isRefresh: true);
              if (Get.context != null) {
                Navigator.pop(Get.context!);
              } else {
                Get.back();
              }
            });
          }
        }
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error purchasing ticket: $e");
    } finally {
      isPurchaseLoading.value = false;
      update();
    }
  }

  Future<void> openWebsite(String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      Get.snackbar("Error", "No website link available", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Could not launch website", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("URL Launch Error: $e");
    }
  }

  var artistEventsList = <dynamic>[].obs;
  var isEventsLoading = false.obs;
  var isMoreEventsLoading = false.obs;
  int currentEventPage = 1;
  int totalEventPages = 1;

  Future<void> fetchArtistEvents(String artistId, {bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (currentEventPage >= totalEventPages || isMoreEventsLoading.value) return;
      isMoreEventsLoading.value = true;
      currentEventPage++;
    } else {
      isEventsLoading.value = true;
      currentEventPage = 1;
      artistEventsList.clear();
    }

    try {
      ApiResponseModel response = await ApiService.get(
        "/artist/events/$artistId?page=$currentEventPage&limit=10",
      );

      if (response.isSuccess) {
        var data = response.data;
        if (data['pagination'] != null) {
          totalEventPages = data['pagination']['totalPage'] ?? 1;
        }

        List rawList = data['data'] ?? [];
        List<EventModel.Data> parsedEvents = rawList
            .map((e) => EventModel.Data.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        if (isLoadMore) {
          artistEventsList.addAll(parsedEvents);
        } else {
          artistEventsList.value = parsedEvents;
        }
      }
    } catch (e) {
      debugPrint("Error fetching artist events: $e");
    } finally {
      isEventsLoading.value = false;
      isMoreEventsLoading.value = false;
      update();
    }
  }

  List<Map<String, dynamic>> venues = [];

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

  void resetFilters() {
    searchController.clear();
    selectedVenueDate = null;
    if (selectedTabIndex.value == 0) fetchEvents();
    if (selectedTabIndex.value == 2) fetchVenues();
  }
}
