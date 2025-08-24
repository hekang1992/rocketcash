import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/home/home_controller.dart';
import 'package:rocketcash/main/main_controller.dart';
import 'package:rocketcash/order/order_controller.dart';
import 'package:rocketcash/other/hive/save_info.dart';
import 'package:rocketcash/other/location/location.dart';
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

  late final String whitePage;

  bool isLoading = true;

  String? matchedRoute;

  @override
  void initState() {
    super.initState();
    pageUrl = Get.parameters['pageUrl'] ?? '';
    whitePage = Get.parameters['page'] ?? '';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
              EasyLoading.show(status: 'loading...', dismissOnTap: false);
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
      ..addJavaScriptChannel(
        'bagelToas',
        onMessageReceived: (message) async {
          String? value = message.message;
          List<dynamic> list = jsonDecode(value);
          final producdID = list.first.toString();
          final startTime = DateTime.now().millisecondsSinceEpoch.toString();
          await Uploadfindinginfo.scInfo(
            startTime: startTime,
            type: '10',
            producdID: producdID,
          );
        },
      )
      ..addJavaScriptChannel(
        'radishEgg',
        onMessageReceived: (message) {
          String? pageurl = message.message;
          if (pageurl.startsWith('http://') || pageurl.startsWith('https://')) {
            _controller.loadRequest(Uri.parse(pageurl));
          } else if (pageurl.contains('rocket.apploan.org/bearIrisBell')) {
            final uri = Uri.parse(pageurl);
            final value = uri.queryParameters['successfully'] ?? '';
            final controller = Get.put(IntroduceController());
            controller.getProductDetailInfo(value, type: 'h5');
          } else if (pageurl.contains('rocket.apploan.org/apricxotSoda')) {
            final controller = Get.put(MainController());
            controller.changeTabIndex(0);
            Get.until((route) {
              final currentRoute = route.settings.name?.split('?').first;
              if (currentRoute == AppRoutes.tab) {
                matchedRoute = currentRoute;
                return true;
              }
              return false;
            });
          } else if (pageurl.contains('rocket.apploan.org/amaranthCucu')) {
            HiveStorage.clearPhone();
            HiveStorage.clearToken();
            HiveStorage.clearLoginTime();
            Get.offAllNamed(AppRoutes.login);
          }
        },
      )
      ..addJavaScriptChannel(
        'ninjaWhea',
        onMessageReceived: (message) {
          Get.back();
        },
      )
      ..addJavaScriptChannel(
        'quinceHon',
        onMessageReceived: (message) {
          final controller = Get.put(MainController());
          controller.changeTabIndex(0);
          Get.until((route) {
            final currentRoute = route.settings.name?.split('?').first;
            if (currentRoute == AppRoutes.tab) {
              matchedRoute = currentRoute;
              return true;
            }
            return false;
          });
        },
      )
      ..addJavaScriptChannel(
        'coffeeJui',
        onMessageReceived: (message) {
          String? email = message.message;
          final phone = HiveStorage.getPhone() ?? '';
          SendEmail.sendeimail(email, phone);
        },
      )
      ..addJavaScriptChannel(
        'cookJui',
        onMessageReceived: (message) {
          JudgeFage.isJudge();
        },
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
              if (whitePage == 'introduce') {
                Get.back();
                return;
              }
              Get.until((route) {
                final currentRoute = route.settings.name?.split('?').first;
                if (currentRoute == AppRoutes.tab ||
                    currentRoute == AppRoutes.login ||
                    currentRoute == AppRoutes.orderlist ||
                    currentRoute == AppRoutes.centerlist) {
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

class JudgeFage {
  static const MethodChannel _channel = MethodChannel('judge_fate');
  static Future<void> isJudge() async {
    try {
      await _channel.invokeMethod('judgefate');
    } catch (e) {
      print('Failed to invoke method: $e');
    }
  }
}

class SendEmail {
  static const MethodChannel _channel = MethodChannel('send_email');

  static Future<void> sendeimail(String email, String phone) async {
    try {
      await _channel.invokeMethod('sendemail', {
        'email': email,
        'phone': phone,
      });
    } catch (e) {
      print('Failed to invoke method: $e');
    }
  }
}
