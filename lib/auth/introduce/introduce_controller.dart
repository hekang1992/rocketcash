import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class IntroduceController extends GetxController {
  late final String producdID;

  var model = BaseModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    getProductDetailInfo(producdID);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

extension Introduce on IntroduceController {
  Future<void> getProductDetailInfo(String producdID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);

    try {
      final response = await HttpService().postForm('/computed/better', {
        'activated': '0',
        'successfully': producdID,
        'backlighting': '1',
      });
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        this.model.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
