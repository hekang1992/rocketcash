import 'package:get/get.dart';

class PersonalController extends GetxController {
  late final String producdID;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['productID'] ?? '';
  }
}
