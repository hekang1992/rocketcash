import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/other/location/location.dart';

class ContactController extends GetxController {
  late final String producdID;

  var model = BaseModel().obs;

  var startTime = '';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getContactInfo(producdID);
    startTime = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

extension ContactVc on ContactController {
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

  //save
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
        await Uploadfindinginfo.scInfo(
          startTime: startTime,
          type: '7',
          producdID: producdID,
        );
      }
      FlutterShowToast.showToast(companion);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  //sace all people
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
