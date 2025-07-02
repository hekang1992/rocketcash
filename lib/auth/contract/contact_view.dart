import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/auth/contract/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/transition_view.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/routes/routes.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

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
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 115.h,
                child: TransitionView(
                  title: 'Contact person',
                  desc: 'We will protect your information security',
                  image: 'peop_con_imge',
                  progress: 0.8,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: GuideCustomerBtn(
                    title: 'Next step',
                    onPressed: () {
                      print('dict=======DDDDD');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
