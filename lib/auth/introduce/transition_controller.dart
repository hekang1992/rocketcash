import 'package:get/get.dart';

class TransitionController extends GetxController {
  late final String producdID;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
  }
}
