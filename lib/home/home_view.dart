import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/home/home_controller.dart';
import 'package:rocketcash/http/login_info.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rocketcash/routes/routes.dart';
import 'package:rocketcash/other/coler/coler.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key}) {
    final _ = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final model = controller.model.value;
        final rate = model.maiden?.greatly?.rates ?? '';
        if (rate == 'outsidkeot') {
          return homeOneListView(context, model, controller);
        } else {
          return homeTwoViwe(context, model, controller);
        }
      }),
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
          Get.toNamed(
            AppRoutes.webpage,
            parameters: {'pageUrl': '$h5Host/saladNutmeg'},
          );
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

Widget homeOneListView(
  BuildContext context,
  BaseModel model,
  HomeController controller,
) {
  List<TicketsModel> tickes = [];
  for (TicketsModel model1 in model.maiden?.points?.tickets ?? []) {
    tickes.add(model1);
  }
  return Container(
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
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SmartRefresher(
            physics: BouncingScrollPhysics(),
            controller: controller.refreshController1,
            onRefresh: () {
              controller.getHomeInfo();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.webpage,
                            parameters: {'pageUrl': '$h5Host/mackerelHor'},
                          );
                        },
                        child: Image.asset(
                          'assets/images/home_kef_imge.png',
                          width: 33.w,
                          height: 33.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 23.w),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Image.asset(
                    'assets/images/green_home_image.png',
                    width: 130.w,
                    height: 17.h,
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      SizedBox(width: 5.sp),
                      SizedBox(
                        width: 103.w,
                        child: Text(
                          model.maiden?.greatly?.tickets?.first.ticket ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
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
                          Text(
                            model.maiden?.greatly?.tickets?.first.costs ?? '',
                            style: TextStyle(
                              color: Color(0xFFD3F157),
                              fontFamily: 'inter',
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  itemRateView(model: model),
                  SizedBox(height: 13.5.sp),
                  Center(
                    child: SizedBox(
                      width: 347.w,
                      height: 50.h,
                      child: GuideCustomerBtn(
                        color: Color(0xFFAAD301),
                        titlecolor: Color(0xFF333333),
                        title:
                            model.maiden?.greatly?.tickets?.first.activating ??
                            '',
                        onPressed: () {
                          int producdID =
                              model.maiden?.greatly?.tickets?.first.three ?? 0;
                          controller.applyProduct(producdID.toString());
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 84.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      viewportFraction: 1,
                    ),
                    items: tickes.map((m) {
                      return InkWell(
                        onTap: () async {
                          final nextUrl = m.rpgs ?? '';
                          final dict = await LoginInfoManager.getLoginInfo();
                          String? pageUrl =
                              URLParameterHelper.appendQueryParameters(
                                nextUrl,
                                dict,
                              ) ??
                              '';
                          Get.toNamed(
                            AppRoutes.webpage,
                            parameters: {'pageUrl': pageUrl},
                          );
                        },
                        child: SizedBox(
                          width: 347.w,
                          child: Image.network(
                            m.trolled ?? '',
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(color: Colors.white);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10.h),
                  loanitemsListView(),
                  SizedBox(height: 18.h),
                  appintrodueView(),
                  SizedBox(height: 18.h),
                  footerView(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget homeTwoListView(TicketsModel? model, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/bgi_li_tw_imge.png',
            width: 165.w,
            height: 135.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 10.sp,
            child: Container(
              width: 164.w,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.sp),
                  Row(
                    children: [
                      SizedBox(width: 8.sp),
                      Image.asset(
                        'assets/images/login_icon_image.png',
                        width: 30.w,
                        height: 30.h,
                      ),
                      SizedBox(width: 5),
                      Text(
                        model?.draw ?? '',
                        style: TextStyle(
                          fontFamily: 'inter',
                          color: Color(0xFF666666),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${model?.skill ?? ''}₱',
                    style: TextStyle(
                      fontFamily: 'inter',
                      color: Color(0xFF333333),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Image.asset(
                    'assets/images/iagme_fda_acm.png',
                    width: 88.w,
                    height: 15.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 9.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9.sp),
                    child: Image.asset(
                      'assets/images/black_gr_image_btn.png',
                      width: 107.w,
                      height: 27.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget homeTwoViwe(
  BuildContext context,
  BaseModel model,
  HomeController controller,
) {
  List<TicketsModel> tickets = [];
  for (TicketsModel model1 in model.maiden?.dishearteningly?.tickets ?? []) {
    tickets.add(model1);
  }
  return Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    color: Color(0xFFEBEDE5),
    child: Stack(
      children: [
        Image.asset(
          'assets/images/centerbg_image.png',
          width: double.infinity,
          height: 304.h,
          fit: BoxFit.fill,
        ),
        SmartRefresher(
          physics: BouncingScrollPhysics(),
          controller: controller.refreshController,
          onRefresh: () {
            controller.getHomeInfo();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 12.w),
                    Image.asset(
                      'assets/images/centername_logo.png',
                      width: 143.w,
                      height: 42.h,
                      fit: BoxFit.cover,
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/images/home_kef_imge.png',
                      width: 37.w,
                      height: 37.h,
                    ),
                    SizedBox(width: 23.w),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.maiden?.greatly?.tickets?.first.ticket ?? '',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14.sp,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/up_image_home.png',
                      width: 16.w,
                      height: 16.h,
                    ),
                  ],
                ),
                SizedBox(height: 11.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/home_black_image.png',
                      width: 229.w,
                      height: 54.h,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      model.maiden?.greatly?.tickets?.first.costs ?? '',
                      style: TextStyle(
                        color: Color(0xFFD3F157),
                        fontFamily: 'inter',
                        fontSize: 33.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28.h),
                Padding(
                  padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                    ),
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 3.sp),
                        itemListView(
                          imagestr: 'rate_list_image',
                          title:
                              model.maiden?.greatly?.tickets?.first.pissed ??
                              '',
                          desc:
                              model.maiden?.greatly?.tickets?.first.disarray ??
                              '',
                        ),
                        SizedBox(width: 10),
                        itemListView(
                          imagestr: 'item_list_image',
                          title:
                              model.maiden?.greatly?.tickets?.first.guess ?? '',
                          desc:
                              '${model.maiden?.greatly?.tickets?.first.each ?? ''}${model.maiden?.greatly?.tickets?.first.paragraph ?? ''}s',
                        ),
                        SizedBox(width: 3.sp),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 13.h),
                SizedBox(
                  height: 48.h,
                  width: 347.w,
                  child: GuideCustomerBtn(
                    title:
                        model.maiden?.greatly?.tickets?.first.activating ?? '',
                    color: Color(0xFFAAD301),
                    titlecolor: Colors.black,
                    onPressed: () {
                      final producdID =
                          model.maiden?.greatly?.tickets?.first.three ?? 0;
                      controller.applyProduct(producdID.toString());
                    },
                  ),
                ),
                SizedBox(height: 13.h),
                if (tickets.isNotEmpty)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/singgl_ld_imge.png',
                        width: 347.w,
                        height: 90.h,
                      ),
                      Positioned(
                        top: 0,
                        left: 9.sp,
                        right: 9.sp,
                        bottom: 0,
                        child: Container(
                          width: 347.w,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.sp),
                                child: SizedBox(
                                  width: 280.w,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: CarouselSlider(
                                      items: tickets.map((m) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.webpage,
                                              parameters: {
                                                'pageUrl': m.rpgs ?? '',
                                              },
                                            );
                                          },
                                          child: Center(
                                            child: SizedBox(
                                              width: 280.w,
                                              child: Text(
                                                m.companion ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'inter',
                                                  color: Color(0xD9D37501),
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      options: CarouselOptions(
                                        height: 90.0,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        viewportFraction: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/images/rig_lih_imge.png',
                                width: 33.w,
                                height: 90.h,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.sp),
                Container(
                  color: Colors.transparent,
                  child: Text(
                    'Featured Products',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.only(top: 5.sp),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: model.maiden?.uis?.tickets?.length ?? 0,
                  itemBuilder: (context, index) {
                    final listModel = model.maiden?.uis?.tickets?[index];
                    return homeTwoListView(
                      listModel,
                      onTap: () {
                        final three = listModel?.three ?? 0;
                        controller.applyProduct(three.toString());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
