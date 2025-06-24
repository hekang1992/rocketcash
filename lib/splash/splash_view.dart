import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:rocketcash/hive/save_info.dart';
import 'package:rocketcash/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});
  final _ = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/launch_image.png', fit: BoxFit.fill),
      ),
    );
  }
}
