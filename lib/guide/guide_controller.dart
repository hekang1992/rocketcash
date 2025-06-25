import 'package:get/get.dart';

class GuideController extends GetxController {
  var index = 0.obs;

  changePage(int value) {
    index.value = value;
  }
}
