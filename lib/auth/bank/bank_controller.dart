import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/other/location/location.dart';

class BankController extends GetxController {
  late final String producdID;

  var model = BaseModel();

  var listModel = Fortunemodel().obs;

  final inputControllers = <int, TextEditingController>{};

  var selected = 'E-Wallet'.obs;

  var startTime = '';

  void select(String value) {
    selected.value = value;
    final fortuneList = model.maiden?.fortune ?? [];
    if (selected.value == 'E-Wallet') {
      listModel.value = fortuneList[0];
      addTextController(fortuneList[0]);
    } else {
      listModel.value = fortuneList[1];
      addTextController(fortuneList[1]);
    }
    listModel.refresh();
  }

  @override
  void onInit() async {
    super.onInit();
    producdID = Get.parameters['producdID'] ?? '';
    await getBankInfo(producdID);
    startTime = DateTime.now().millisecondsSinceEpoch.toString();
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
  Future<void> getBankInfo(String productID) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: false);
    final dict = {'successfully': productID, 'alter': '0'};
    try {
      final response = await HttpService().get(
        '/computed/count',
        queryParameters: dict,
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      if (code == '0' || code == '00') {
        this.model = model;
        final fortuneList = model.maiden?.fortune ?? [];
        addTextController(fortuneList[0]);
        listModel.value = fortuneList[0];
        print('object========$fortuneList');
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  addTextController(Fortunemodel model) {
    final fortune = model.fortune ?? [];
    for (var i = 0; i < fortune.length; i++) {
      final model = fortune[i];
      if (model.opportunities == 'flectuical') {
        inputControllers[i] = TextEditingController();
      }
    }
  }

  Future saveBankInfo(Map<String, dynamic> dict) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().postForm('/computed/tears', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        final controller = Get.put(IntroduceController());
        controller.getProductDetailToNextPage(producdID);
        await Uploadfindinginfo.scInfo(
          startTime: startTime,
          type: '8',
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
