import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CenterController extends GetxController {
  void clickTap() {
    print('clickTap======');
  }

  @override
  void onInit() {
    super.onInit();
    print("onInit 被调用");
    // 初始化操作，如 API 请求
  }

  @override
  void onReady() {
    super.onReady();
    print("onReady 被调用");
    // 页面渲染完成，可以安全地访问 UI
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    Future.delayed(Duration(milliseconds: 3000), () {
      EasyLoading.dismiss();
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose 被调用");
    // 清理资源
  }
}
