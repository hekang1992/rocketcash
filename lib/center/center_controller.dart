import 'package:get/get.dart';
import 'package:rocketcash/other/hive/save_info.dart';
import 'package:rocketcash/other/location/location.dart';

class CenterController extends GetxController {
  RxString phone = ''.obs;

  void clickTap() {
    print('clickTap======');
  }

  @override
  void onInit() async {
    super.onInit();
    print("onInit===");

    final position = await LocationService.getDetailedLocation();
    print(
      'latitude==========${position['latitude']}, longitude=========${position['longitude']}',
    );
  }

  @override
  void onReady() {
    super.onReady();
    final phoneStr = HiveStorage.getPhone() ?? '';
    phone.value = MakePhoneNumer.withNumber(phoneStr);
    print("onReady===");
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose===");
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
