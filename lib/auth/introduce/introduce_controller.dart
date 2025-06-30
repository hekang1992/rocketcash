import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class IntroduceController extends GetxController {
  late final String producdID;

  var model = BaseModel().obs;

  var listModel = BaseModel().obs;

  //用户信息model
  var authmodel = BaseModel().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getProductDetailInfo(producdID);
    await getAuthInfo(producdID);
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

  Future<void> getUmidInfo() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().get(
        '/computed/without',
        queryParameters: {'licence': '1'},
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        listModel.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  //获取用户umid信息
  Future<void> getAuthInfo(String productID) async {
    EasyLoading.show(status: '加载中...', dismissOnTap: true);
    try {
      final response = await HttpService().get(
        '/computed/tonightim',
        queryParameters: {'successfully': productID, 'sutra': 'c'},
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == "00") {
        authmodel.value = model;
      }
    } catch (e) {
      EasyLoading.dismiss();
    } finally {
      EasyLoading.dismiss();
    }
  }
}
