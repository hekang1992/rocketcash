import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/response_model.dart';

// ignore: must_be_immutable
class EmumView extends StatefulWidget {
  List<Unnoticedmodel> model;
  void Function(Unnoticedmodel) modelBlock;
  VoidCallback dismissBlock;

  EmumView({
    super.key,
    required this.model,
    required this.modelBlock,
    required this.dismissBlock,
  });

  @override
  State<StatefulWidget> createState() {
    return _EmumViewState();
  }
}

class _EmumViewState extends State<EmumView> {
  int? selectindex;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 320.h,
      decoration: BoxDecoration(
        color: Color(0xFFAAD301),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9.sp),
          topRight: Radius.circular(9.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.sp),
        child: Container(
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.sp),
              topRight: Radius.circular(9.sp),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Text(
                      'Confirm information',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16.sp,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => widget.dismissBlock(),
                      child: Image.asset(
                        'assets/images/canel_imge_im.png',
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final listModel = widget.model[index];
                    final isSelected = selectindex == index;
                    return enumListView(
                      listModel,
                      isSelected,
                      onTap: () {
                        setState(() {
                          selectindex = index;
                        });
                        widget.modelBlock(listModel);
                        print('object=========${listModel.activate ?? ''}');
                        print('object=========${listModel.rates ?? ''}');
                      },
                    );
                  },
                  itemCount: widget.model.length,
                ),
              ),
              SizedBox(
                height: 50.h,
                width: 347.w,
                child: GuideCustomerBtn(
                  title: 'Confirm',
                  onPressed: () {
                    widget.dismissBlock();
                  },
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget enumListView(
  Unnoticedmodel model,
  bool select, {
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 10.sp),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEBEDE5),
          borderRadius: BorderRadius.all(Radius.circular(9.sp)),
        ),
        height: 40.h,
        child: Row(
          children: [
            SizedBox(width: 10.w),
            if (model.equipped?.isNotEmpty ?? false)
              Image.network(
                model.equipped ?? '',
                width: 20.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
            if (model.equipped?.isNotEmpty ?? false) SizedBox(width: 10.w),
            Text(
              model.activate ?? '',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.sp,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Image.asset(
              select
                  ? 'assets/images/man_sel_image.png'
                  : 'assets/images/man_nor_image.png',
              width: 15.w,
              height: 15.h,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    ),
  );
}
