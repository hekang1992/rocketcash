import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/center/center_controller.dart';
import 'package:rocketcash/hive/save_info.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/routes/routes.dart';

class CenterListController extends GetxController {
  String getPhone() {
    String? phone = MakePhoneNumer.withNumber(HiveStorage.getPhone() ?? '');
    return phone;
  }

  Future<void> logout() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().get('/computed/doing');
      final model = BaseModel.fromJson(response.data);

      var code = model.salivating ?? '';
      var companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        Get.offAllNamed(AppRoutes.login);
        HiveStorage.clearPhone();
        HiveStorage.clearToken();
      }
      EasyLoading.dismiss();
      FlutterShowToast.showToast(companion);
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
