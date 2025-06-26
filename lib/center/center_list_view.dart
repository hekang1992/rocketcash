import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rocketcash/center/center_list_controller.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';

class CenterListView extends GetView<CenterListController> {
  const CenterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset('assets/images/back_btn_image.png'),
          ),
        ),
        title: Text(
          'Setting',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
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
                Fluttertoast.showToast(msg: '1111');
              },
            ),
            centerListLogoutView(
              imageStr: 'setting_one_image',
              title: 'Privacy Policy',
              onTap: () {
                Fluttertoast.showToast(msg: '2222');
              },
            ),
            centerListLogoutView(
              imageStr: 'setting_two_imge',
              title: 'Account cancellation',
              onTap: () {
                Get.bottomSheet(
                  centerlistdeleteView(controller.getPhone(), () {
                    Get.back();
                  }),
                  enableDrag: false,
                  isDismissible: false,
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
    );
  }
}

Widget centerlistdeleteView(String phone, VoidCallback onTap) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: 542.h,
        decoration: BoxDecoration(
          color: Color(0xFFAAD301),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(9.sp),
            topRight: Radius.circular(9.sp),
          ),
        ),
      ),
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
            padding: EdgeInsets.only(left: 18.sp, top: 32.sp),
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
                        fontFamily: 'Inter',
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
                  fontFamily: 'Inter',
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
        ],
      ),
    ],
  );
}

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
                fontFamily: 'Inter',
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
