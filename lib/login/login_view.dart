import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/login/login_controller.dart';

class LoginView extends GetView<GetxController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final loginController = Get.put(LoginController());
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
                    ),
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 320.w,
                    child: phoneListView(
                      'Verification code',
                      'login_code_imge',
                      'Please enter the verification code',
                    ),
                  ),
                  SizedBox(height: 47.h),
                  GuideCustomerBtn(
                    onPressed: () {
                      loginController.loginInfo();
                    },
                    title: 'Embark on the RocketCash journey',
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
                            onTap: loginController.clickManagement,
                            child: Container(
                              padding: EdgeInsets.only(
                                right: 5.sp,
                                bottom: 10.sp,
                              ),
                              child: Image.asset(
                                loginController.isClick.value
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
                                fontFamily: 'Inter',
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
                                      print('Privacy---Privacy');
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
                                      print('Terms---Terms');
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
]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
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
            width: 260.w,
            height: 20.h,
            child: Align(
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: placeholderTitle,
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontFamily: 'Inter',
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
      Container(width: 295.w, height: 1, color: Color(0xFFB7C67D)),
    ],
  );
}
