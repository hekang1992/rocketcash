import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetIdfa {
  static Future<void> requestIDFA() async {
    // 检查追踪权限状态
    TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      // 请求权限
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }

    if (status == TrackingStatus.authorized) {
      String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
    }
  }
}

class DeviceIdentifierManager {
  static const _storageKey = 'device_idfv';
  static final _storage = FlutterSecureStorage();

  /// 获取设备 IDFV，并保存在 Keychain（iOS）或 Keystore（Android）中
  static Future<String> getOrCreateDeviceIdentifier() async {
    // 先尝试读取已存在的 ID
    String? storedId = await _storage.read(key: _storageKey);
    if (storedId != null && storedId.isNotEmpty) {
      return storedId;
    }

    String? idfv;

    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      idfv = iosInfo.identifierForVendor;
    } else {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      idfv = androidInfo.id;
    }

    if (idfv != null) {
      await _storage.write(key: _storageKey, value: idfv);
      return idfv;
    } else {
      throw Exception('无法获取设备标识符');
    }
  }
}
