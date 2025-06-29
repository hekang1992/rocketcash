import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/login/login_controller.dart';
import 'package:rocketcash/routes/routes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top + 25.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login_icon_image.png',
                    width: 88.w,
                    height: 88.h,
                  ),
                  SizedBox(height: 21.h),
                  Image.asset(
                    'assets/images/name_icon_image.png',
                    width: 136.w,
                    height: 30.h,
                  ),
                  SizedBox(height: 38.h),
                  SizedBox(
                    width: 320.w,
                    child: phoneListView(
                      'Mobile phone number (+63)',
                      'login_phone_imge',
                      'Please enter your mobile phone number',
                      260,
                      false,
                      controller.phonecontroller,
                      null,
                      null,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 320.w,
                    child: phoneListView(
                      'Verification code',
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
                      title: 'Embark on the RocketCash journey',
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
                                const TextSpan(text: 'I have read and agreed '),
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
                                          'pageUrl': 'https://www.apple.com.cn',
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
                                          'pageUrl': 'https://www.baidu.com',
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
          Image.asset('assets/images/$imageStr.png', width: 17.w, height: 17.h),
          SizedBox(width: 10.w),
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
          if (isshow == true && secondsLeft != null)
            Obx(
              () => SizedBox(
                width: 60.w,
                height: 25.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // 去掉默认 padding
                    backgroundColor: Color(0xFFDFE8BA),
                    foregroundColor: Colors.black, // ✅ 设置文字颜色
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
