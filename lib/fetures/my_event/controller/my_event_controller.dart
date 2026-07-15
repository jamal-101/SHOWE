// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
// import '../model/tickets_model.dart';
//
// class MyEventController extends GetxController {
//   final ScrollController scrollController = ScrollController();
//   RxList<Data> ticketList = <Data>[].obs;
//   var totalTickets = 0.obs;
//
//   var isLoading = false.obs;
//   var isLoadMore = false.obs;
//
//   int currentPage = 1;
//   int totalPage = 1;
//   final int limit = 5;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTickets();
//     _addScrollListener();
//   }
//
//   void _addScrollListener() {
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >=
//               scrollController.position.maxScrollExtent &&
//           !isLoading.value &&
//           !isLoadMore.value &&
//           currentPage < totalPage) {
//         currentPage++;
//         fetchTickets(isLoadMoreCall: true);
//       }
//     });
//   }
//
//   Future<void> fetchTickets({bool isLoadMoreCall = false}) async {
//     try {
//       if (isLoadMoreCall) {
//         isLoadMore.value = true;
//       } else {
//         isLoading.value = true;
//         currentPage = 1;
//         ticketList.value = [];
//       }
//       update();
//       String url = "/ticket?page=$currentPage&limit=$limit";
//       ApiResponseModel response = await ApiService.get(url);
//
//       if (response.isSuccess) {
//         Tickets_Model ticketsModel = Tickets_Model.fromJson(
//           Map<String, dynamic>.from(response.data),
//         );
//         if (ticketsModel.success == true && ticketsModel.data != null) {
//           totalPage = ticketsModel.pagination?.totalPage ?? 1;
//           final newItems = ticketsModel.data!
//               .where((element) => element != null)
//               .toList();
//           ticketList.addAll(newItems);
//           totalTickets.value = ticketsModel.pagination?.total ?? ticketsModel.data!.length;
//         }
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error fetching tickets: $e");
//     } finally {
//       isLoading.value = false;
//       isLoadMore.value = false;
//       update();
//     }
//   }
//
//   Future<void> deleteEvent(int index) async {
//     if (index < 0 || index >= ticketList.length) return;
//     final ticketId = ticketList[index].sId;
//     if (ticketId == null || ticketId.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Invalid ticket ID",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//     try {
//       String url = "/ticket/$ticketId";
//       ApiResponseModel response = await ApiService.delete(url);
//       if (response.isSuccess) {
//         ticketList.removeAt(index);
//         if (Get.isDialogOpen ?? false) Get.back();
//         Get.snackbar(
//           "Success",
//           "Ticket deleted successfully",
//           backgroundColor: Color(0xFFF2A900),
//           colorText: Colors.white,
//         );
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error deleting ticket: $e");
//       Get.snackbar(
//         "Error",
//         "Something went wrong while deleting",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   @override
//   void onClose() {
//     scrollController.dispose();
//     super.onClose();
//   }
// }

import 'package:digital_event/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/tickets_model.dart';

class MyEventController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxList<Data> ticketList = <Data>[].obs;

  // 💡 গ্লোবাল কাউন্ট ভেরিয়েবল
  var totalTickets = 0.obs;

  var isLoading = false.obs;
  var isLoadMore = false.obs;

  int currentPage = 1;
  int totalPage = 1;
  final int limit = 5;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
    _addScrollListener();
  }

  void _addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent &&
          !isLoading.value &&
          !isLoadMore.value &&
          currentPage < totalPage) {
        currentPage++;
        fetchTickets(isLoadMoreCall: true);
      }
    });
  }

  Future<void> fetchTickets({bool isLoadMoreCall = false}) async {
    try {
      if (isLoadMoreCall) {
        isLoadMore.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        ticketList.value = [];
      }
      update();
      String url = "/ticket?page=$currentPage&limit=$limit";
      ApiResponseModel response = await ApiService.get(url);

      if (response.isSuccess) {
        Tickets_Model ticketsModel = Tickets_Model.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        if (ticketsModel.success == true && ticketsModel.data != null) {
          totalPage = ticketsModel.pagination?.totalPage ?? 1;

          final newItems = ticketsModel.data!
              .where((element) => element != null)
              .toList();
          ticketList.addAll(newItems);

          // 💡 ১. ফিক্সড: মডেল অবজেক্ট থেকে টোটাল টিকিট কাউন্ট সেট করা হচ্ছে
          // তোমার Tickets_Model-এর pagination ক্লাসে যদি total বা totalTickets ফিল্ড থাকে সেটি এখানে দাও
          totalTickets.value = ticketsModel.pagination?.total ?? ticketsModel.data!.length;
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
      debugPrint("Error fetching tickets: $e");
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
    }
  }

  Future<void> deleteEvent(int index) async {
    if (index < 0 || index >= ticketList.length) return;
    final ticketId = ticketList[index].sId;
    if (ticketId == null || ticketId.isEmpty) {
      Get.snackbar(
        "Error",
        "Invalid ticket ID",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      String url = "/ticket/$ticketId";
      ApiResponseModel response = await ApiService.delete(url);
      if (response.isSuccess) {
        ticketList.removeAt(index);

        // 💡 ২. ফিক্সড: টিকিট সফলভাবে ডিলিট হলে টোটাল কাউন্ট ১ কমিয়ে দেওয়া হচ্ছে
        if (totalTickets.value > 0) {
          totalTickets.value--;
        }

        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar(
          "Success",
          "Ticket deleted successfully",
          backgroundColor: Color(0xFFF2A900),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error deleting ticket: $e");
      Get.snackbar(
        "Error",
        "Something went wrong while deleting",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}