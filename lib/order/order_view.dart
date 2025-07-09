import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/http/login_info.dart';
import 'package:rocketcash/main/main_controller.dart';
import 'package:rocketcash/order/order_controller.dart';
import 'package:rocketcash/order/order_list_view.dart';
import 'package:rocketcash/routes/routes.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: getAppBar(
          'Order list',
          onPressed: () {
            Get.back();
          },
        ),
        body: Container(
          color: Color(0xFFEBEDE5),
          child: Column(
            children: [
              orderHeadView(controller),
              Obx(() {
                final model = controller.model.value;
                final keyboard = model.maiden?.keyboard ?? [];
                if (keyboard.isEmpty) {
                  return Expanded(
                    child: havenodataView(() {
                      final vc = Get.put(MainController());
                      vc.changeTabIndex(0);
                      Get.back();
                    }),
                  );
                } else {
                  return Expanded(
                    child: SmartRefresher(
                      physics: BouncingScrollPhysics(),
                      controller: controller.refreshController,
                      onRefresh: () {
                        final selectedIndex = controller.selectedIndex.value;
                        var listtype = '';
                        if (selectedIndex == 0) {
                          listtype = '4';
                        } else if (selectedIndex == 1) {
                          listtype = '7';
                        } else if (selectedIndex == 2) {
                          listtype = '6';
                        } else {
                          listtype = '5';
                        }
                        controller.getOrderList(listtype);
                      },
                      child: ListView(
                        children: [
                          SizedBox(height: 5.h),
                          ...List.generate(keyboard.length, (index) {
                            return OrderListView(
                              model: keyboard[index],
                              onTap: () async {
                                Map<String, String> dict =
                                    await LoginInfoManager.getLoginInfo();
                                final nextUrl =
                                    keyboard[index].chosen?.wish ?? '';
                                if (nextUrl.contains(
                                  'rocket.apploan.org/bearIrisBell',
                                )) {
                                  final uri = Uri.parse(nextUrl);
                                  final value =
                                      uri.queryParameters['successfully'] ?? '';
                                  Get.toNamed(
                                    AppRoutes.introduce,
                                    parameters: {'producdID': value},
                                  )?.then((onValue) {
                                    if (onValue == 'order') {
                                      final cc = controller.selectedIndex.value;
                                      var tupe = '';
                                      if (cc == 0) {
                                        tupe = '4';
                                      } else if (cc == 1) {
                                        tupe = '7';
                                      } else if (cc == 2) {
                                        tupe = '6';
                                      } else {
                                        tupe = '5';
                                      }
                                      controller.getOrderList(tupe);
                                    }
                                    return onValue;
                                  });
                                } else {
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
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget orderHeadView(OrderController controller) {
  final List<String> types = ['All', 'Under Way', 'Repayment', 'Finish'];

  return Padding(
    padding: EdgeInsets.only(left: 13.sp, top: 10.sp, right: 13.sp),
    child: Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.calculateTabCenters();
      });

      double left = 0;
      if (controller.tabCenters.length == types.length) {
        left =
            controller.tabCenters[controller.selectedIndex.value] -
            35.w / 2 -
            13.sp;
      }

      return SizedBox(
        height: 70.h,
        child: Stack(
          children: [
            Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xFF13A65F),
                borderRadius: BorderRadius.all(Radius.circular(9)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(types.length, (index) {
                  return GestureDetector(
                    onTap: () async {
                      controller.selectedIndex.value = index;
                      var tupe = '';
                      if (index == 0) {
                        tupe = '4';
                      } else if (index == 1) {
                        tupe = '7';
                      } else if (index == 2) {
                        tupe = '6';
                      } else {
                        tupe = '5';
                      }
                      await controller.getOrderList(tupe);
                    },
                    child: Container(
                      key: controller.tabKeys[index],
                      color: Colors.transparent,
                      child: Text(
                        types[index],
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14.sp,
                          fontWeight: controller.selectedIndex.value == index
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              bottom: 0,
              left: left > 0 ? left : 0,
              child: Image.asset(
                'assets/images/selimage_imge_li.png',
                width: 35.w,
                height: 17.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }),
  );
}

Widget havenodataView(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/hav_no_data_imge.png',
          width: 190.w,
          height: 251.h,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
