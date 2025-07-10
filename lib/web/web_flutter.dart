import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/home/home_controller.dart';
import 'package:rocketcash/main/main_controller.dart';
import 'package:rocketcash/order/order_controller.dart';
import 'package:rocketcash/order/order_list_view.dart';
import 'package:rocketcash/routes/routes.dart';
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

  String? matchedRoute;

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
              // final vc = Get.put(MainController());
              // vc.changeTabIndex(0);
              // final index = vc.tabIndex.value;
              Get.until((route) {
                final currentRoute = route.settings.name?.split('?').first;
                if (currentRoute == AppRoutes.tab ||
                    currentRoute == AppRoutes.orderlist) {
                  matchedRoute = currentRoute;
                  return true;
                }
                return false;
              });
              print('back==========: $matchedRoute');
              if (matchedRoute == '/orderlist') {
                final controller = Get.put(OrderController());
                final selectedIndex = controller.selectedIndex.value;
                var listtype = '';
                if (selectedIndex == 0) {
                  listtype = '4';
                } else if (selectedIndex == 1) {
                  listtype = '7';
                } else if (selectedIndex == 2) {
                  listtype = '6';
                } else {
                  listtype = '5';
                }
                controller.getOrderList(listtype);
              }
              if (matchedRoute == '/tab') {
                final controller = Get.put(MainController());
                final selectedIndex = controller.tabIndex.value;
                if (selectedIndex == 0) {
                  final controller = Get.put(HomeController());
                  controller.getHomeInfo();
                }
              }
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
