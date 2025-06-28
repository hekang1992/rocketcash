import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/flutter_toast.dart';

class IntroduceView extends GetView<IntroduceController> {
  IntroduceView({super.key}) {
    final _ = Get.put(IntroduceController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar('Identity Authentication', () {
        Get.back();
      }),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFEBEDE5),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 21.h),
              oneView(),
              SizedBox(height: 10.h),
              SizedBox(
                width: 347.w,
                child: GuideCustomerBtn(
                  title: 'Start the authentication',
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 10.h),

              Padding(
                padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                child: InkWell(
                  child: RichText(
                    textAlign: TextAlign.center, // 关键设置
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'We follow strict operational procedures and quality standards, as detailed in our',
                          style: TextStyle(
                            fontFamily: 'inter',
                            color: Color(0xFF999999),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " Privacy Policy",
                          style: TextStyle(
                            fontFamily: 'inter',
                            color: Color(0xFF333333),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    FlutterShowToast.showToast('msg');
                  },
                ),
              ),
              SizedBox(height: 10.h),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // 禁止 GridView 自身滚动
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0, //宽高比为1时，子widget
                ),
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget oneView() {
  return Stack(
    children: [
      Image.asset(
        'assets/images/one_iam_oige.png',
        width: 347.w,
        height: 210.h,
      ),
    ],
  );
}
