import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/coler/coler.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/home/home_view.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/response_model.dart';

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
              Obx(() {
                final model = controller.model.value;
                return oneView(model);
              }),
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
              Obx(() {
                final model = controller.model.value;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // 禁止 GridView 自身滚动
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0, //宽高比为1时，子widget
                  ),
                  itemCount: model.maiden?.transformed?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(color: getRandomColorWithAlpha());
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget oneView(BaseModel model) {
  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Image.asset(
        'assets/images/one_iam_oige.png',
        width: 347.w,
        height: 210.h,
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/images/ll_ad_image.png',
          width: 170.w,
          height: 43.h,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: 9.sp,
        left: 20.sp,
        child: Row(
          children: [
            Image.asset(
              'assets/images/login_icon_image.png',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 9.sp),
            Image.asset(
              'assets/images/appim_ge_ii.png',
              width: 92.w,
              height: 16.h,
            ),
          ],
        ),
      ),
      Positioned(
        top: 52.sp,
        child: Column(
          children: [
            Text(
              model.maiden?.subtle?.columnText?.tag1?.appeared ?? '',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 5.sp),
            Text(
              model.maiden?.subtle?.columnText?.tag1?.threat ?? '',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 5.h),
            Stack(
              children: [
                Image.asset(
                  'assets/images/indfa_iamge_dsas.png',
                  width: 311.w,
                  height: 68.h,
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      itemListView(
                        imagestr: 'item_list_image',
                        title:
                            model.maiden?.subtle?.columnText?.tag2?.appeared ??
                            '',
                        desc:
                            model.maiden?.subtle?.columnText?.tag2?.threat ??
                            '',
                      ),
                      itemListView(
                        imagestr: 'rate_list_image',
                        title: model.maiden?.subtle?.termDesc ?? '',
                        desc: model.maiden?.subtle?.screen ?? '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
