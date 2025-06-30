import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rocketcash/http/flutter_toast.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/http/response_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class OneListController extends GetxController {
  late final String? productID;
  late final String? authStr;
  var model = BaseModel().obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  var photoModel = BaseModel().obs;
  var cameraModel = BaseModel().obs;

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController idcontroller = TextEditingController();

  var timeStr = ''.obs;

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

  /// 从相册选择
  Future<void> pickImageFromGallery({
    required void Function(bool) imageBlock,
  }) async {
    final status = await Permission.photos.request();

    print("✈️ 权限状态: $status");

    if (status.isGranted || status.isLimited) {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      imageFile.value = image;

      await uploadUmidInfo(
        source: '1',
        imageFile: File(image.path),
        imageBlock: (grand) {
          imageBlock(grand);
        },
      );
    } else {
      showPermissionDeniedDialog('Gallery');
    }
  }

  /// 拍照
  Future<void> takePhoto({
    required bool isFace,
    required void Function(bool) imageBlock,
  }) async {
    final ImagePicker picker = ImagePicker();
    if (isFace) {}
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: isFace ? CameraDevice.front : CameraDevice.rear,
      );
      if (image == null) return;
      imageFile.value = image;
      await uploadUmidInfo(
        source: '2',
        imageFile: File(image.path),
        imageBlock: (grand) {
          imageBlock(grand);
        },
      );
    } else {
      showPermissionDeniedDialog('Camera');
    }
  }

  // 显示权限被拒绝的对话框
  showPermissionDeniedDialog(String permissionName) {
    Get.dialog(
      AlertDialog(
        title: Text('$permissionName permission denied'),
        content: Text(
          '$permissionName permission is required to proceed. Please go to the settings and enable the permission.',
        ),
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

extension ListVc on OneListController {
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

  //上传身份信息
  Future<void> uploadUmidInfo({
    required String source,
    required File imageFile,
    required Function(bool) imageBlock,
  }) async {
    final dict = {
      'somehow': source,
      'successfully': productID,
      'rates': '11',
      'mountain': authStr,
      'solid': '',
      'halt': '',
      'puzzle': '1',
    };
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().uploadImage(
        '/computed/offended',
        imageFile,
        additionalData: dict,
      );
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        timeStr.value = model.maiden?.mechanical ?? '';
        photoModel.value = model;
        imageBlock(true);
      } else {
        imageBlock(false);
      }
      EasyLoading.dismiss();
      FlutterShowToast.showToast(companion);
    } catch (e) {
      imageBlock(false);
      EasyLoading.dismiss();
    }
  }

  //保存信息
  Future<void> safeUnmiInfo(
    Map<String, dynamic> dict, {
    required VoidCallback block,
  }) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    try {
      final response = await HttpService().postForm('/computed/maybe', dict);
      final model = BaseModel.fromJson(response.data);
      final code = model.salivating ?? '';
      final companion = model.companion ?? '';
      if (code == '0' || code == '00') {
        block();
      }
      FlutterShowToast.showToast(companion);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  //上传人脸
}
