import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rocketcash/http/response_model.dart';

// ignore: must_be_immutable
class ClickView extends StatefulWidget {
  final Fortunemodel model;

  void Function(Fortunemodel) modelBlock;

  ClickView({super.key, required this.model, required this.modelBlock});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClickViewState();
  }
}

class _ClickViewState extends State<ClickView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final friends = widget.model.friends ?? '';
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: SizedBox(
        height: 80.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              widget.model.appeared ?? '',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 9.h),
            InkWell(
              onTap: () {
                widget.modelBlock(widget.model);
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      Text(
                        friends.isEmpty
                            ? widget.model.heartbeat ?? ''
                            : widget.model.friends ?? '',
                        style: TextStyle(
                          color: friends.isEmpty
                              ? Color(0xFF999999)
                              : Color(0xFF333333),
                          fontFamily: 'inter',
                          fontSize: friends.isEmpty ? 12.sp : 14.sp,
                          fontWeight: FontWeight.w500,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
