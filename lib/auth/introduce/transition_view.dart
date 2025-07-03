import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//头部进度页面
class TransitionView extends StatefulWidget {
  final String title;
  final String desc;
  final String image;
  final double progress;

  const TransitionView({
    super.key,
    required this.title,
    required this.desc,
    required this.image,
    required this.progress,
  });

  @override
  State<StatefulWidget> createState() {
    return _TransitionViewState();
  }
}

class _TransitionViewState extends State<TransitionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 13.sp,
        right: 13.sp,
        top: 20.sp,
        bottom: 0,
      ),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.desc,
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontFamily: 'inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/${widget.image}.png',
                        width: 58.w,
                        height: 58.h,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '${(widget.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 10.sp,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 15.h,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(9.sp),
                backgroundColor: Color(0x1A000000),
                valueColor: AlwaysStoppedAnimation(Colors.black),
                value: widget.progress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
