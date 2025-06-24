import 'package:get/get.dart';
import 'package:rocketcash/login/login_controller.dart';
import 'package:rocketcash/login/login_view.dart';
import 'package:rocketcash/main/main_controller.dart';
import 'package:rocketcash/main/main_view.dart';
import 'package:rocketcash/splash/splash_controller.dart';
import 'package:rocketcash/splash/splash_view.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String tab = '/tab';
  static const String login = '/login';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }),
    ),
    GetPage(
      name: '/',
      page: () => MainView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainController());
      }),
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
  ];
}
