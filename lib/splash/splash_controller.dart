import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rocketcash/hive/save_info.dart';
import 'package:rocketcash/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await HiveStorage.init();

    await Future.delayed(const Duration(seconds: 2));

    final islogin = HiveStorage.isLoggedIn();

    if (islogin) {
      Get.offAllNamed(AppRoutes.tab);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
