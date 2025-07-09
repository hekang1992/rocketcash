import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rocketcash/auth/contract/contace_services.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/login_info.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/other/hive/save_info.dart';
import 'package:rocketcash/other/location/location.dart';
import 'package:rocketcash/routes/routes.dart';

class HomeController extends GetxController {
  var model = BaseModel().obs;
  final refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    print('onInit===home=====');
    getHomeInfo(); // 首次加载

    final position = await LocationService.getDetailedLocation();
    await uploadLocationInfo(position);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

extension Home on HomeController {
  //获取首页信息
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

  //申请产品
  Future<void> applyProduct(String producdID) async {
    final function = this.model.value.maiden?.function ?? 0;
    LocationPermission permission = await Geolocator.checkPermission();
    if (function == 1) {
      //判断是否定位
      if (permission != LocationPermission.always ||
          permission != LocationPermission.whileInUse) {
        PermissionConfig.showPermissionDeniedDialog('Location');
        return;
      }
    }
    final position = await LocationService.getDetailedLocation();
    await uploadLocationInfo(position);

    final startTime = HiveStorage.getloginTime() ?? '';
    Uploadfindinginfo.scInfo(
      startTime: startTime,
      type: '1',
      producdID: producdID,
    );

    Map<String, String> dict = await LoginInfoManager.getLoginInfo();
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().postForm('/computed/eerily', {
        'coca': '1',
        'coke': '1',
        'successfully': producdID,
      });
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        final nextUrl = model.maiden?.rpgs ?? '';
        if (nextUrl.contains('rocket.apploan.org/bearIrisBell')) {
          final uri = Uri.parse(nextUrl);
          final value = uri.queryParameters['successfully'] ?? '';
          Get.toNamed(AppRoutes.introduce, parameters: {'producdID': value});
        } else {
          String? pageUrl =
              URLParameterHelper.appendQueryParameters(nextUrl, dict) ?? '';
          Get.toNamed(AppRoutes.webpage, parameters: {'pageUrl': pageUrl});
        }
      } else {
        FlutterShowToast.showToast(companion);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  //上报定位信息
  Future<void> uploadLocationInfo(Map<String, dynamic> dict) async {
    try {
      await HttpService().postForm('/computed/mealsi', dict);
    } catch (e) {}
  }
}
