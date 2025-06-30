import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/first/one_list_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/flutter_toast.dart';

class OneListView extends GetView<OneListController> {
  OneListView({super.key}) {
    final _ = Get.put(OneListController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar('Identity authentication', () {
          Get.back();
        }),
        body: Container(
          color: Color(0xFFEBEDE5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sp),
                  SizedBox(
                    width: 189.w,
                    child: Text(
                      textAlign: TextAlign.left,
                      'Please complete the certification',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18.sp,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      'We will protect your information security',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 12.sp,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 27.sp),
                  SizedBox(
                    width: 348.w,
                    height: 14.h,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(9.sp),
                      backgroundColor: Color(0x1A000000),
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: 0.05,
                    ),
                  ),
                  SizedBox(height: 28),
                  authListView(controller),
                  SizedBox(height: 10.h),
                  idcardandFaceView(
                    '2、Please upload your identification documents',
                    'list_phont_imge',
                    onTap: () {
                      Get.bottomSheet(
                        enableDrag: false,
                        isScrollControlled: true,
                        isDismissible: false,
                        popPhotoView(
                          albulmTap: () async {
                            Get.back();
                            await controller.pickImageFromGallery();
                          },
                          cameraTap: () async {
                            Get.back();
                            await controller.takePhoto(isFace: false);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  idcardandFaceView(
                    '3、Please upload your frontal headshot',
                    'list_face_imge',
                    onTap: () async {
                      await controller.takePhoto(isFace: true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget authListView(OneListController controller) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1、The identification document you have chosen',
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 9.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9.sp),
          ),
          height: 40.h,
          child: InkWell(
            child: Row(
              children: [
                SizedBox(width: 18.w),
                Text(
                  controller.authStr ?? '',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/right_image.png',
                  width: 14.w,
                  height: 14.h,
                ),
                SizedBox(width: 18.w),
              ],
            ),
            onTap: () {
              Get.back(result: 'chosen');
            },
          ),
        ),
      ],
    ),
  );
}

Widget idcardandFaceView(
  String title,
  String imageStr, {
  required VoidCallback onTap,
}) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 9.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9.sp),
          ),
          height: 80.h,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                SizedBox(width: 18.w),
                Image.asset(
                  'assets/images/$imageStr.png',
                  width: 60.w,
                  height: 60.h,
                ),
                Spacer(),
                Image.asset(
                  'assets/images/black_gr_image_btn.png',
                  width: 105.w,
                  height: 36.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 18.w),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget popPhotoView({
  required VoidCallback albulmTap,
  required VoidCallback cameraTap,
}) {
  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        height: 260.h,
        decoration: BoxDecoration(
          color: Color(0xFFAAD301),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(9.sp),
            topRight: Radius.circular(9.sp),
          ),
        ),
      ),
      Positioned(
        top: 10.sp,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.sp),
              topRight: Radius.circular(9.sp),
            ),
          ),
        ),
      ),
      Positioned(
        top: 22.sp,
        right: 20.sp,
        child: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/images/canel_imge_im.png',
            width: 17.w,
            height: 17.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 64.sp,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: albulmTap,
              child: Image.asset(
                'assets/images/ll_ph_igme.png',
                width: 160.w,
                height: 91.h,
              ),
            ),
            InkWell(
              onTap: cameraTap,
              child: Image.asset(
                'assets/images/ll_cam_imge.png',
                width: 160.w,
                height: 91.h,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 35.sp,
        child: SizedBox(
          width: 348.w,
          height: 50.h,
          child: GuideCustomerBtn(
            title: 'Cancel',
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
    ],
  );
}
