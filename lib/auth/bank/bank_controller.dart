import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class BankController extends GetxController {
  late final String producdID;

  var model = BaseModel().obs;

  final inputControllers = <int, TextEditingController>{};

  @override
  void onInit() async {
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getBankInfo(producdID);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    inputControllers.forEach((key, ctrl) => ctrl.dispose());
    super.onClose();
  }
}

extension BankVc on BankController {
  //获取bank信息
  Future<void> getBankInfo(String productID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final dict = {'successfully': productID, 'alter': '0'};
    try {
      final response = await HttpService().get(
        '/computed/beloved',
        queryParameters: dict,
      );
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
