import 'package:get/get.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/introduce_view.dart';
import 'package:rocketcash/center/center_list_controller.dart';
import 'package:rocketcash/center/center_list_view.dart';
import 'package:rocketcash/guide/guide_controller.dart';
import 'package:rocketcash/guide/guide_view.dart';
import 'package:rocketcash/login/login_controller.dart';
import 'package:rocketcash/login/login_view.dart';
import 'package:rocketcash/main/main_controller.dart';
import 'package:rocketcash/main/main_view.dart';
import 'package:rocketcash/splash/splash_controller.dart';
import 'package:rocketcash/splash/splash_view.dart';
import 'package:rocketcash/web/web_flutter.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String tab = '/tab';
  static const String login = '/login';
  static const String guide = '/guide';
  static const String centerlist = '/centerlist';
  static const String webpage = '/webpage';
  static const String introduce = '/introduce';

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
      name: '/guide',
      page: () => GuideView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => GuideController());
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

    GetPage(
      name: '/centerlist',
      page: () => CenterListView(),
      // transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CenterListController());
      }),
    ),

    GetPage(name: '/webpage', page: () => WebFlutterView()),

    GetPage(
      name: '/introduce',
      page: () => IntroduceView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => IntroduceController());
      }),
    ),
  ];
}
