import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class OneListController extends GetxController {
  late final String? productID;
  late final String? authStr;
  var model = BaseModel().obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    productID = Get.parameters['productID'] ?? '';
    authStr = Get.parameters['auth'] ?? '';
    debugPrint("onInit 被调用=====onelist");

    if (productID != null && productID!.isNotEmpty) {
      getAuthInfo(productID!);
    }
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("onReady 被调用=====onelist");
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("onClose 被调用=====onelist");
  }

  // 获取用户认证信息
  Future<void> getAuthInfo(String productID) async {
    EasyLoading.show(status: '加载中...', dismissOnTap: true);

    try {
      final response = await HttpService().get(
        '/computed/tonightim',
        queryParameters: {
          'successfully': productID,
          'sutra': 'c',
          'auth': authStr ?? '',
        },
      );

      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';

      if (code == '0' || code == "00") {
        this.model.value = model;
      }
    } catch (e) {
      EasyLoading.dismiss();
    } finally {
      EasyLoading.dismiss();
    }
  }

  // // 获取相册权限并选择图片
  // Future<void> pickImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  // }

  // //相机
  // Future<void> takePhoto() async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

  // }

  /// 从相册选择
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final status = await Permission.photos.request();

    print("权限状态: $status");

    if (status.isGranted || status.isLimited) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) imageFile.value = image;
    } else {
      final status = await Permission.photos.request();
    }
  }

  /// 拍照
  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) imageFile.value = image;
    } else {
      openAppSettings(); // 权限被拒
    }
  }

  // 显示权限被拒绝的对话框
  showPermissionDeniedDialog(String permissionName) {
    Get.dialog(
      AlertDialog(
        title: Text('$permissionName权限被拒绝'),
        content: Text('需要$permissionName权限才能继续操作，请前往设置中允许权限'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Get.back()),
          TextButton(
            child: const Text('Setting'),
            onPressed: () {
              Get.back();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
