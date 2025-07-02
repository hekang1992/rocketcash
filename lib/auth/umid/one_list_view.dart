import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/umid/one_list_controller.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:rocketcash/routes/routes.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(
          'Identity authentication',
          onPressed: () {
            Get.back(result: 'idcard');
          },
        ),
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
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      value: 0.2,
                    ),
                  ),
                  SizedBox(height: 28),
                  authListView(controller),
                  SizedBox(height: 10.h),
                  Obx(() {
                    final model = controller.model.value;
                    final picUrl = model.maiden?.phoenix?.rpgs ?? '';
                    return idcardandFaceView(
                      '2、Please upload your identification documents',
                      picUrl.isEmpty ? 'list_phont_imge' : picUrl,
                      onTap: () {
                        if (model.maiden?.phoenix?.shock == 0) {
                          //相册相机弹窗
                          popPhotoCameraView(context, controller);
                          return;
                        }
                        if (model.maiden?.phoenix?.shock == 1) {
                          //相册相机弹窗
                          FlutterShowToast.showToast(
                            'You have successfully completed the verification.',
                          );
                          return;
                        }
                      },
                    );
                  }),
                  SizedBox(height: 10.h),
                  Obx(() {
                    final model = controller.model.value;
                    final picUrl = model.maiden?.rpgs ?? '';
                    return idcardandFaceView(
                      '3、Please upload your frontal headshot',
                      picUrl.isEmpty ? 'list_face_imge' : picUrl,
                      onTap: () async {
                        final model = controller.model.value;
                        final shock = model.maiden?.phoenix?.shock ?? 0; //id
                        final browsing = model.maiden?.browsing ?? 0; //face
                        if (shock == 0) {
                          FlutterShowToast.showToast(
                            'Kindly upload your identification photo first.',
                          );
                          return;
                        }
                        if (browsing == 1) {
                          FlutterShowToast.showToast(
                            'You have successfully completed the verification.',
                          );
                          return;
                        }
                        if (browsing == 0) {
                          //go face
                          Get.toNamed(
                            AppRoutes.faceauth,
                            arguments: {
                              'controller': controller,
                              'productID': controller.productID ?? '',
                            },
                          )?.then((onValue) {
                            if (onValue == 'face') {
                              controller.getAuthInfo(
                                controller.productID ?? '',
                              );
                            }
                          });
                        }
                        // await controller.takePhoto(
                        //   isFace: true,
                        //   imageBlock: (grand) {},
                        // );
                      },
                    );
                  }),
                  SizedBox(height: 150.h),
                  SizedBox(
                    width: 347.w,
                    height: 50.h,
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: GuideCustomerBtn(
                          title: 'Next step',
                          onPressed: () {
                            final model = controller.model.value;
                            final shock =
                                model.maiden?.phoenix?.shock ?? 0; //id
                            final browsing = model.maiden?.browsing ?? 0; //face
                            if (shock == 0) {
                              popPhotoCameraView(context, controller);
                            } else {
                              if (browsing == 1) {
                                //go productdetail
                                final controller = Get.put(
                                  IntroduceController(),
                                );
                                controller.getProductDetailToNextPage(
                                  controller.producdID,
                                );
                              } else {
                                //go face
                                Get.toNamed(
                                  AppRoutes.faceauth,
                                  arguments: {
                                    'controller': controller,
                                    'productID': controller.productID ?? '',
                                  },
                                )?.then((result) {
                                  if (result == 'face') {
                                    controller.getAuthInfo(
                                      controller.productID ?? '',
                                    );
                                  }
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
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
  return Obx(() {
    final model = controller.model.value;
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
                    model.maiden?.phoenix?.shock == 1
                        ? model.maiden?.phoenix?.mountain ?? ''
                        : controller.authStr ?? '',
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
                if (model.maiden?.phoenix?.shock == 1) {
                  //相册相机弹窗
                  FlutterShowToast.showToast(
                    'You have successfully completed the verification.',
                  );
                  return;
                } else {
                  Get.back(result: 'chosen');
                }
              },
            ),
          ),
        ],
      ),
    );
  });
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
                imageStr.contains('http')
                    ? Image.network(
                        imageStr,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/place_image_list.png',
                            width: 60.w,
                            height: 60.h,
                          );
                        },
                      )
                    : Image.asset(
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

//上传信息成功之后的确认弹窗
Widget successUmidInfo(OneListController controller, {BuildContext? context}) {
  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        height: 380.h,
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
        left: 22.sp,
        top: 35.sp,
        right: 22.sp,
        child: Row(
          children: [
            Text(
              'Confirm information',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () => Get.back(),
              child: Image.asset(
                'assets/images/canel_imge_im.png',
                width: 17.w,
                height: 17.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),

      Positioned(
        top: 72.sp,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Obx(() {
              final model = controller.photoModel.value;
              controller.namecontroller.text = model.maiden?.activate ?? '';
              return umidlistChildView(
                'Name',
                'Please Enter Your name',
                controller.namecontroller,
                null,
              );
            }),

            SizedBox(height: 11.sp),

            Obx(() {
              final model = controller.photoModel.value;
              controller.idcontroller.text = model.maiden?.reverberated ?? '';
              return umidlistChildView(
                'Id number',
                'Please Enter Your ID number',
                controller.idcontroller,
                null,
              );
            }),

            SizedBox(height: 11.sp),

            //时间
            Obx(() {
              var timea = controller.timeStr.value;
              return umidlistChildView(
                'Date of birth',
                timea.isEmpty ? 'Please select date of birth' : timea,
                null,
                context: context,
                (time) {
                  controller.timeStr.value = time;
                },
              );
            }),

            SizedBox(height: 20.sp),
            SizedBox(
              width: 347.w,
              height: 50.h,
              child: GuideCustomerBtn(
                title: 'Confirm',
                onPressed: () async {
                  final name = controller.namecontroller.text;
                  final idnumber = controller.idcontroller.text;
                  final timeStr = controller.timeStr.value;

                  final dict = {
                    'mechanical': timeStr,
                    'reverberated': idnumber,
                    'activate': name,
                    'rates': '11',
                    'glory': '1',
                    'mountain': controller.authStr ?? '',
                  };
                  await controller.safeUnmiInfo(
                    dict,
                    block: () async {
                      Get.back();
                      await controller.getAuthInfo(controller.productID ?? '');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget umidlistChildView(
  String name,
  String placeholderTitle,
  TextEditingController? controller,
  void Function(String)? timeBlock, {
  BuildContext? context,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
    child: Container(
      height: 60.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: Color(0xFFEBEDE5),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 9.h),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF666666),
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 18,
              child: name != 'Date of birth'
                  ? TextField(
                      controller: controller,
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
                    )
                  : InkWell(
                      child: SizedBox(
                        width: double.infinity,
                        height: 18.sp,
                        child: Text(
                          placeholderTitle,
                          style: TextStyle(
                            color: placeholderTitle.isEmpty
                                ? Color(0xFF999999)
                                : Color(0xFF333333),
                            fontFamily: 'inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        showPicktime(placeholderTitle, context: context, (
                          time,
                        ) {
                          timeBlock!(time);
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showPicktime(
  String defaulttime,
  void Function(String) timeBlock, {
  BuildContext? context,
}) {
  DateTime initialDate = DateFormat('dd-MM-yyyy').parse(defaulttime);
  DatePicker.showDatePicker(
    context!,
    showTitleActions: true,
    currentTime: initialDate,
    locale: LocaleType.en,
    onConfirm: (date) {
      final selectdate = DateFormat('dd-MM-yyyy').format(date);
      timeBlock(selectdate);
    },
  );
}

void popPhotoCameraView(BuildContext context, OneListController controller) {
  Get.bottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: false,
    popPhotoView(
      albulmTap: () async {
        Get.back();
        await controller.pickImageFromGallery(
          imageBlock: (grand) {
            if (grand == true) {
              Get.bottomSheet(
                enableDrag: false,
                isScrollControlled: true,
                isDismissible: false,
                successUmidInfo(controller, context: context),
              );
            }
          },
        );
      },
      cameraTap: () async {
        Get.back();
        await controller.takePhoto(
          isFace: false,
          imageBlock: (grand) {
            if (grand == true) {
              Get.bottomSheet(
                enableDrag: false,
                isScrollControlled: true,
                isDismissible: false,
                successUmidInfo(controller),
              );
            }
          },
        );
      },
    ),
  );
}
