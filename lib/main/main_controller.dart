import 'package:get/get.dart';
import 'package:rocketcash/home/home_controller.dart';

class MainController extends GetxController {
  var tabIndex = 0.obs;

  final controller = Get.put(HomeController());

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      controller.getHomeInfo();
    }
  }
}
