import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/center/center_list_controller.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/other/coler/coler.dart';
import 'package:rocketcash/routes/routes.dart';

class CenterListView extends GetView<CenterListController> {
  const CenterListView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar(
          'Setting',
          onPressed: () {
            Get.back();
          },
        ),
        body: Container(
          width: double.infinity,
          color: Color(0xFFEBEDE5),
          child: Column(
            children: [
              centerListLogoutView(
                imageStr: 'setting_one_image',
                title: 'Loan Terms',
                onTap: () {
                  Get.toNamed(
                    AppRoutes.webpage,
                    parameters: {'pageUrl': '$h5Host/saladNutmeg'},
                  );
                },
              ),
              centerListLogoutView(
                imageStr: 'setting_one_image',
                title: 'Privacy Policy',
                onTap: () {
                  Get.toNamed(
                    AppRoutes.webpage,
                    parameters: {'pageUrl': '$h5Host/blueberryGi'},
                  );
                },
              ),
              centerListLogoutView(
                imageStr: 'setting_two_imge',
                title: 'Account cancellation',
                onTap: () {
                  Get.bottomSheet(
                    enableDrag: false,
                    isScrollControlled: true,
                    isDismissible: false,
                    centerlistdeleteView(controller.getPhone(), () {
                      Get.back();
                    }),
                  );
                },
              ),
              SizedBox(height: 34.h),
              SizedBox(
                width: 345.w,
                height: 50.h,
                child: GuideCustomerBtn(
                  title: 'Exit the account',
                  onPressed: () {
                    Get.dialog(
                      barrierDismissible: false,
                      useSafeArea: false,
                      Center(
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/logout_image.png',
                              width: 340.w,
                              height: 275.h,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                child: SizedBox(width: 40.w, height: 40.h),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                child: SizedBox(width: 160.w, height: 100.h),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                child: SizedBox(width: 160.w, height: 100.h),
                                onTap: () {
                                  controller.logout();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//删除账号
Widget centerlistdeleteView(String phone, VoidCallback onTap) {
  final controller = Get.put(CenterListController());
  return Container(
    width: double.infinity,
    height: 502.h,
    decoration: BoxDecoration(
      color: Color(0xFFAAD301),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(9.sp),
        topRight: Radius.circular(9.sp),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          top: 10.sp,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.sp),
                topRight: Radius.circular(9.sp),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.sp, top: 22.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 241.w,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xFF333333),
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: 'Account cancellation',
                            style: TextStyle(color: Color(0xFFD37401)),
                          ),
                          TextSpan(text: ' involves the following risks.'),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(onTap: onTap, child: Icon(Icons.cancel)),
                  SizedBox(width: 20.sp),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 9.sp),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color(0xFFD37401),
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'Current account:',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(text: ' $phone'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Center(
              child: Container(
                width: 340.w,
                height: 272.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                // child: descInfoView(),
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return descInfoView(
                        title: controller.titles[index],
                        desc: controller.descs[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 12.sp),
                child: Text(
                  textAlign: TextAlign.center,
                  'This operation will permanently delete the account and it cannot be restored',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFD30C01),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 347.w,
                height: 49.h,
                child: GuideCustomerBtn(
                  title: 'I want to Account cancellation',
                  color: Color(0xFFD37401),
                  onPressed: () {
                    controller.deleteInfo();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//退出登录
Widget centerListLogoutView({
  String? imageStr,
  String title = '',
  VoidCallback? onTap,
}) {
  return Container(
    padding: EdgeInsets.only(top: 12.sp, left: 15.sp, right: 15.sp),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.sp),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 40.h,
        child: Row(
          children: [
            SizedBox(width: 19.w),
            Image.asset(
              'assets/images/$imageStr.png',
              width: 19.w,
              height: 19.h,
            ),
            SizedBox(width: 13.w),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/center_right_image.png',
              width: 15.w,
              height: 15.h,
            ),
            SizedBox(width: 18.w),
          ],
        ),
      ),
    ),
  );
}

//list
Widget descInfoView({required String title, required String desc}) {
  return Padding(
    padding: EdgeInsets.only(left: 13.sp, top: 15.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/centerlist_cycle_image.png',
              width: 12.w,
              height: 12.h,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.sp),
        Padding(
          padding: EdgeInsets.only(left: 22.sp), // 对应你原来的 left: 35.sp
          child: SizedBox(
            width: 271.w,
            child: Text(
              desc,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget getAppBar(String? title, {VoidCallback? onPressed}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: EdgeInsets.all(8.sp),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset('assets/images/back_btn_image.png'),
      ),
    ),
    title: Text(
      title ?? '',
      style: TextStyle(
        fontFamily: 'inter',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
