import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class ContactController extends GetxController {
  late final String producdID;
  var model = BaseModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    getContactInfo(producdID);
  }
}

extension ContactVc on ContactController {
  //获取联系人信息
  Future<void> getContactInfo(String productID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final dict = {'successfully': productID, 'scrolls': '1'};
    try {
      final response = await HttpService().postForm('/computed/sirius', dict);
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
