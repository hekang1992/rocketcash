import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/other/hive/save_info.dart';
import 'package:rocketcash/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpService().init();
  await HiveStorage.init();
  runApp(RocketCashApp());
}

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
          appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
