import 'package:get/get.dart';

class TripPlanController extends GetxController {
  final List<Map<String, dynamic>> allVenues = [
    {
      "name": "Gala Convention Center",
      "address": "123 Golf Street, UK",
      "date": "12 April, 2026",
    },
    {
      "name": "Royal Palace",
      "address": "456 Side Road, USA",
      "date": "15 April, 2026",
    },
    {
      "name": "Convention Hall",
      "address": "789 North Street, UK",
      "date": "18 April, 2026",
    },
    {
      "name": "Grand Arena",
      "address": "101 South Street, UK",
      "date": "20 April, 2026",
    },
  ];

  List<Map<String, dynamic>> venues = [];

  @override
  void onInit() {
    super.onInit();
    venues = List.from(allVenues);
  }


  void searchVenue(String query) {
    if (query.isEmpty) {
      venues = List.from(allVenues);
    } else {
      venues = allVenues
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