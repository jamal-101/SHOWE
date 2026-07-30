// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_navigation/src/snackbar/snackbar.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../core/storage/local_storage.dart';
// import '../../../core/storage/storage_key.dart';
// import '../../../core/utils/api_enpoint.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
// import '../../home/screen/home_screen.dart';
// import 'package:dio/dio.dart' as dio;
//
// enum Gender { male, female, other}
//
// class ProfileInformationController extends GetxController {
//   RxString selectedGender = "Select".obs;
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
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> faceRecognition <<<<<<<<<<<<<<<<<<<<<<///
//
//   CameraController? cameraController;
//   List<CameraDescription>? cameras;
//   bool isCameraInitialized = false;
//
//   Future<void> initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       if (cameras != null && cameras!.isNotEmpty) {
//         final frontCamera = cameras!.firstWhere(
//               (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras!.first,
//         );
//
//         cameraController = CameraController(
//           frontCamera,
//           ResolutionPreset.high,
//           enableAudio: false,
//         );
//
//         await cameraController!.initialize();
//         isCameraInitialized = true;
//         update();
//       }
//     } catch (e) {
//       debugPrint("Camera Error: $e");
//     }
//   }
//
//
//   @override
//   void onClose() {
//     cameraController?.dispose();
//     super.onClose();
//   }
//
//   bool isScanning = false;
//   File? capturedImage;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> startScanning() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         preferredCameraDevice: CameraDevice.front,
//         imageQuality: 50,
//       );
//
//       if (image != null) {
//         capturedImage = File(image.path);
//         isScanning = true;
//         update();
//
//         dio.FormData formData = dio.FormData.fromMap({
//           "device_id": LocalStorage.deviceId,
//           "image": await dio.MultipartFile.fromFile(
//             capturedImage!.path,
//             filename: capturedImage!.path.split('/').last,
//           ),
//         });
//
//         String token = LocalStorage.token;
//         String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
//
//         // >>>>>>>>>>> হেডারে JWT Token পাস করা হলো <<<<<<<<<<<
//         Map<String, String> headers = {
//           "Authorization": authHeader,
//         };
//
//         ApiResponseModel response = await ApiService.post(
//           ApiEndPoint.saveFaceVerification,
//           body: formData,
//           header: headers, // আপনার ApiService যদি ৩য় প্যারামিটার হিসেবে হেডার নেয়
//         );
//
//         if (response.isSuccess) {
//           showSuccessDialog();
//         } else {
//           isScanning = false;
//           update();
//           Get.snackbar("Failed", response.message, snackPosition: SnackPosition.BOTTOM);
//         }
//       }
//     } catch (e) {
//       isScanning = false;
//       update();
//       Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//
//   bool isScanningLogin = false;
//
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Face Login Integration with OTP Token <<<<<<<<<<<<<<<<<<<<<<///
//
//   Future<void> startFaceLogin() async {
//     await initializeCamera();
//     try {
//       // ১. ফ্রন্ট ক্যামেরা দিয়ে সেলফি তোলা
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         preferredCameraDevice: CameraDevice.front,
//       );
//
//       if (image != null) {
//         capturedImage = File(image.path);
//         isScanningLogin = true;
//         update();
//
//         // ২. Form-Data রেডি করা
//         dio.FormData formData = dio.FormData.fromMap({
//           "device_id": LocalStorage.deviceId,
//           "image": await dio.MultipartFile.fromFile(
//             capturedImage!.path,
//             filename: capturedImage!.path.split('/').last,
//           ),
//         });
//         String token = LocalStorage.token;
//         String authHeader = token.startsWith("Bearer") ? token : "Bearer $token";
//         Map<String, String> headers = {
//           "Authorization": authHeader,
//         };
//         ApiResponseModel response = await ApiService.post(
//           "/auth/face-login",
//           body: formData,
//           header: headers,
//         );
//
//         if (response.isSuccess) {
//           if (response.data['data'] != null && response.data['data']['accessToken'] != null) {
//             String newAccessToken = response.data['data']['accessToken'];
//             await LocalStorage.setString(LocalStorageKeys.token, newAccessToken);
//             await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
//             await LocalStorage.getAllPrefData();
//           }
//           showSuccessDialog();
//         } else {
//           isScanningLogin = false;
//           update();
//           Get.snackbar("Failed", response.message, snackPosition: SnackPosition.BOTTOM);
//         }
//       }
//     } catch (e) {
//       isScanningLogin = false;
//       update();
//       Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   void showSuccessDialog() {
//     Get.dialog(
//       barrierDismissible: false,
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
//                 child: Image.asset(AppImages.faceSuccess,height: 100.h,width: 100.w),
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
//                 style: TextStyle(fontSize: 14.sp, color: Colors.grey),
//               ),
//               SizedBox(height: 20.h),
//               const CircularProgressIndicator(color: Color(0xFFF7BD56)),
//             ],
//           ),
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () {
//       isScanning = false;
//       isScanningLogin = false;
//       update();
//       Get.offAll(()=>HomeScreen());
//     });
//   }
// }

// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../core/storage/local_storage.dart';
// import '../../../core/storage/storage_key.dart';
// import '../../../core/utils/api_enpoint.dart';
// import '../../../core/utils/api_response_model.dart';
// import '../../../core/utils/api_service.dart';
// import '../../home/screen/home_screen.dart';
// import 'package:dio/dio.dart' as dio;
//
// enum Gender { male, female, other }
//
// class ProfileInformationController extends GetxController {
//   RxString selectedGender = "Select".obs;
//
//   void updateSelectedGender(Gender genderItem) {
//     switch (genderItem) {
//       case Gender.male: selectedGender.value = "male"; break;
//       case Gender.female: selectedGender.value = "female"; break;
//       case Gender.other: selectedGender.value = "Prefer not to say"; break;
//     }
//   }
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Live Camera Setup <<<<<<<<<<<<<<<<<<<<<<///
//   CameraController? cameraController;
//   List<CameraDescription>? cameras;
//   bool isCameraInitialized = false;
//   bool isScanningLogin = false;
//   File? capturedImage;
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<void> initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       if (cameras != null && cameras!.isNotEmpty) {
//         final frontCamera = cameras!.firstWhere(
//               (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras!.first,
//         );
//
//         cameraController = CameraController(
//           frontCamera,
//           ResolutionPreset.high,
//           enableAudio: false,
//         );
//
//         await cameraController!.initialize();
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
//   bool isScanning = false;
//   final ImagePicker _picker = ImagePicker();
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Face Registration (On Click Live Capture) <<<<<<<<<<<<<<<<<<<<<<///
//   Future<void> startScanning() async {
//     isScanning = true;
//     update();
//     await initializeCamera();
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       isScanning = false;
//       update();
//       Get.snackbar("Error", "Camera could not be started!", snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//     try {
//       await Future.delayed(const Duration(milliseconds: 1500));
//       final XFile image = await cameraController!.takePicture();
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
//       Map<String, String> headers = {
//         "Authorization": authHeader,
//       };
//
//       // ৪. ফেস সেভ করার এপিআই কল
//       ApiResponseModel response = await ApiService.post(
//         ApiEndPoint.saveFaceVerification,
//         body: formData,
//         header: headers,
//       );
//
//       if (response.isSuccess) {
//         showSuccessDialog();
//       } else {
//         isScanning = false;
//         isCameraInitialized = false;
//         cameraController?.dispose(); // ফেইল হলে ক্যামেরা রিলিজ করে আগের স্টেটে ব্যাক করবে
//         update();
//         Get.snackbar("Failed", response.message, snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       isScanning = false;
//       isCameraInitialized = false;
//       cameraController?.dispose();
//       update();
//       Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Face Login (On Click Live Capture) <<<<<<<<<<<<<<<<<<<<<<///
//   Future<void> startFaceLogin() async {
//     // ১. বাটনে ক্লিক করার সাথে সাথে স্ক্যানিং স্টেট অন হবে এবং ক্যামেরা লোড হওয়া শুরু করবে
//     isScanningLogin = true;
//     update();
//
//     await initializeCamera();
//
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       isScanningLogin = false;
//       update();
//       Get.snackbar("Error", "Camera could not be started!", snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     try {
//       await Future.delayed(const Duration(milliseconds: 1500));
//       final XFile image = await cameraController!.takePicture();
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
//       Map<String, String> headers = {
//         "Authorization": authHeader,
//       };
//
//       ApiResponseModel response = await ApiService.post(
//         "/auth/face-login",
//         body: formData,
//         header: headers,
//       );
//
//       if (response.isSuccess) {
//         if (response.data['data'] != null && response.data['data']['accessToken'] != null) {
//           String newAccessToken = response.data['data']['accessToken'];
//           await LocalStorage.setString(LocalStorageKeys.token, newAccessToken);
//           await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
//           await LocalStorage.getAllPrefData();
//         }
//         showSuccessDialog();
//       } else {
//         isScanningLogin = false;
//         isCameraInitialized = false;
//         cameraController?.dispose();
//         update();
//         Get.snackbar("Failed", response.message, snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       isScanningLogin = false;
//       isCameraInitialized = false;
//       cameraController?.dispose();
//       update();
//       Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   void showSuccessDialog() {
//     Get.dialog(
//       barrierDismissible: false,
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
//                 child: Image.asset(AppImages.faceSuccess, height: 100.h, width: 100.w),
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
//                 style: TextStyle(fontSize: 14.sp, color: Colors.grey),
//               ),
//               SizedBox(height: 20.h),
//               const CircularProgressIndicator(color: Color(0xFFF7BD56)),
//             ],
//           ),
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () {
//       isScanningLogin = false;
//       isCameraInitialized = false;
//       cameraController?.dispose();
//       update();
//       Get.offAll(() => HomeScreen());
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

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Live Camera Setup <<<<<<<<<<<<<<<<<<<<<<///
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isScanningLogin = false;
  bool isScanning = false;
  File? capturedImage;

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
    cameraController?.dispose();
    super.onClose();
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

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Registration <<<<<<<<<<<<<<<<<<<<<<///
  Future<void> startScanning() async {
    isScanning = true;
    update();
    await initializeCamera();

    if (cameraController == null || !cameraController!.value.isInitialized) {
      isScanning = false;
      update();
      Get.snackbar(
        "Error",
        "Camera could not be started!",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 10));
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

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.saveFaceVerification,
        body: formData,
        header: headers,
      );

      if (response.isSuccess) {
        showSuccessDialog();
      } else {
        _resetCameraState();
        Get.snackbar(
          "Failed",
          response.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      _resetCameraState();
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withValues(alpha: 0.9),
      );
    }
  }

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>> Face Login <<<<<<<<<<<<<<<<<<<<<<///
  Future<void> startFaceLogin() async {
    isScanningLogin = true;
    update();

    await initializeCamera();

    if (cameraController == null || !cameraController!.value.isInitialized) {
      isScanningLogin = false;
      update();
      Get.snackbar(
        "Error",
        "Camera could not be started!",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 10));
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

      ApiResponseModel response = await ApiService.post(
        "/auth/face-login",
        body: formData,
        header: headers,
      );

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
        _resetCameraState();
        Get.snackbar(
          "Failed",
          response.message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      _resetCameraState();
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _resetCameraState() {
    isScanning = false;
    isScanningLogin = false;
    isCameraInitialized = false;
    cameraController?.dispose();
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
    Future.delayed(const Duration(seconds: 3), () {
      _resetCameraState();
      Get.offAll(() => const HomeScreen());
    });
  }
}
