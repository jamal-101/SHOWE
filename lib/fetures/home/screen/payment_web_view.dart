import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../core/route/app_routes.dart';

class PaymentWebViewScreen extends StatelessWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Checkout"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(paymentUrl)),
        onUpdateVisitedHistory: (controller, uri, isReload) {
          if (uri != null) {
            String urlString = uri.toString();
            debugPrint(">>>> WebView Navigated URL: $urlString");

            // 🎯 URL-এ purchase-success আসা মাত্রই পেজ বন্ধ হয়ে My Program এ নিয়ে যাবে
            if (urlString.contains("purchase-success")) {
              Get.back(); // WebView স্ক্রিনটি পপ করবে

              // সরাসরি My Program স্ক্রিনে রিডাইরেক্ট
              Get.offAllNamed(AppRoutes.homeScreen);
              Future.delayed(const Duration(milliseconds: 200), () {
                Get.toNamed(AppRoutes.myProgramScreen);
              });

              Get.snackbar(
                "Payment Successful",
                "Your ticket has been confirmed.",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        },
      ),
    );
  }
}