import 'package:get/get.dart';
import 'package:rocketcash/auth/contract/contact_controller.dart';
import 'package:rocketcash/auth/contract/contact_view.dart';
import 'package:rocketcash/auth/personan/personal_controller.dart';
import 'package:rocketcash/auth/personan/personal_view.dart';
import 'package:rocketcash/auth/umid/face_controller.dart';
import 'package:rocketcash/auth/umid/face_view.dart';
import 'package:rocketcash/auth/umid/one_list_controller.dart';
import 'package:rocketcash/auth/umid/one_list_view.dart';
import 'package:rocketcash/auth/introduce/introduce_controller.dart';
import 'package:rocketcash/auth/introduce/introduce_view.dart';
import 'package:rocketcash/auth/work/work_view.dart';
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
  static const String tab = '/tab';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String guide = '/guide';
  static const String centerlist = '/centerlist';
  static const String webpage = '/webpage';
  static const String introduce = '/introduce'; //认证列表页面
  static const String oneauth = '/oneauth'; //umid
  static const String faceauth = '/faceauth'; //face
  static const String personalauth = '/personalauth';
  static const String workauth = '/workauth';
  static const String contactauth = '/contactauth';

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
      name: '/tab',
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

    GetPage(
      name: '/oneauth',
      page: () => OneListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OneListController());
      }),
    ),

    GetPage(
      name: '/faceauth',
      page: () => FaceView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FaceController());
      }),
    ),

    GetPage(
      name: '/personalauth',
      page: () => PersonalView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PersonalController());
      }),
    ),

    GetPage(
      name: '/workauth',
      page: () => WorkView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PersonalController());
      }),
    ),

    GetPage(
      name: '/contactauth',
      page: () => ContactView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ContactController());
      }),
    ),
  ];
}
