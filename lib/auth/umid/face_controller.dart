import 'package:get/get.dart';
import 'package:rocketcash/auth/umid/one_list_controller.dart';

class FaceController extends GetxController {
  RxBool isUploading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final controller = Get.put(OneListController());
    controller.camerastartTime = DateTime.now().millisecondsSinceEpoch
        .toString();

    print("开始=============${DateTime.now().millisecondsSinceEpoch.toString()}");
  }
}
