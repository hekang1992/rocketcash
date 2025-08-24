import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/login/login_controller.dart';
import 'package:rocketcash/other/coler/coler.dart';
import 'package:rocketcash/routes/routes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_bg_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.sp,
                top: MediaQuery.of(context).padding.top + 40.sp,
              ),
              child: Image.asset(
                'assets/images/wel_con_image.png',
                width: 207.w,
                height: 84.h,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top + 65.h,
              child: Column(
                children: [
                  SizedBox(height: 21.h + 18.h),
                  SizedBox(height: 98.h),
                  SizedBox(
                    width: 320.w,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('+63'),
                              SizedBox(width: 12.sp),
                              Container(
                                width: 1,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                  color: Color(0xff8DCE00),
                                ),
                              ),
                              SizedBox(width: 12.sp),
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: controller.phonecontroller,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: 'Enter mobile number',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF999999),
                                      fontFamily: 'inter',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.sp),
                          Image.asset('assets/images/dot_linge_login.png'),
                        ],
                      ),
                    ),
                    // phoneListView(
                    //   'Mobile phone number (+63)',
                    //   'login_phone_imge',
                    //   'Please enter your mobile phone number',
                    //   260,
                    //   false,
                    //   controller.phonecontroller,
                    //   null,
                    //   null,
                    // ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 320.w,
                    child: phoneListView(
                      '',
                      'login_code_imge',
                      'Please enter the verification code',
                      225,
                      true,
                      controller.codecontroller,
                      controller.secondsLeft, // 传入倒计时变量
                      () {
                        controller.tolcodeinfo(controller.phonecontroller.text);
                      },
                    ),
                  ),
                  SizedBox(height: 47.h),
                  SizedBox(
                    width: 320.w,
                    height: 50.h,
                    child: GuideCustomerBtn(
                      title: 'Log in',
                      onPressed: () {
                        controller.tologininfo(
                          phone: controller.phonecontroller.text,
                          rtp: controller.codecontroller.text,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: 280.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => GestureDetector(
                            behavior:
                                HitTestBehavior.translucent, // 👈 必加：确保空白区域也响应
                            onTap: controller.clickManagement,
                            child: Container(
                              padding: EdgeInsets.only(
                                right: 5.sp,
                                bottom: 10.sp,
                              ),
                              child: Image.asset(
                                controller.isClick.value
                                    ? 'assets/images/man_sel_image.png'
                                    : 'assets/images/man_nor_image.png',
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontFamily: 'inter',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Read understand and agree ',
                                ),
                                TextSpan(
                                  text: '"Privacy Policy"',
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                        AppRoutes.webpage,
                                        parameters: {
                                          'pageUrl': '$h5Host/blueberryGi',
                                        },
                                      );
                                    },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: '"Loan Terms"',
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                        AppRoutes.webpage,
                                        parameters: {
                                          'pageUrl': '$h5Host/saladNutmeg',
                                        },
                                      );
                                    },
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget phoneListView([
  String title = '',
  String? imageStr,
  String placeholderTitle = '',
  double? textwidth,
  bool? isshow,
  TextEditingController? controller,
  RxInt? secondsLeft,
  VoidCallback? onPressed,
]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'inter',
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      Row(
        children: [
          // Image.asset('assets/images/$imageStr.png', width: 17.w, height: 17.h),
          // SizedBox(width: 10.w),
          SizedBox(
            width: textwidth?.w,
            height: 20.h,
            child: Align(
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: placeholderTitle,
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontFamily: 'inter',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 25.sp),
          if (isshow == true && secondsLeft != null)
            Obx(
              () => SizedBox(
                width: 60.w,
                height: 25.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // 去掉默认 padding
                    backgroundColor: Color(0xFFFF962D),
                    foregroundColor: Colors.white, // ✅ 设置文字颜色
                  ),
                  onPressed: secondsLeft.value == 0 ? onPressed : null,
                  child: Text(
                    secondsLeft.value == 0 ? "send" : "${secondsLeft.value}s",
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      SizedBox(height: 10.h),
      Container(width: 320.w, height: 1, color: Color(0xFFB7C67D)),
    ],
  );
}
