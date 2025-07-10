import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/transition_view.dart';
import 'package:rocketcash/auth/personan/click_view.dart';
import 'package:rocketcash/auth/personan/emum_view.dart';
import 'package:rocketcash/auth/personan/input_view.dart';
import 'package:rocketcash/auth/personan/personal_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:rocketcash/routes/routes.dart';

class PersonalView extends GetView<PersonalController> {
  PersonalView({super.key}) {
    Get.put(PersonalController());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true, // ✅ 允许键盘推页面
          appBar: getAppBar(
            'Identity Authentication',
            onPressed: () {
              Get.until((route) {
                final currentRoute = route.settings.name?.split('?').first;
                return currentRoute == AppRoutes.introduce;
              });
              final controller = Get.put(IntroduceController());
              controller.getProductDetailInfo(controller.producdID);
              controller.getAuthInfo(controller.producdID);
            },
          ),
          body: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              print('Keyboard is visible: $isKeyboardVisible');

              return Container(
                color: const Color(0xFFEBEDE5),
                child: Obx(() {
                  final model = controller.model.value;
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: isKeyboardVisible ? 200.h : 40.h, // 避开键盘
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 120.h,
                        child: TransitionView(
                          title: 'Basic information',
                          desc: 'We will protect your information security',
                          image: 'base_imge_li',
                          progress: 0.4,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // 渲染列表内容
                      ...List.generate(model.maiden?.fortune?.length ?? 0, (
                        index,
                      ) {
                        final listModel = model.maiden?.fortune?[index];
                        final opportunities = listModel?.opportunities ?? '';
                        if (opportunities == 'flectuical') {
                          controller.inputControllers[index]?.text =
                              model.maiden?.fortune?[index].rates ?? '';
                          return InputView(
                            model: listModel!,
                            controller: controller.inputControllers[index]!
                              ..addListener(() {
                                listModel.friends =
                                    controller.inputControllers[index]!.text;
                                listModel.rates =
                                    controller.inputControllers[index]!.text;
                                // controller.model.refresh();
                              }),
                          );
                        } else if (opportunities == 'meniyearually') {
                          return ClickView(
                            model: listModel!,
                            modelBlock: (p0) {
                              Get.bottomSheet(
                                enableDrag: false,
                                isScrollControlled: true,
                                isDismissible: false,
                                EmumView(
                                  model: p0.unnoticed ?? [],
                                  modelBlock: (selected) {
                                    listModel.friends = selected.activate ?? '';
                                    listModel.rates = (selected.rates ?? 0)
                                        .toString();
                                    controller.model.refresh();
                                  },
                                  dismissBlock: () {
                                    Get.back();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return ClickView(
                            model: listModel!,
                            modelBlock: (p0) async {
                              await controller.getCityInfo();
                              final modelArray =
                                  controller.citymodel.value.maiden?.keyboard ??
                                  [];
                              showPicker(
                                modelArray,
                                context,
                                cityBlock: (p0) {
                                  listModel.friends = p0;
                                  listModel.rates = p0;
                                  controller.model.refresh();
                                  Future.delayed(
                                    Duration(microseconds: 200),
                                    () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }
                      }),

                      SizedBox(height: 40.h),

                      Padding(
                        padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: GuideCustomerBtn(
                            title: 'Next step',
                            onPressed: () {
                              Map<String, String> dict = {};
                              final model = controller.model.value.maiden;
                              final listModel = model?.fortune ?? [];
                              if (listModel.isNotEmpty) {
                                dict['successfully'] = controller.producdID;
                              }
                              for (var model in listModel) {
                                final key = model.salivating ?? '';
                                dict[key] = model.rates ?? '';
                              }
                              controller.savePersonalInfo(dict);
                              print('dict=======$dict');
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

showPicker(
  List<KeyboardModel> modelArray,
  BuildContext context, {
  required void Function(String) cityBlock,
}) {
  Map<String, dynamic> pickerData = {};

  for (var province in modelArray) {
    Map<String, dynamic> cityMap = {};

    if (province.keyboard != null && province.keyboard!.isNotEmpty) {
      for (var city in province.keyboard!) {
        List<String> districtList =
            city.keyboard?.map((d) => d.activate ?? '').toList() ?? [''];
        cityMap[city.activate ?? ''] = districtList;
      }
    } else {
      cityMap[''] = [''];
    }

    pickerData[province.activate ?? ''] = cityMap;
  }

  Pickers.showMultiLinkPicker(
    context,
    data: pickerData,
    onCancel: (isCancel) {
      Future.delayed(Duration(microseconds: 200), () {
        FocusManager.instance.primaryFocus?.unfocus();
      });
    },
    onConfirm: (selected, index) {
      try {
        String provinceName = selected[0] ?? '';
        String cityName = selected[1] ?? '';
        String districtName = selected[2] ?? '';
        cityBlock('$provinceName-$cityName-$districtName');
      } catch (e) {
        print("failure====: $e");
      }
    },
    pickerStyle: PickerStyle(
      pickerItemHeight: 50.sp,
      pickerTitleHeight: 50.sp,
      backgroundColor: Colors.white,
      menuHeight: 40.h,
      title: Align(
        child: Text(
          'Please select your city',
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cancelButton: Padding(
        padding: EdgeInsets.only(left: 15.sp),
        child: Text(
          "Cancel",
          style: TextStyle(
            color: Color(0xFF999999),
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      commitButton: Padding(
        padding: EdgeInsets.only(right: 15.sp),
        child: Text(
          "Confirm",
          style: TextStyle(
            color: Color(0xFFAAD301),
            fontFamily: 'inter',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    columeNum: 3,
  );
}
