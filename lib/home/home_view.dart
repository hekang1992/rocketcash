import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/home/home_controller.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key}) {
    final _ = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEBEDE5),
        child: Stack(
          children: [
            // 顶部背景图
            Image.asset(
              'assets/images/home_head_imge.png',
              width: MediaQuery.of(context).size.width,
              height: 310.h,
              fit: BoxFit.cover,
            ),

            SmartRefresher(
              physics: BouncingScrollPhysics(),
              controller: controller.refreshController,
              onRefresh: () {
                controller.getHomeInfo();
              },
              child: ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 32.sp,
                  bottom: 10.sp,
                ),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/green_home_image.png',
                      width: 130.w,
                      height: 17.h,
                    ),
                  ),
                  SizedBox(height: 14.sp),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 13.sp),
                        child: SizedBox(
                          height: 40.h,
                          width: 120.w,
                          child: Obx(() {
                            final rates =
                                controller.model.value.maiden?.greatly?.rates ??
                                '';
                            final desc = rates == 'outsidkeot'
                                ? controller
                                          .model
                                          .value
                                          .maiden
                                          ?.greatly
                                          ?.tickets
                                          ?.first
                                          .ticket ??
                                      ''
                                : '';
                            return Text(
                              desc,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }),
                        ),
                      ),
                      Image.asset(
                        'assets/images/up_image_home.png',
                        width: 34.w,
                        height: 34.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),
                  Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Image.asset(
                        'assets/images/home_black_image.png',
                        width: 229.w,
                        height: 54.h,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 38.w),
                          Obx(
                            () => Text(
                              controller
                                      .model
                                      .value
                                      .maiden
                                      ?.greatly
                                      ?.tickets
                                      ?.first
                                      .costs ??
                                  '',
                              style: TextStyle(
                                color: Color(0xFFD3F157),
                                fontFamily: 'inter',
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  Obx(() {
                    final model = controller.model.value;
                    return itemRateView(model: model);
                  }),
                  SizedBox(height: 13.5.sp),
                  Padding(
                    padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                    child: Obx(() {
                      final model = controller.model.value;
                      return GuideCustomerBtn(
                        color: Color(0xFFAAD301),
                        titlecolor: Color(0xFF333333),
                        title: 'Apply for funding',
                        onPressed: () {
                          int producdID =
                              model.maiden?.greatly?.tickets?.first.three ?? 0;
                          controller.applyProduct(producdID.toString());
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 13.h),
                  Obx(() {
                    final model = controller.model.value;
                    List<String> images = [];
                    for (TicketsModel model1
                        in model.maiden?.points?.tickets ?? []) {
                      images.add(model1.trolled ?? '');
                    }
                    return CarouselSlider(
                      options: CarouselOptions(
                        disableCenter: true,
                        height: 84.h,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                      ),
                      items: images.map((url) {
                        return Padding(
                          padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(color: Colors.pink);
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(height: 10.h),
                  loanitemsListView(),
                  SizedBox(height: 18.h),
                  appintrodueView(),
                  SizedBox(height: 18.h),
                  footerView(),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              right: 25.sp,
              child: InkWell(
                child: Image.asset(
                  'assets/images/home_kef_imge.png',
                  width: 37.w,
                  height: 37.h,
                ),
                onTap: () => FlutterShowToast.showToast('msg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemRateView({BaseModel? model}) {
  return Padding(
    padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
    child: Container(
      width: 348.w,
      height: 68.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 3.sp),
          itemListView(
            imagestr: 'rate_list_image',
            title: model?.maiden?.greatly?.tickets?.first.pissed ?? '',
            desc: model?.maiden?.greatly?.tickets?.first.disarray ?? '',
          ),
          SizedBox(width: 10),
          itemListView(
            imagestr: 'item_list_image',
            title: model?.maiden?.greatly?.tickets?.first.guess ?? '',
            desc:
                '${model?.maiden?.greatly?.tickets?.first.each ?? ''}${model?.maiden?.greatly?.tickets?.first.paragraph ?? ''}s',
          ),
          SizedBox(width: 3.sp),
        ],
      ),
    ),
  );
}

//贷款利率
Widget itemListView({
  required String imagestr,
  required String title,
  required String desc,
}) {
  return Row(
    children: [
      Image.asset('assets/images/$imagestr.png', width: 40.w, height: 40.h),
      SizedBox(width: 6.w),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          SizedBox(height: 2.sp),
          Text(
            textAlign: TextAlign.left,
            desc,
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    ],
  );
}

//贷款协议
Widget loanitemsListView() {
  return Padding(
    padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
    child: Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9.sp),
      ),
      child: InkWell(
        child: Row(
          children: [
            SizedBox(width: 17.w),
            Image.asset(
              'assets/images/home_item_image.png',
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 12.w),
            Text(
              'Loan Terms',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/home_right_click_image.png',
              width: 15.w,
              height: 15.h,
            ),
            SizedBox(width: 18.w),
          ],
        ),
        onTap: () {
          FlutterShowToast.showToast('items');
        },
      ),
    ),
  );
}

//介绍
Widget appintrodueView() {
  return Padding(
    padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9.sp)),
      child: Column(
        children: [
          Text(
            'Safe and reliable, rest assured loan',
            style: TextStyle(
              color: Color(0xFF333333),
              fontFamily: 'inter',
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              indroceListViwe('home_desc_image', 'Flexible'),
              indroceListViwe('home_de_image', 'Fast loan'),
              indroceListViwe('home_fuc_iamge', 'Safety'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget indroceListViwe(String imageStr, String title) {
  return Container(
    height: 96.h,
    width: 102.w,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(9.sp),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$imageStr.png',
          width: 40.w,
          height: 40.h,
          fit: BoxFit.cover,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF666666),
          ),
        ),
      ],
    ),
  );
}

Widget footerView() {
  return Padding(
    padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.sp),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FAQ',
            style: TextStyle(
              color: Color(0xFF333333),
              fontFamily: 'inter',
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 11.h),
          Container(
            height: 202.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                footerListView('How long does the application take?'),
                SizedBox(height: 8.h),
                footerListView(
                  'What are the consequences of overdue repayment?',
                ),
                SizedBox(height: 8.h),
                footerListView(
                  'What materials are needed to apply for a loan?',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget footerListView(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0x5CDFEBAC),
        borderRadius: BorderRadius.circular(9.sp),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 247.w,
            child: Padding(
              padding: EdgeInsets.only(left: 12.sp, top: 9.sp, bottom: 9.sp),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/right_image.png',
            width: 14.w,
            height: 14.h,
          ),
          SizedBox(width: 14.w),
        ],
      ),
    ),
  );
}
