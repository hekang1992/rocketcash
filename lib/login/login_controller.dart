import 'package:get/get.dart';

class LoginController extends GetxController {
  var isClick = false.obs;

  clickManagement() {
    isClick.value = !isClick.value;
  }

  //login
  loginInfo() {
    Get.offAllNamed('/tab');
  }
}
