import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/home/home_view.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/routes/routes.dart';

class IntroduceView extends GetView<IntroduceController> {
  IntroduceView({super.key}) {
    final _ = Get.put(IntroduceController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar(
          'Identity Authentication',
          onPressed: () {
            Get.back();
          },
        ),
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
                      Get.toNamed(
                        AppRoutes.webpage,
                        parameters: {'pageUrl': 'https://www.apple.com.cn'},
                      );
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
                      final transformedModel = model.maiden?.transformed ?? [];
                      return authListView(transformedModel[index], (
                        supermy,
                        shock,
                      ) async {
                        switch (supermy) {
                          case 'beatvoicaeious': //人脸认证信息
                            bottomSheetInfo(controller);
                            break;
                          case 'gymnaproof': //个人信息
                            shock == '1'
                                ? Get.toNamed(AppRoutes.personalauth)
                                : controller.getProductDetailToNextPage(
                                    controller.producdID,
                                    block: (p0) {
                                      if (p0 == 'beatvoicaeious') {
                                        bottomSheetInfo(controller);
                                      }
                                    },
                                  );
                            break;
                          case 'tarsshoratitor': //工作信息
                            break;
                          case 'vilaature': //联系人信息
                            break;
                          case 'speaakward': //银行信息
                            break;
                          default:
                        }
                      });
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bottomSheetInfo(IntroduceController controller) async {
  final model = controller.authmodel.value;
  if (model.maiden?.phoenix?.shock == 1) {
    Get.toNamed(
      AppRoutes.oneauth,
      parameters: {
        'auth': model.maiden?.phoenix?.mountain ?? '',
        'productID': controller.producdID,
      },
    )?.then((onValue) {
      if (onValue == 'idcard') {
        controller.getAuthInfo(controller.producdID);
        return onValue;
      }
    });
  } else {
    await controller.getUmidInfo();
    Get.bottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: false,
      Obx(() {
        final model = controller.listModel.value;
        return umidListView(
          model.maiden?.keyboard ?? [],
          onTap: () {
            Get.back();
          },
        );
      }),
    );
  }
}

//headView
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

//listView
Widget authListView(
  TransformedModel model,
  void Function(String, String) onTap,
) {
  var imageStr = '';
  final shock = model.shock ?? 0;
  imageStr = shock == 1 ? 'list_comp_image' : 'list_no_iamge';
  return InkWell(
    child: SizedBox(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 13.sp, bottom: 44.sp, right: 13.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9.sp),
              ),
            ),
          ),
          Positioned(
            top: 20.sp,
            child: Image.network(
              model.lap ?? '',
              width: 72.sp,
              height: 72.sp,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 100.sp,
            child: Text(
              model.appeared ?? '',
              style: TextStyle(
                color: Color(0xFF333333),
                fontFamily: 'inter',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            top: 125.sp,
            child: Image.asset(
              'assets/images/$imageStr.png',
              width: 40.w,
              height: 40.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      onTap(model.supermysterious ?? '', shock.toString());
    },
  );
}

Widget umidListView(
  List<KeyboardModel> modelArray, {
  required VoidCallback onTap,
}) {
  return Container(
    width: double.infinity,
    height: 450.h,
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
        Padding(
          padding: EdgeInsets.only(top: 22.sp),
          child: Row(
            children: [
              SizedBox(width: 22.w),
              Text(
                'Select Document',
                style: TextStyle(
                  fontFamily: 'inter',
                  color: Color(0xFF333333),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              InkWell(onTap: onTap, child: Icon(Icons.cancel)),
              SizedBox(width: 20.sp),
            ],
          ),
        ),
        Positioned(
          top: 60.sp,
          left: 0,
          right: 0,
          bottom: 0,
          child: ListView.builder(
            itemCount: modelArray.length,
            itemBuilder: (content, index) {
              return unlistViwe(modelArray[index], (auth) async {
                final controller = Get.put(IntroduceController());
                Get.back();
                await Future.delayed(Duration(milliseconds: 250));
                Get.toNamed(
                      AppRoutes.oneauth,
                      parameters: {
                        'auth': auth,
                        'productID': controller.producdID,
                      },
                    )
                    ?.then((result) {
                      if (result == 'chosen') {
                        bottomSheetInfo(controller);
                      }
                      return result;
                    })
                    .then((onValue) {
                      if (onValue == 'idcard') {
                        controller.getAuthInfo(controller.producdID);
                      }
                      return onValue;
                    });
              });
            },
          ),
        ),
      ],
    ),
  );
}

Widget unlistViwe(KeyboardModel model, void Function(String) onTap) {
  return InkWell(
    onTap: () {
      onTap(model.activate ?? '');
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: 20.sp),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Text(
            model.activate ?? '',
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/right_image.png',
            width: 15.w,
            height: 15.h,
          ),
          SizedBox(width: 20.w),
        ],
      ),
    ),
  );
}
