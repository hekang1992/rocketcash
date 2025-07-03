import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class IOSContactService {
  static const _channel = MethodChannel('contact_service');

  /// 获取所有联系人（仅姓名和电话）
  static Future<List<Contact>> getAllContacts() async {
    try {
      final contacts = await _channel.invokeMethod('getAllContacts');
      return (contacts as List)
          .map((e) => Contact.fromMap(Map<String, String>.from(e)))
          .toList();
    } on PlatformException catch (e) {
      print("获取联系人失败: ${e.message}");
      return [];
    }
  }

  /// 单选联系人
  static Future<Contact?> pickContact() async {
    try {
      final contact = await _channel.invokeMethod('pickSingleContact');
      return contact != null
          ? Contact.fromMap(Map<String, String>.from(contact))
          : null;
    } on PlatformException catch (e) {
      print("选择联系人失败: ${e.message}");
      return null;
    }
  }
}

class Contact {
  final String activate;
  final String space;

  Contact({required this.activate, required this.space});

  factory Contact.fromMap(Map<String, String> map) {
    return Contact(activate: map['activate'] ?? '', space: map['space'] ?? '');
  }

  @override
  String toString() => 'Contact(activate: $activate, activate: $space)';
}

class PermissionConfig {
  static showPermissionDeniedDialog(String permissionName) {
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
