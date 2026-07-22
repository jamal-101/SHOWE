// import 'package:get/get.dart';
//
// class TripPlanController extends GetxController {
//   final List<Map<String, dynamic>> allVenues = [
//     {
//       "name": "Gala Convention Center",
//       "address": "123 Golf Street, UK",
//       "date": "12 April, 2026",
//     },
//     {
//       "name": "Royal Palace",
//       "address": "456 Side Road, USA",
//       "date": "15 April, 2026",
//     },
//     {
//       "name": "Convention Hall",
//       "address": "789 North Street, UK",
//       "date": "18 April, 2026",
//     },
//     {
//       "name": "Grand Arena",
//       "address": "101 South Street, UK",
//       "date": "20 April, 2026",
//     },
//   ];
//
//   List<Map<String, dynamic>> venues = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//     venues = List.from(allVenues);
//   }
//
//
//   void searchVenue(String query) {
//     if (query.isEmpty) {
//       venues = List.from(allVenues);
//     } else {
//       venues = allVenues
//           .where((venue) =>
//       venue['name'].toLowerCase().contains(query.toLowerCase()) ||
//           venue['address'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     update();
//   }
//
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDay;
//
//   void onDaySelected(DateTime selectDay, DateTime focusDay) {
//     selectedDay = selectDay;
//     focusedDay = focusDay;
//     update();
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../home/model/venue_model.dart' as VenueModel;

class TripPlanController extends GetxController {
  List<VenueModel.Data> allVenuesFromApi = [];
  List<VenueModel.Data> venues = [];

  var isLoading = false.obs;
  String searchQuery = "";

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void onInit() {
    super.onInit();
    fetchVenuesFromApi();
  }

  Future<void> fetchVenuesFromApi() async {
    try {
      isLoading.value = true;
      update();
      String url = "${ApiEndPoint.getVenues}?page=1&limit=20";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        VenueModel.Venue_model incomingVenueModel = VenueModel.Venue_model.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        if (incomingVenueModel.success == true && incomingVenueModel.data != null) {
          allVenuesFromApi = incomingVenueModel.data!;
          _applyFilters();
        }
      } else {
        Get.snackbar("Error", response.message, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error fetching venues in TripPlanController: $e");
    } finally {
      isLoading.value = false;
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