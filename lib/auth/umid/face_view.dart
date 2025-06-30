import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rocketcash/auth/umid/face_controller.dart';
import 'package:rocketcash/auth/umid/one_list_controller.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/home/home_controller.dart';

class FaceView extends GetView<FaceController> {
  const FaceView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(
          'Identity authentication',
          onPressed: () {
            Get.back(result: 'face');
          },
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFEBEDE5),
          child: Padding(
            padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35.h),
                  Image.asset(
                    'assets/images/centername_logo.png',
                    width: 72.w,
                    height: 21.h,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Upload Face',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Please upload your frontal headshot',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF999999),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Center(
                    child: Image.asset(
                      'assets/images/fac_ico_image.png',
                      width: 132.w,
                      height: 132.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    '*Shooting Instructions',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD37401),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Image.asset(
                      'assets/images/dis_imge_c.png',
                      width: 310.w,
                      height: 68.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Image.asset(
                      'assets/images/desc_fa_imge_f.png',
                      width: 340.w,
                      height: 127.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 74.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/dun_imge_fad.png',
                        width: 12.w,
                        height: 12.w,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'RocketCash Ensure your information security in real time',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: 347.w,
                    height: 50.h,
                    child: GuideCustomerBtn(
                      title: 'Upload',
                      onPressed: () {
                        final arguments = Get.arguments as Map<String, dynamic>;
                        final controller =
                            arguments['controller'] as OneListController;
                        final productID = arguments['productID'] as String;
                        controller.takePhoto(
                          isFace: true,
                          imageBlock: (grand) {
                            if (grand == true) {
                              //go product
                              final controller = Get.put(IntroduceController());
                              controller.getProductDetailToNextPage(productID);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
