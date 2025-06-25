import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/routes/routes.dart';

void main() => runApp(RocketCashApp());

class RocketCashApp extends StatefulWidget {
  const RocketCashApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RocketCashAppState();
  }
}

class _RocketCashAppState extends State<RocketCashApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        getPages: AppRoutes.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
