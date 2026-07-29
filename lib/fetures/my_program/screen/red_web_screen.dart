import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReaderWebScreen extends StatefulWidget {
  final String readerUrl;
  final String title;

  const ReaderWebScreen({
    super.key,
    required this.readerUrl,
    this.title = "Reader",
  });

  @override
  State<ReaderWebScreen> createState() => _ReaderWebScreenState();
}
class _ReaderWebScreenState extends State<ReaderWebScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.readerUrl));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios, color: Colors.white,size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE5A000),
              ),
            ),
        ],
      ),
    );
  }
}