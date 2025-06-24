import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:rocketcash/center/center_view.dart';
import 'package:rocketcash/coler/coler.dart';
import 'package:rocketcash/home/home_view.dart';
import 'package:rocketcash/main/main_controller.dart';

class MainView extends GetView<MainController> {
  final List<Widget> pages = [HomeView(), CenterView()];

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[controller.tabIndex.value],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.w),
            topRight: Radius.circular(0.w),
          ),
          child: tabbar(controller, context),
        ),
      );
    });
  }
}

Widget tabbar(MainController controller, BuildContext context) {
  return Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child: BottomNavigationBar(
      selectedItemColor: AppColors.tabselColor,
      unselectedItemColor: AppColors.tabnorColor,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/home_nor.png')),
          activeIcon: ImageIcon(AssetImage('assets/images/home_sel.png')),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/center_nor.png')),
          activeIcon: ImageIcon(AssetImage('assets/images/center_sel.png')),
          label: '',
        ),
      ],
      currentIndex: controller.tabIndex.value,
      onTap: (value) => controller.changeTabIndex(value),
    ),
  );
}
