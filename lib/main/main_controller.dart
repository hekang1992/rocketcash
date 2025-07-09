import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/contract/contace_services.dart';
import 'package:rocketcash/home/home_controller.dart';

class MainController extends GetxController {
  var tabIndex = 0.obs;

  final controller = Get.put(HomeController());

  Future<void> changeTabIndex(int index) async {
    final function = controller.model.value.maiden?.function ?? 0;
    LocationPermission permission = await Geolocator.checkPermission();
    if (function == 1) {
      //判断是否定位
      if (permission != LocationPermission.always ||
          permission != LocationPermission.whileInUse) {
        PermissionConfig.showPermissionDeniedDialog('Location');
        return;
      }
    }

    tabIndex.value = index;
    if (index == 0) {
      controller.getHomeInfo();
    }
  }
}
