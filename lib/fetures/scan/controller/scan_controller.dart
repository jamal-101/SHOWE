import 'dart:io';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import '../../../core/constans/app_images.dart';

class ScanController extends GetxController{
  File? capturedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageAndNavigate() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      capturedImage = File(photo.path);
      update();
      Get.toNamed(AppRoutes.libraryScreen);
    }
  }

  bool isPurchased = false;
  void setPurchaseStatus(bool status) {
    isPurchased = status;
    update();
  }

  final pageFlipKey = GlobalKey<PageFlipBuilderState>();
  final List<String> bookImages = [
    AppImages.singleImage,
    AppImages.myProgramImag,
    AppImages.singleImage,
    AppImages.myProgramImag,
  ];
}