import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rocketcash/other/coler/coler.dart';
import 'package:rocketcash/guide/guide_customer_btn.dart';
import 'package:rocketcash/http/response_model.dart';

class OrderListView extends StatefulWidget {
  final KeyboardModel model;
  final VoidCallback onTap;
  const OrderListView({super.key, required this.model, required this.onTap});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderListViewState();
  }
}

class _OrderListViewState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var imagestr = '';
    final buried = widget.model.chosen?.buried ?? 0;
    if (buried == 1) {
      imagestr = 'ov_imge_li';
    } else if (buried == 2) {
      imagestr = 're_pae_imge';
    } else if (buried == 3) {
      imagestr = 'apple_ige_im';
    } else if (buried == 4) {
      imagestr = 'und_igme_awg';
    } else if (buried == 5) {
      imagestr = 'fin_aigf_iamge';
    } else {
      imagestr = '';
    }

    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
        child: Container(
          height: 230.h,
          decoration: BoxDecoration(
            color: Color(0xFFAAD301),
            borderRadius: BorderRadius.all(Radius.circular(9.sp)),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 163.h,
                    width: 6.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFE63F53),
                      borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 163.h,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: Row(
                              children: [
                                SizedBox(width: 11.w),
                                Image.network(
                                  widget.model.chosen?.permitted ?? '',
                                  width: 21.w,
                                  height: 21.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                ),
                                SizedBox(width: 11.w),
                                Text(
                                  widget.model.chosen?.draw ?? '',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                Spacer(),
                                Transform.rotate(
                                  angle: pi,
                                  child: Image.asset(
                                    'assets/images/back_btn_image.png',
                                    width: 15.w,
                                    height: 15.sp,
                                  ),
                                ),
                                SizedBox(width: 19.w),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: Image.asset(
                              'assets/images/dot_lis_imge.png',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.sp, top: 11.sp),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.model.chosen?.uphold ?? '',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14.sp,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      widget.model.chosen?.bring ?? '',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14.sp,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.model.chosen?.heights ?? '',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14.sp,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      widget.model.chosen?.venerable ?? '',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14.sp,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  'assets/images/$imagestr.png',
                                  width: 88.w,
                                  height: 25.h,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.sp),
                            child: Image.asset(
                              'assets/images/dot_lis_imge.png',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6.sp,
                              left: 12.sp,
                              right: 12.sp,
                              bottom: 6.sp,
                            ),
                            child: Text(
                              maxLines: 3, // 最多两行
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              widget.model.chosen?.dirt ?? '',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.sp),
                child: SizedBox(
                  width: 245.w,
                  height: 50.h,
                  child: GuideCustomerBtn(
                    title: widget.model.chosen?.may ?? '',
                    onPressed: () {
                      widget.onTap();
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
