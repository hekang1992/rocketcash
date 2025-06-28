import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/center/center_controller.dart';
import 'package:rocketcash/coler/coler.dart';
import 'package:rocketcash/routes/routes.dart';

class CenterView extends GetView<CenterController> {
  const CenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            centerHeadView(context),
            centerListView(),
            SizedBox(height: 20.h),
            moreFunctionView(),
          ],
        ),
      ),
    );
  }
}

Widget centerHeadView(BuildContext context) {
  final controller = Get.put(CenterController());
  return Stack(
    children: [
      Image.asset(
        'assets/images/centerbg_image.png',
        width: double.infinity,
        height: 304.h,
        fit: BoxFit.fill,
      ),
      Positioned(
        top: MediaQuery.of(context).padding.top + 10.h,
        left: 15.w,
        child: Image.asset(
          'assets/images/centername_logo.png',
          width: 143.w,
          height: 42.h,
        ),
      ),
      Positioned(
        bottom: 0, // 紧贴底部
        left: 0, // 水平居中：通过 left/right 约束
        right: 0,
        child: Align(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/green_bg.png',
                width: 348.w,
                height: 144.h,
                fit: BoxFit.fill,
              ),
              Positioned(bottom: 18.h, left: 0, right: 0, child: serviceView()),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 55.h,
        left: 0, // 水平居中：通过 left/right 约束
        right: 0,
        child: Align(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/centerpeople_imge.png',
                width: 348.w,
                height: 144.h,
                fit: BoxFit.fill,
              ),
              Positioned.fill(
                top: 45.sp,
                child: Center(
                  child: Obx(
                    () => Text(
                      controller.phone.value,
                      style: TextStyle(
                        fontFamily: 'inter',
                        color: Colors.black, // 视情况设置颜色
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget serviceView() {
  var controller = Get.put(CenterController());
  return GestureDetector(
    onTap: () {
      controller.clickTap();
    },
    child: InkWell(
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Image.asset(
            'assets/images/service_keimge.png',
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(width: 10.w),
          Text(
            'Customer service',
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blacktextColor,
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/right_sp_image.png',
            width: 16.w,
            height: 16.h,
          ),
          SizedBox(width: 18.w),
        ],
      ),
      onTap: () {
        Get.toNamed(
          AppRoutes.webpage,
          parameters: {'pageUrl': 'https://www.apple.com.cn'},
        );
      },
    ),
  );
}

Widget centerListView() {
  return SizedBox(
    width: double.infinity,
    height: 208.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 46.h,
          child: Row(
            children: [
              SizedBox(width: 15.sp),
              Text(
                'My order',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'inter',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/right_image.png',
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 15.w),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              orderListImageView('under_way_image.png', 'Under Way'),
              orderListImageView('repay_ment_iamge.png', 'Repayment'),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFDFEFFF),
                borderRadius: BorderRadius.circular(9.sp),
              ),
              child: Row(
                children: [
                  SizedBox(width: 18.sp),
                  Image.asset(
                    'assets/images/list_imge_icon.png',
                    width: 22.sp,
                    height: 22.sp,
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    'Finish',
                    style: TextStyle(
                      color: Color(0xFF4EA7FF),
                      fontFamily: 'inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/images/white_icon_right.png',
                    width: 16.sp,
                    height: 16.sp,
                  ),
                  SizedBox(width: 18.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget orderListImageView(String bgImageStr, String title) {
  return Stack(
    children: [
      Image.asset('assets/images/$bgImageStr', width: 165.w, height: 75.h),
      Padding(
        padding: EdgeInsets.only(top: 15.h, left: 18.w), // 设置上边距和左边距
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xFF7C58FF),
          ),
        ),
      ),
    ],
  );
}

Widget moreFunctionView() {
  return SizedBox(
    width: double.infinity,
    height: 200.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.sp),
          child: SizedBox(
            width: 200.w,
            height: 30.h,
            child: Text(
              'More',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(9.sp),
            ),
            child: Column(
              children: [
                InkWell(
                  child: SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        Image.asset(
                          'assets/images/list_one_image.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Our official website',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/right_image.png',
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 18.w),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.webpage,
                      parameters: {'pageUrl': 'https://www.apple.com/it'},
                    );
                  },
                ),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.centerlist),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        Image.asset(
                          'assets/images/list_two_image.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/right_image.png',
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 18.w),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
