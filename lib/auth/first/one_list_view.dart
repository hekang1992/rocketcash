import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/first/one_list_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';

class OneListView extends GetView<OneListController> {
  OneListView({super.key}) {
    final _ = Get.put(OneListController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar('Identity authentication', () {
        Get.back();
      }),
    );
  }
}
