// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/storage/local_storage.dart';
// import '../../../core/storage/storage_key.dart';
// import '../../../core/utils/api_enpoint.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
// import '../../home/screen/home_screen.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:image/image.dart' as img;
//
// enum Gender { male, female, other }
//
// class ProfileInformationController extends GetxController {
//   RxString selectedGender = "Select".obs;
//
//   void updateSelectedGender(Gender genderItem) {
//     switch (genderItem) {
//       case Gender.male:
//         selectedGender.value = "male";
//         break;
//       case Gender.female:
//         selectedGender.value = "female";
//         break;
//       case Gender.other:
//         selectedGender.value = "Prefer not to say";
//         break;
//     }
//   }
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Live Camera Setup <<<<<<<<<<<<<<<<<<<<<<///
//   CameraController? cameraController;
//   List<CameraDescription>? cameras;
//   bool isCameraInitialized = false;
//   bool isScanningLogin = false;
//   bool isScanning = false;
//   File? capturedImage;
//
//   Future<void> initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       if (cameras != null && cameras!.isNotEmpty) {
//         final frontCamera = cameras!.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras!.first,
//         );
//
//         cameraController = CameraController(
//           frontCamera,
//           ResolutionPreset.ultraHigh,
//           enableAudio: false,
//           imageFormatGroup: ImageFormatGroup.jpeg,
//         );
//
//         await cameraController!.initialize();
//         try {
//           await cameraController!.setFocusMode(FocusMode.auto);
//           await cameraController!.setExposureMode(ExposureMode.auto);
//         } catch (_) {}
//
//         isCameraInitialized = true;
//         update();
//       }
//     } catch (e) {
//       debugPrint("Camera Initialization Error: $e");
//     }
//   }
//
//   @override
//   void onClose() {
//     cameraController?.dispose();
//     super.onClose();
//   }
//
//   Future<File> _fixImageRotation(String imagePath) async {
//     final imageBytes = await File(imagePath).readAsBytes();
//     img.Image? originalImage = img.decodeImage(imageBytes);
//
//     if (originalImage != null) {
//       img.Image fixedImage = img.bakeOrientation(originalImage);
//       final fixedFile = File(imagePath)
//         ..writeAsBytesSync(img.encodeJpg(fixedImage, quality: 90));
//       return fixedFile;
//     }
//     return File(imagePath);
//   }
//
//   Future<XFile?> _captureClearAndStraightPhoto() async {
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       return null;
//     }
//     try {
//       await cameraController!.setFocusMode(FocusMode.locked);
//     } catch (_) {}
//
//     final XFile image = await cameraController!.takePicture();
//     return image;
//   }
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Registration <<<<<<<<<<<<<<<<<<<<<<///
//   Future<void> startScanning() async {
//     isScanning = true;
//     update();
//     await initializeCamera();
//
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       isScanning = false;
//       update();
//       Get.snackbar(
//         "Error",
//         "Camera could not be started!",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//
//     try {
//       await Future.delayed(const Duration(milliseconds: 300));
//       final XFile? image = await _captureClearAndStraightPhoto();
//
//       if (image == null) throw Exception("Failed to capture image");
//       capturedImage = File(image.path);
//
//       dio.FormData formData = dio.FormData.fromMap({
//         "device_id": LocalStorage.deviceId,
//         "image": await dio.MultipartFile.fromFile(
//           capturedImage!.path,
//           filename: capturedImage!.path.split('/').last,
//         ),
//       });
//
//       String token = LocalStorage.token;
//       String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
//
//       Map<String, String> headers = {"Authorization": authHeader};
//
//       ApiResponseModel response = await ApiService.post(
//         ApiEndPoint.saveFaceVerification,
//         body: formData,
//         header: headers,
//       );
//
//       if (response.isSuccess) {
//         showSuccessDialog();
//       } else {
//         _resetCameraState();
//         Get.snackbar(
//           "Failed",
//           response.message,
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       _resetCameraState();
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.white.withValues(alpha: 0.9),
//       );
//     }
//   }
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Login <<<<<<<<<<<<<<<<<<<<<<///
//   Future<void> startFaceLogin() async {
//     isScanningLogin = true;
//     update();
//
//     await initializeCamera();
//
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       isScanningLogin = false;
//       update();
//       Get.snackbar(
//         "Error",
//         "Camera could not be started!",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//
//     try {
//       await Future.delayed(const Duration(milliseconds: 10));
//       final XFile? image = await _captureClearAndStraightPhoto();
//
//       if (image == null) throw Exception("Failed to capture image");
//       // capturedImage = File(image.path);
//       //
//       // dio.FormData formData = dio.FormData.fromMap({
//       //   "device_id": LocalStorage.deviceId,
//       //   "image": await dio.MultipartFile.fromFile(
//       //     capturedImage!.path,
//       //     filename: capturedImage!.path.split('/').last,
//       //   ),
//       // });
//
//       capturedImage = await _fixImageRotation(image.path);
//
//       dio.FormData formData = dio.FormData.fromMap({
//         "device_id": LocalStorage.deviceId,
//         "image": await dio.MultipartFile.fromFile(
//           capturedImage!.path,
//           filename: "face_login.jpg",
//         ),
//       });
//
//       String token = LocalStorage.token;
//       String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
//       Map<String, String> headers = {"Authorization": authHeader};
//
//       ApiResponseModel response = await ApiService.post(
//         "/auth/face-login",
//         body: formData,
//         header: headers,
//       );
//
//       if (response.isSuccess) {
//         if (response.data['data'] != null &&
//             response.data['data']['accessToken'] != null) {
//           String newAccessToken = response.data['data']['accessToken'];
//           await LocalStorage.setString(LocalStorageKeys.token, newAccessToken);
//           await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
//           await LocalStorage.getAllPrefData();
//         }
//         showSuccessDialog();
//       } else {
//         _resetCameraState();
//         Get.snackbar(
//           "Failed",
//           response.message,
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       _resetCameraState();
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }
//
//   void _resetCameraState() {
//     isScanning = false;
//     isScanningLogin = false;
//     isCameraInitialized = false;
//     cameraController?.dispose();
//     update();
//   }
//
//   void showSuccessDialog() {
//     Get.dialog(
//       barrierDismissible: false,
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20.w),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFF7BD56),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset(
//                   AppImages.faceSuccess,
//                   height: 100.h,
//                   width: 100.w,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 "Congratulations",
//                 style: GoogleFonts.montserrat(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFF0F4C5C),
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Text(
//                 "Your account is ready to use, redirecting to homepage",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16.sp, color: Colors.grey[900]),
//               ),
//               SizedBox(height: 20.h),
//               const CircularProgressIndicator(color: Color(0xFFF7BD56)),
//             ],
//           ),
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () {
//       _resetCameraState();
//       Get.offAll(() => const HomeScreen());
//     });
//   }
// }


import 'dart:io';
import 'package:camera/camera.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../home/screen/home_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image/image.dart' as img;

enum Gender { male, female, other }

class ProfileInformationController extends GetxController {
  RxString selectedGender = "Select".obs;

  void updateSelectedGender(Gender genderItem) {
    switch (genderItem) {
      case Gender.male:
        selectedGender.value = "male";
        break;
      case Gender.female:
        selectedGender.value = "female";
        break;
      case Gender.other:
        selectedGender.value = "Prefer not to say";
        break;
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Live Camera Setup & Smooth Border Progress <<<<<<<<<<<<<<<<<<<<<<///
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isScanningLogin = false;
  bool isScanning = false;
  File? capturedImage;

  RxDouble borderProgress = 0.0.obs; // বর্ডার অ্যানিমেশনের প্রোগ্রেস ট্র্যাক করার জন্য

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        final frontCamera = cameras!.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras!.first,
        );

        cameraController = CameraController(
          frontCamera,
          ResolutionPreset.ultraHigh,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );

        await cameraController!.initialize();
        try {
          await cameraController!.setFocusMode(FocusMode.auto);
          await cameraController!.setExposureMode(ExposureMode.auto);
        } catch (_) {}

        isCameraInitialized = true;
        update();
      }
    } catch (e) {
      debugPrint("Camera Initialization Error: $e");
    }
  }

  @override
  void onClose() {
    _disposeCamera();
    super.onClose();
  }

  Future<void> _disposeCamera() async {
    if (cameraController != null) {
      await cameraController!.dispose();
      cameraController = null;
      isCameraInitialized = false;
    }
  }

  Future<File> _fixImageRotation(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage != null) {
      img.Image fixedImage = img.bakeOrientation(originalImage);
      final fixedFile = File(imagePath)
        ..writeAsBytesSync(img.encodeJpg(fixedImage, quality: 90));
      return fixedFile;
    }
    return File(imagePath);
  }

  Future<XFile?> _captureClearAndStraightPhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return null;
    }
    try {
      await cameraController!.setFocusMode(FocusMode.locked);
    } catch (_) {}

    final XFile image = await cameraController!.takePicture();
    return image;
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Registration with Smooth Progress Sync <<<<<<<<<<<<<<<<<<<<<<///
  Future<void> startScanning() async {
    isScanning = true;
    borderProgress.value = 0.0;
    update();

    await initializeCamera();

    if (cameraController == null || !cameraController!.value.isInitialized) {
      isScanning = false;
      update();
      Get.snackbar("Error", "Camera could not be started!", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // ১. প্রথমে ১ সেকেন্ডে ছবি ক্যাপচার করে ফেলুন
      await Future.delayed(const Duration(seconds: 1));
      borderProgress.value = 0.2; // কিছুটা ফিল হলো

      final XFile? image = await _captureClearAndStraightPhoto();
      if (image == null) throw Exception("Failed to capture image");
      capturedImage = File(image.path);

      dio.FormData formData = dio.FormData.fromMap({
        "device_id": LocalStorage.deviceId,
        "image": await dio.MultipartFile.fromFile(
          capturedImage!.path,
          filename: capturedImage!.path.split('/').last,
        ),
      });

      String token = LocalStorage.token;
      String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
      Map<String, String> headers = {"Authorization": authHeader};

      borderProgress.value = 0.4; // এপিআই কল পাঠানোর সময় প্রোগ্রেস বাড়ল

      // ২. ব্যাকগ্রাউন্ডে এপিআই কল চলতে থাকবে এবং সাথে সাথে অ্যানিমেশন আস্তে আস্তে বাড়তে থাকবে (সর্বোচ্চ ০.৯ পর্যন্ত)
      Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (borderProgress.value < 0.9 && isScanning) {
          borderProgress.value += 0.05;
          return true;
        }
        return false;
      });

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.saveFaceVerification,
        body: formData,
        header: headers,
      );

      // ৩. সার্ভার থেকে রেসপন্স আসা মাত্রই প্রোগ্রেস ১০০% পূর্ণ হয়ে যাবে
      borderProgress.value = 1.0;

      if (response.isSuccess) {
        showSuccessDialog();
      } else {
        await _resetCameraState();
        Get.snackbar("Failed", response.message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      await _resetCameraState();
      Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.TOP);
    }
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Login with Smooth Progress Sync <<<<<<<<<<<<<<<<<<<<<<///
  Future<void> startFaceLogin() async {
    isScanningLogin = true;
    borderProgress.value = 0.0;
    update();

    await initializeCamera();

    if (cameraController == null || !cameraController!.value.isInitialized) {
      isScanningLogin = false;
      update();
      Get.snackbar("Error", "Camera could not be started!", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      borderProgress.value = 0.2;

      final XFile? image = await _captureClearAndStraightPhoto();
      if (image == null) throw Exception("Failed to capture image");

      capturedImage = await _fixImageRotation(image.path);

      dio.FormData formData = dio.FormData.fromMap({
        "device_id": LocalStorage.deviceId,
        "image": await dio.MultipartFile.fromFile(
          capturedImage!.path,
          filename: "face_login.jpg",
        ),
      });

      String token = LocalStorage.token;
      String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
      Map<String, String> headers = {"Authorization": authHeader};

      borderProgress.value = 0.4;

      Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (borderProgress.value < 0.9 && isScanningLogin) {
          borderProgress.value += 0.05;
          return true;
        }
        return false;
      });

      ApiResponseModel response = await ApiService.post(
        "/auth/face-login",
        body: formData,
        header: headers,
      );

      borderProgress.value = 1.0;

      if (response.isSuccess) {
        if (response.data['data'] != null &&
            response.data['data']['accessToken'] != null) {
          String newAccessToken = response.data['data']['accessToken'];
          await LocalStorage.setString(LocalStorageKeys.token, newAccessToken);
          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          await LocalStorage.getAllPrefData();
        }
        showSuccessDialog();
      } else {
        await _resetCameraState();
        Get.snackbar("Failed", response.message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      await _resetCameraState();
      Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.TOP);
    }
  }




  Future<void> _resetCameraState() async {
    isScanning = false;
    isScanningLogin = false;
    borderProgress.value = 0.0;
    isCameraInitialized = false;
    update();
    await _disposeCamera();
    update();
  }

  void showSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7BD56),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.faceSuccess,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Congratulations",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F4C5C),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Your account is ready to use, redirecting to homepage",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[900]),
              ),
              SizedBox(height: 20.h),
              const CircularProgressIndicator(color: Color(0xFFF7BD56)),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () async {
      await _resetCameraState();
      Get.offAll(() => const HomeScreen());
    });
  }
}