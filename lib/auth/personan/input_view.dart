import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rocketcash/http/response_model.dart';

class InputView extends StatefulWidget {
  final Fortunemodel model;
  final TextEditingController controller;
  const InputView({super.key, required this.model, required this.controller});

  @override
  State<StatefulWidget> createState() {
    return _InputViewState();
  }
}

class _InputViewState extends State<InputView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Container(
        color: Colors.transparent,
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
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9.sp),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.sp),
                  child: TextField(
                    keyboardType: widget.model.plenty == 0
                        ? TextInputType.text
                        : TextInputType.number,
                    controller: widget.controller,
                    onChanged: (value) {
                      if (widget.controller.value.composing.isValid) {
                        return;
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: widget.model.heartbeat ?? '',
                      hintStyle: TextStyle(
                        color: Color(0xFF999999),
                        fontFamily: 'inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
