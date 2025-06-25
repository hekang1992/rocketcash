import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:rocketcash/hive/save_info.dart';
import 'package:rocketcash/routes/routes.dart';

class SplashController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late final Stream<ConnectivityResult> _connectivityStream;
  final RxString connectionStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      switch (result) {
        case ConnectivityResult.mobile:
          connectionStatus.value = 'mobile';
          print('5g========');
          break;
        case ConnectivityResult.wifi:
          connectionStatus.value = 'wifi';
          print('wifi========');
          break;
        case ConnectivityResult.none:
          connectionStatus.value = 'none';
          print('none========');
          break;
        default:
          connectionStatus.value = 'unknown';
          print('unknown========');
      }
    });

    ever(connectionStatus, (value) async {
      if (value == 'none' || value == "unknow") {
        Fluttertoast.showToast(
          msg: 'Connection lost, please check your network.',
        );
      } else if (value == 'mobile' || value == "wifi") {
        await logininitInfo();
      }
    });
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
  }

  logininitInfo() async {
    await HiveStorage.init();

    await Future.delayed(const Duration(seconds: 2));

    final islogin = HiveStorage.isLoggedIn();

    final isshowguige = HiveStorage.isClick();

    if (isshowguige) {
      if (islogin) {
        Get.offAllNamed(AppRoutes.tab);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.guide);
    }
  }
}
