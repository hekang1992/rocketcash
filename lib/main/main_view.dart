import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:rocketcash/center/center_view.dart';
import 'package:rocketcash/other/coler/coler.dart';
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
        bottomNavigationBar: tabbar(controller, context),
      );
    });
  }
}

Widget tabbar(MainController controller, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0.sp),
        topRight: Radius.circular(0.sp),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 9.sp,
          offset: Offset(0, -1),
        ),
      ],
    ),
    child: Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        selectedItemColor: AppColors.tabselColor,
        unselectedItemColor: AppColors.tabnorColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home_nor.png',
              width: 45.w,
              height: 45.h,
              fit: BoxFit.contain,
            ),
            activeIcon: Image.asset(
              'assets/images/home_sel.png',
              width: 45.w,
              height: 45.h,
              fit: BoxFit.contain,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/center_nor.png',
              width: 45.w,
              height: 45.h,
              fit: BoxFit.contain,
            ),
            activeIcon: Image.asset(
              'assets/images/center_sel.png',
              width: 45.w,
              height: 45.h,
              fit: BoxFit.contain,
            ),
            label: '',
          ),
        ],
        currentIndex: controller.tabIndex.value,
        onTap: (value) => controller.changeTabIndex(value),
      ),
    ),
  );
}
