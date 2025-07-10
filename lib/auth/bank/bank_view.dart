import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/bank/bank_controller.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/transition_view.dart';
import 'package:rocketcash/auth/personan/click_view.dart';
import 'package:rocketcash/auth/personan/emum_view.dart';
import 'package:rocketcash/auth/personan/input_view.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/routes/routes.dart';

class BankView extends GetView<BankController> {
  BankView({super.key}) {
    Get.put(BankController());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: getAppBar(
            'Identity authentication',
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
          body: Container(
            color: Color(0xFFEBEDE5),
            child: Obx(() {
              final listModel = controller.listModel.value.fortune;
              return ListView(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 120.h,
                    child: TransitionView(
                      title: 'Payment information',
                      desc: 'We will protect your information security',
                      image: 'bak_lige_ce',
                      progress: 1.0,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// select - bank -- wallet
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        yellowBtn(
                          'E-Wallet',
                          isSelected: controller.selected.value == 'E-Wallet',
                          onTap: (s) {
                            controller.select(s);
                          },
                        ),
                        yellowBtn(
                          'Bank',
                          isSelected: controller.selected.value == 'Bank',
                          onTap: (s) {
                            controller.select(s);
                          },
                        ),
                      ],
                    );
                  }),

                  ...List.generate(listModel?.length ?? 0, (index) {
                    final list1Model = listModel?[index];
                    final opportunities = list1Model?.opportunities ?? '';
                    print('index======$index');
                    if (opportunities == 'flectuical') {
                      final rates = list1Model?.rates ?? '';
                      controller.inputControllers[index]?.text = rates;
                      return InputView(
                        model: list1Model!,
                        controller: controller.inputControllers[index]!
                          ..addListener(() {
                            list1Model.friends =
                                controller.inputControllers[index]!.text;
                            list1Model.rates =
                                controller.inputControllers[index]!.text;
                            // controller.listModel.refresh();
                          }),
                      );
                    } else if (opportunities == 'meniyearually') {
                      return ClickView(
                        model: list1Model!,
                        modelBlock: (p0) {
                          Get.bottomSheet(
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            EmumView(
                              model: p0.unnoticed ?? [],
                              modelBlock: (selected) {
                                list1Model.friends = selected.activate ?? '';
                                list1Model.rates = (selected.rates ?? 0)
                                    .toString();
                                controller.listModel.refresh();
                              },
                              dismissBlock: () {
                                Get.back();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.sp,
                      left: 13.sp,
                      right: 13.sp,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: GuideCustomerBtn(
                        title: 'Next step',
                        onPressed: () {
                          Map<String, String> dict = {};
                          final model = controller.listModel.value;
                          final listModel = model.fortune ?? [];
                          if (listModel.isNotEmpty) {
                            final mountain =
                                controller.selected.value == 'E-Wallet' ? 1 : 2;
                            dict['successfully'] = controller.producdID;
                            dict['mountain'] = mountain.toString();
                          }
                          for (var model in listModel) {
                            final key = model.salivating ?? '';
                            dict[key] = model.rates ?? '';
                          }
                          controller.saveBankInfo(dict);
                          print('dict=======$dict');
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// 单选按钮组件
Widget yellowBtn(
  String title, {
  required bool isSelected,
  required void Function(String) onTap,
}) {
  return InkWell(
    onTap: () => onTap(title),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 31.h,
          width: 155.w,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFAAD301) : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.sp),
              bottomRight: Radius.circular(9.sp),
            ),
            border: Border.all(color: Color(0xFFAAD301), width: 1),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.black : Colors.black45,
          ),
        ),
      ],
    ),
  );
}
