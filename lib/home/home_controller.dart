import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';

class HomeController extends GetxController {
  var model = BaseModel().obs;
  final refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    print('onInit===home=====');
    await getHomeInfo(); // 首次加载
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

extension Home on HomeController {
  Future<void> getHomeInfo() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);

    try {
      final response = await HttpService().get('/computed/shout');
      final result = BaseModel.fromJson(response.data);
      if (result.salivating == '0' || result.salivating == '00') {
        model.value = result;
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshCompleted();
      }
      EasyLoading.dismiss();
    } catch (e) {
      refreshController.refreshCompleted();
      EasyLoading.dismiss();
    }
  }
}
