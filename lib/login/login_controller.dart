import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  var isClick = false.obs;

  clickManagement() {
    isClick.value = !isClick.value;
  }

  //login
  loginInfo() {
    Fluttertoast.showToast(msg: '跳转登录页面', gravity: ToastGravity.CENTER);
    Get.offAllNamed('/tab');
  }
}
