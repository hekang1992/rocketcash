import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/other/location/location.dart';

class WorkController extends GetxController {
  late final String producdID;

  var model = BaseModel().obs;

  var citymodel = BaseModel().obs;

  final inputControllers = <int, TextEditingController>{};

  List<Fortunemodel> get fortuneList => model.value.maiden?.fortune ?? [];

  var startTime = '';

  @override
  void onInit() async {
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getJobInfo(producdID);
    DateTime.now().millisecondsSinceEpoch.toString();
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

extension PersonVc on WorkController {
  //获取工作信息
  Future<void> getJobInfo(String productID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    final dict = {'successfully': productID, 'scrolls': '1'};
    try {
      final response = await HttpService().postForm('/computed/beloved', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        final listmodel = model.maiden?.fortune ?? [];
        for (var i = 0; i < listmodel.length; i++) {
          final model = listmodel[i];
          if (model.opportunities == 'flectuical') {
            inputControllers[i] = TextEditingController();
          }
        }
        this.model.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<void> getCityInfo() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().get('/computed/discreetlyeven');
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        citymodel.value = model;
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<void> saveJobInfo(Map<String, dynamic> dict) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().postForm(
        '/computed/injustice',
        dict,
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        final controller = Get.put(IntroduceController());
        controller.getProductDetailToNextPage(producdID);
        await Uploadfindinginfo.scInfo(
          startTime: startTime,
          type: '6',
          producdID: producdID,
        );
      }
      FlutterShowToast.showToast(companion);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
