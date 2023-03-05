import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.uri, required this.title}) : super(key: key);

  final Uri uri;
  final String title;
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  late final WebViewController webViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint('url is :${widget.uri}');
     webViewController = WebViewController();
    webViewController..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress){
      debugPrint('WebView is loading (progress : $progress%');
    }))
    ..loadRequest(widget.uri);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller:webViewController),
    );
  }
}

