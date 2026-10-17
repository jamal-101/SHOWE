import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../home/model/venue_model.dart' as VenueModel;

class TripPlanController extends GetxController {
  final ScrollController scrollController = ScrollController();

  List<VenueModel.Data> allVenuesFromApi = [];
  List<VenueModel.Data> venues = [];

  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  int currentPage = 1;
  bool hasMoreData = true;
  final int limit = 10;

  String searchQuery = "";
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void onInit() {
    super.onInit();
    fetchVenuesFromApi();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isMoreLoading.value &&
          !isLoading.value &&
          hasMoreData) {
        loadMoreVenues();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchVenuesFromApi() async {
    try {
      currentPage = 1;
      hasMoreData = true;
      isLoading.value = true;
      update();

      String url = "${ApiEndPoint.getVenues}?page=$currentPage&limit=$limit";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        VenueModel.Venue_model incomingVenueModel =
        VenueModel.Venue_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        if (incomingVenueModel.success == true &&
            incomingVenueModel.data != null) {
          allVenuesFromApi = incomingVenueModel.data!;
          if (incomingVenueModel.data!.length < limit) {
            hasMoreData = false;
          }

          _applyFilters();
        }
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error fetching venues in TripPlanController: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreVenues() async {
    try {
      isMoreLoading.value = true;
      currentPage++;
      update();

      String url = "${ApiEndPoint.getVenues}?page=$currentPage&limit=$limit";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        VenueModel.Venue_model incomingVenueModel =
        VenueModel.Venue_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        if (incomingVenueModel.success == true &&
            incomingVenueModel.data != null &&
            incomingVenueModel.data!.isNotEmpty) {
          allVenuesFromApi.addAll(incomingVenueModel.data!);
          if (incomingVenueModel.data!.length < limit) {
            hasMoreData = false;
          }

          _applyFilters();
        } else {
          hasMoreData = false;
        }
      }
    } catch (e) {
      debugPrint("Error loading more venues: $e");
      currentPage--;
    } finally {
      isMoreLoading.value = false;
      update();
    }
  }

  void _applyFilters() {
    List<VenueModel.Data> tempResult = List.from(allVenuesFromApi);

    if (searchQuery.isNotEmpty) {
      tempResult = tempResult.where((venue) {
        final name = venue.name?.toLowerCase() ?? "";
        final city = venue.city?.toLowerCase() ?? "";
        final country = venue.country?.toLowerCase() ?? "";
        return name.contains(searchQuery.toLowerCase()) ||
            city.contains(searchQuery.toLowerCase()) ||
            country.contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedDay != null) {
      tempResult = tempResult.where((venue) {
        if (venue.createdAt == null || venue.createdAt!.isEmpty) return false;
        try {
          DateTime venueDate = DateTime.parse(venue.createdAt!);
          return venueDate.year == selectedDay!.year &&
              venueDate.month == selectedDay!.month &&
              venueDate.day == selectedDay!.day;
        } catch (e) {
          return false;
        }
      }).toList();
    }

    venues = tempResult;
    update();
  }

  void searchVenue(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void onDaySelected(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    _applyFilters();
  }
}