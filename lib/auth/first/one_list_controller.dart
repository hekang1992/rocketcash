import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class OneListController extends GetxController {
  late final String? procutID;
  late final String? authStr;

  var model = BaseModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    procutID = Get.parameters['productID'] ?? '';
    authStr = Get.parameters['auth'] ?? '';
    print("onInit 被调用=====onelist");

    getAuthInfo(procutID ?? '');
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("onReady 被调用=====onelist");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("onClose 被调用=====onelist");
  }
}

extension OneListVc on OneListController {
  //获取用户认证信息 === 身份和人像
  Future<void> getAuthInfo(String productID) async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: true);
    try {
      final response = await HttpService().get(
        '/computed/tonightim',
        queryParameters: {
          'successfully': productID,
          'sutra': 'c',
          'auth': authStr ?? '',
        },
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == "00") {
        this.model.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
