import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class HomeController extends GetxController {
  var model = BaseModel().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print('onInit===home=====');
    await getHomeInfo();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady===home=====');
  }

  Future<void> getHomeInfo() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().get('/computed/shout');
      final model = BaseModel.fromJson(response.data);
      final salivating = model.salivating ?? '';
      if (salivating == '0' || salivating == '00') {
        this.model.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
