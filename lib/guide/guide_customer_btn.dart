import 'package:flutter/material.dart';

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
        backgroundColor: color ?? Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        textAlign: TextAlign.center,
        title,
        style: TextStyle(
          color: titlecolor ?? Colors.white,
          fontSize: 16,
          fontFamily: 'inter',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
