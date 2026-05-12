import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletController extends GetxController {
  final TextEditingController eventNameController = TextEditingController();
  File? pickedImage;
  DateTime selectedDate = DateTime(2026, 5, 18);
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

  Future<void> uploadTicket() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      pickedImage = File(result.files.single.path!);
      update();
    }
  }



}