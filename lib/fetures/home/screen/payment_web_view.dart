// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import '../../../core/route/app_routes.dart';
//
// class PaymentWebViewScreen extends StatelessWidget {
//   final String paymentUrl;
//
//   const PaymentWebViewScreen({super.key, required this.paymentUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri(paymentUrl)),
//         onUpdateVisitedHistory: (controller, uri, isReload) {
//           if (uri != null) {
//             String urlString = uri.toString();
//             debugPrint(">>>> WebView Navigated URL: $urlString");
//             if (urlString.contains("purchase-success")) {
//               Get.back();
//               Get.offAllNamed(AppRoutes.homeScreen);
//               Future.delayed(const Duration(milliseconds: 200), () {
//                 Get.toNamed(AppRoutes.myProgramScreen);
//               });
//
//             }
//           }
//         },
//       ),
//     );
//   }
// }

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(paymentUrl)),
        onUpdateVisitedHistory: (controller, uri, isReload) {
          if (uri != null) {
            String urlString = uri.toString();
            debugPrint(">>>> WebView Navigated URL: $urlString");

            // ১. Payment Success Condition
            if (urlString.contains("payment/success")) {
              Get.offAllNamed(AppRoutes.homeScreen);
              Get.toNamed(AppRoutes.myProgramScreen);
            }
            // ২. Payment Cancelled Condition
            else if (urlString.contains("payment/cancelled") || urlString.contains("payment/cancel")) {
              Get.back();
            }
          }
        },
      ),
    );
  }
}