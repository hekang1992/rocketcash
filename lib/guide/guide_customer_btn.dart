import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuideCustomerBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final Color? titlecolor;

  const GuideCustomerBtn({
    super.key,
    required this.title,
    this.color,
    this.titlecolor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color ?? Color(0xffFF962D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        textAlign: TextAlign.center,
        title,
        style: TextStyle(
          color: titlecolor ?? Colors.white,
          fontSize: 18.sp,
          fontFamily: 'inter',
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
