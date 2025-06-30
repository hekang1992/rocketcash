import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/personan/personal_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/routes/routes.dart';

class PersonalView extends GetView<PersonalController> {
  PersonalView({super.key}) {
    final _ = Get.put(PersonalController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar(
          'Identity Authentication',
          onPressed: () {
            Get.until((route) {
              final currentRoute = route.settings.name?.split('?').first;
              final introduce = AppRoutes.introduce;
              return currentRoute == introduce;
            });
            final controller = Get.put(IntroduceController());
            controller.getProductDetailInfo(controller.producdID);
          },
        ),
      ),
    );
  }
}
