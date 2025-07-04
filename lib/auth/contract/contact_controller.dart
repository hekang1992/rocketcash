import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class ContactController extends GetxController {
  late final String producdID;
  var model = BaseModel().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getContactInfo(producdID);
  }
}

extension ContactVc on ContactController {
  //获取联系人信息
  Future<void> getContactInfo(String productID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final dict = {'successfully': productID, 'pour': '1'};
    try {
      final response = await HttpService().postForm('/computed/puzzled', dict);
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

  //保存联系人模块
  Future<void> upContactInfo(Map<String, dynamic> dict) async {
    dict['successfully'] = producdID;
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().postForm('/computed/wetness', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        final controller = Get.put(IntroduceController());
        controller.getProductDetailToNextPage(producdID);
      }
      FlutterShowToast.showToast(companion);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  //保存所有联系人信息
  Future<void> safeAllInfo(Map<String, dynamic> dict) async {
    try {
      final response = await HttpService().postForm('/computed/thosei', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {}
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
