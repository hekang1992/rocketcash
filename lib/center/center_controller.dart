import 'package:get/get.dart';
import 'package:rocketcash/hive/save_info.dart';

class CenterController extends GetxController {
  RxString phone = ''.obs;

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
    final phoneStr = HiveStorage.getPhone() ?? '';
    phone.value = MakePhoneNumer.withNumber(phoneStr);
    print("onReady 被调用");
    // 页面渲染完成，可以安全地访问 UI
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose 被调用");
    // 清理资源
  }
}

class MakePhoneNumer {
  static String withNumber(String number) {
    final digits = number.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 6) {
      return digits;
    }

    String firstPart = digits.substring(0, 2);
    String lastPart = digits.substring(digits.length - 4);
    String maskedPart = '*' * (digits.length - 6);

    return firstPart + maskedPart + lastPart;
  }
}
