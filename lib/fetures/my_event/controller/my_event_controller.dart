import 'package:get/get.dart';

class MyEventController extends GetxController {
  List<String> events = ["Music Event Ticket", "Music Event Ticket", "Music Event Ticket"];
  void deleteEvent(int index) {
    events.removeAt(index);
    update();
  }
}