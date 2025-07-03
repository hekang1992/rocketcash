import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/guide/guide_controller.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/hive/save_info.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({super.key});
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final List<Widget> pages = [
      Stack(
        children: [
          Image.asset(
            'assets/images/list_guide_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          getGuideView(
            context,
            'list_one_bg',
            'Easy borrowing, just a touch away',
            'Quick application, ultra-fast loan disbursement, no more waiting for capital needs.',
            'la_one_imge',
            'la_two_image',
            24,
            5,
            pageController,
          ),
        ],
      ),
      Stack(
        children: [
          Image.asset(
            'assets/images/list_guide_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          getGuideView(
            context,
            'list_next_bg',
            'Safe lending starts here',
            'Strict encryption, compliant operation, your privacy is carefully protected by us.',
            'la_two_image',
            'la_one_imge',
            24,
            5,
            pageController,
          ),
        ],
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: controller.changePage,
        children: pages,
      ),
    );
  }
}

Widget getGuideView(
  BuildContext context,
  String imageStr,
  String title,
  String desctitle,
  String bigImageStr,
  String cycleImageStr,
  double imageOneWidth,
  double imageTwoWeight,
  PageController? vc,
) {
  return Positioned(
    left: 0,
    right: 0,
    top: MediaQuery.of(context).padding.top + 70.h,
    child: Column(
      children: [
        Image.asset('assets/images/$imageStr.png', width: 302.w, height: 302.h),
        SizedBox(
          width: 250.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 9.h),
        SizedBox(
          width: 300.w,
          child: Text(
            desctitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$bigImageStr.png',
              width: imageOneWidth.w,
              height: 5.h,
            ),
            SizedBox(width: 2),
            Image.asset(
              'assets/images/$cycleImageStr.png',
              width: imageTwoWeight.w,
              height: 5.h,
            ),
          ],
        ),
        SizedBox(height: 42.h),
        SizedBox(
          width: 301.w,
          height: 49.h,
          child: GuideCustomerBtn(
            title: 'Next step',
            onPressed: () {
              final controller = Get.put(GuideController());
              if (controller.index.value == 0) {
                vc?.animateToPage(
                  1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              } else {
                HiveStorage.saveClick("1");
                Get.offAllNamed('/login');
              }
            },
          ),
        ),
      ],
    ),
  );
}
