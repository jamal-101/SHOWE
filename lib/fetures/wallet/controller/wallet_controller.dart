// import 'dart:io';
// import 'package:dio/dio.dart' as dio;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
//
// class WalletController extends GetxController {
//   final TextEditingController eventNameController = TextEditingController();
//
//   File? pickedImage;
//   DateTime selectedDate = DateTime(2026, 5, 18);
//   var isLoading = false.obs;
//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null && picked != selectedDate) {
//       selectedDate = picked;
//       update();
//     }
//   }
//   String get formattedDate => DateFormat('dd MMMM, yyyy').format(selectedDate);
//   String get apiDateString => DateFormat('yyyy-MM-dd').format(selectedDate);
//   Future<void> uploadTicket() async {
//     FilePickerResult? result = await FilePicker.pickFiles(type: FileType.image);
//
//     if (result != null && result.files.single.path != null) {
//       pickedImage = File(result.files.single.path!);
//       update();
//     }
//   }
//   Future<void> createTicket() async {
//     if (eventNameController.text.trim().isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please enter event name",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//     if (pickedImage == null) {
//       Get.snackbar(
//         "Error",
//         "Please upload a ticket file",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//     try {
//       isLoading.value = true;
//       update();
//       String fileName = pickedImage!.path.split('/').last;
//       final formData = dio.FormData.fromMap({
//         "name": eventNameController.text.trim(),
//         "date": apiDateString,
//         "file": await dio.MultipartFile.fromFile(
//           pickedImage!.path,
//           filename: fileName,
//         ),
//       });
//
//       String url = "/ticket";
//       ApiResponseModel response = await ApiService.post(url, body: formData);
//
//       if (response.isSuccess) {
//         Get.snackbar(
//           "Success",
//           "Ticket uploaded successfully",
//           backgroundColor: Color(0xFFF2A900),
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP
//         );
//         _clearFields();
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error uploading ticket: $e");
//       Get.snackbar(
//         "Error",
//         "Something went wrong",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }
//
//   Future<void> updateTicket(String ticketId) async {
//     if (eventNameController.text.trim().isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please enter event name",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//       update();
//
//       Map<String, dynamic> bodyData = {
//         "name": eventNameController.text.trim(),
//         "date": apiDateString,
//       };
//
//       if (pickedImage != null) {
//         String fileName = pickedImage!.path.split('/').last;
//         bodyData["file"] = await dio.MultipartFile.fromFile(
//           pickedImage!.path,
//           filename: fileName,
//         );
//       }
//
//       final formData = dio.FormData.fromMap(bodyData);
//       String url = "/ticket/$ticketId";
//
//       ApiResponseModel response = await ApiService.patch(url, body: formData);
//
//       if (response.isSuccess) {
//         Get.snackbar(
//           "Success",
//           "Ticket updated successfully",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         Get.back();
//       } else {
//         Get.snackbar(
//           "Error",
//           response.message,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error updating ticket: $e");
//       Get.snackbar(
//         "Error",
//         "Something went wrong",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//       update();
//     }
//   }
//
//   void _clearFields() {
//     eventNameController.clear();
//     pickedImage = null;
//     selectedDate = DateTime(2026, 5, 18);
//     update();
//   }
// }

import 'dart:io';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';

class WalletController extends GetxController {
  final TextEditingController eventNameController = TextEditingController();

  File? pickedImage;
  DateTime selectedDate = DateTime(2026, 5, 18);
  var isLoading = false.obs;
  bool isEditMode = false;
  String? editTicketId;
  String? existingFileUrl;

  @override
  void onInit() {
    super.onInit();
    _checkArgumentsAndFillData();
  }
  void _checkArgumentsAndFillData() {
    if (Get.arguments != null && Get.arguments['isEdit'] == true) {
      isEditMode = true;
      editTicketId = Get.arguments['ticketId'];
      eventNameController.text = Get.arguments['name'] ?? '';
      existingFileUrl = Get.arguments['file'];

      if (Get.arguments['date'] != null) {
        try {
          selectedDate = DateTime.parse(Get.arguments['date']);
        } catch (e) {
          selectedDate = DateTime(2026, 5, 18);
        }
      }
      update();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  String get formattedDate => DateFormat('dd MMMM, yyyy').format(selectedDate);
  String get apiDateString => DateFormat('yyyy-MM-dd').format(selectedDate);

  Future<void> uploadTicket() async {
    FilePickerResult? result = await FilePicker.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      pickedImage = File(result.files.single.path!);
      update();
    }
  }
  Future<void> createTicket() async {
    if (eventNameController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter event name",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (pickedImage == null) {
      Get.snackbar(
        "Error",
        "Please upload a ticket file",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();

      String fileName = pickedImage!.path.split('/').last;
      final formData = dio.FormData.fromMap({
        "name": eventNameController.text.trim(),
        "date": apiDateString,
        "file": await dio.MultipartFile.fromFile(
          pickedImage!.path,
          filename: fileName,
        ),
      });

      String url = "/ticket";
      ApiResponseModel response = await ApiService.post(url, body: formData);

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Ticket uploaded successfully",
          backgroundColor: const Color(0xFFF2A900),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        _clearFields();
        Get.back();
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error uploading ticket: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
  Future<void> updateTicket() async {
    if (eventNameController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter event name",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> bodyData = {
        "name": eventNameController.text.trim(),
        "date": apiDateString,
      };

      if (pickedImage != null) {
        String fileName = pickedImage!.path.split('/').last;
        bodyData["file"] = await dio.MultipartFile.fromFile(
          pickedImage!.path,
          filename: fileName,
        );
      }

      final formData = dio.FormData.fromMap(bodyData);
      String url = "/ticket/$editTicketId";
      ApiResponseModel response = await ApiService.patch(url, body: formData);
      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Ticket updated successfully",
          backgroundColor: const Color(0xFFF2A900),
          colorText: Colors.white,
        );
        _clearFields();
        Get.toNamed(AppRoutes.myEventScreen);
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error updating ticket: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _clearFields() {
    eventNameController.clear();
    pickedImage = null;
    selectedDate = DateTime(2026, 5, 18);
    isEditMode = false;
    editTicketId = null;
    existingFileUrl = null;
    update();
  }
}
