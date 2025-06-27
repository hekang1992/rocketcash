import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/instance_manager.dart';
import 'package:rocketcash/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key}) {
    final _ = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.pink,
        child: Stack(
          children: [
            // 顶部背景图
            Image.asset(
              'assets/images/home_head_imge.png',
              width: double.infinity,
              height: 310.h,
              fit: BoxFit.cover,
            ),

            // 悬浮客服按钮
            Positioned(
              top: MediaQuery.of(context).padding.top + 5.h,
              right: 24.w,
              child: Image.asset(
                'assets/images/home_kef_imge.png',
                width: 37.w,
                height: 37.h,
              ),
            ),

            // 滚动区域
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 32.sp,
                      ),
                      child: Image.asset(
                        'assets/images/green_home_image.png',
                        width: 130.w,
                        height: 17.h,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.sp, top: 14.sp),
                          child: SizedBox(
                            height: 40.h,
                            width: 120.w,
                            child: Obx(() {
                              final rates =
                                  controller
                                      .model
                                      .value
                                      .maiden
                                      ?.greatly
                                      ?.rates ??
                                  '';
                              final desc = rates == 'outsidkeot'
                                  ? controller
                                            .model
                                            .value
                                            .maiden
                                            ?.greatly
                                            ?.tickets
                                            ?.first
                                            .ticket ??
                                        ''
                                  : '';
                              return Text(
                                desc,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }),
                          ),
                        ),
                        Image.asset(
                          'assets/images/up_image_home.png',
                          width: 34.w,
                          height: 34.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.sp),
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Image.asset(
                          'assets/images/home_black_image.png',
                          width: 229.w,
                          height: 54.h,
                          fit: BoxFit.cover,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 38.w),
                            Obx(
                              () => Text(
                                controller
                                        .model
                                        .value
                                        .maiden
                                        ?.greatly
                                        ?.tickets
                                        ?.first
                                        .costs ??
                                    '',
                                style: TextStyle(
                                  color: Color(0xFFD3F157),
                                  fontFamily: 'inter',
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
