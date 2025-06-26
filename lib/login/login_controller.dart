import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rocketcash/hive/save_info.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/routes/routes.dart';

class LoginController extends GetxController {
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController codecontroller = TextEditingController();

  var isClick = false.obs;

  //验证码
  var secondsLeft = 0.obs;
  Timer? _timer;

  clickManagement() {
    isClick.value = !isClick.value;
  }

  void startCountdown() {
    if (_timer != null && _timer!.isActive) return;

    secondsLeft.value = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  //code
  Future<void> tolcodeinfo(String phone) async {
    if (phone.isEmpty) {
      FlutterShowToast.showToast('Please enter your phone number.');
      return;
    }
    EasyLoading.show(status: 'loading...', dismissOnTap: true);

    print("发送验证码给: $phone");

    // 发送成功后启动倒计时
    startCountdown();

    final response = await HttpService().postForm('/computed/different', {
      'space': phone,
      'halt': 'login',
    });

    final model = BaseModel.fromJson(response.data);

    var code = model.salivating ?? '';
    var companion = model.companion ?? '';
    if (code == '0' || code == '00') {}
    await EasyLoading.dismiss();
    FlutterShowToast.showToast(companion);

    print('model-------$model');
  }

  //login
  Future<void> tologininfo({String? phone, String? rtp}) async {
    if (phone == null || phone == '') {
      FlutterShowToast.showToast('Please enter your phone number.');
      return;
    }
    if (rtp == null || rtp == '') {
      FlutterShowToast.showToast('Please enter your code number.');
      return;
    }
    if (isClick.value == false) {
      FlutterShowToast.showToast(
        'Please review and accept the Privacy Policy and Loan Terms before logging in.',
      );
      return;
    }
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final response = await HttpService().postForm('/computed/grandfatherye', {
      'fairy': phone,
      'hot': rtp,
      'blow': 'code',
    });

    final model = BaseModel.fromJson(response.data);

    var code = model.salivating ?? '';
    var companion = model.companion ?? '';
    if (code == '0' || code == '00') {
      final phone = model.maiden?.fairy ?? '';
      final token = model.maiden?.blow ?? '';
      HiveStorage.savePhone(phone);
      HiveStorage.saveToken(token);
      Get.offAllNamed(AppRoutes.tab);
    }
    await EasyLoading.dismiss();
    FlutterShowToast.showToast(companion);

    print('model-------$model');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
