import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IntroduceController extends GetxController {
  late final String producdID;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    print('onInit===introduce=====, producdID: $producdID');
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
