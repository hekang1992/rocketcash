import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebFlutterView extends StatefulWidget {
  const WebFlutterView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebFlutterViewState();
  }
}

class _WebFlutterViewState extends State<WebFlutterView> {
  late final WebViewController _controller;
  var urltitle = '';
  late final String pageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    pageUrl = Get.parameters['pageUrl'] ?? '';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
              EasyLoading.show(status: 'loading...', dismissOnTap: true);
            });
          },
          onPageFinished: (url) async {
            final title = await _controller.getTitle() ?? '';
            setState(() {
              isLoading = false;
              EasyLoading.dismiss();
              urltitle = title;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              isLoading = false;
              EasyLoading.dismiss();
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(pageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar(
          urltitle,
          onPressed: () async {
            if (await _controller.canGoBack()) {
              _controller.goBack();
            } else {
              Get.back();
            }
          },
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
