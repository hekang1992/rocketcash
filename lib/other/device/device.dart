import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rocketcash/other/hive/save_info.dart';
import 'package:rocketcash/other/idfa/get_idfa.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceData {
  static Future<Map<String, dynamic>> collectAll() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    final batteryState = await battery.batteryState;
    final isCharging = batteryState == BatteryState.charging ? 1 : 0;

    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;

    final packageInfo = await PackageInfo.fromPlatform();
    final suit = packageInfo.packageName;

    final info = NetworkInfo();

    double? freeDiskSpace = await DiskSpace.getFreeDiskSpace ?? 0.0;
    double? totalDiskSpace = await DiskSpace.getTotalDiskSpace ?? 0.0;
    final memory = await IosMemoryInfo.getMemoryInfo();

    return {
      "stones": "ios",
      "tightened": iosInfo.systemVersion,
      "perfectly": 'timestamp',
      "suit": suit,
      "acquired": {"technique": batteryLevel, "peculiar": isCharging},
      "possess": {
        "spun": await DeviceIdentifierManager.getOrCreateDeviceIdentifier(),
        "badly": await AppTrackingTransparency.getAdvertisingIdentifier(),
        "pointless": await info.getWifiBSSID(),
        "adult": DateTime.now().millisecondsSinceEpoch.toString(),
        "talent": await ProxyUtil.isUsingProxy(),
        "pressing": await VPNUtil.isUsingVPN(),
        "farflung": iosInfo.isPhysicalDevice ? 0 : 1,
        "alas": iosInfo.isPhysicalDevice ? 0 : 1,
        "eternal": await Getylanuge.getLanguage(),
        "wander": "",
        "anticipation": HiveStorage.getnet(),
        "eager":
            '${DateTime.now().timeZoneName}${DateTime.now().timeZoneOffset.isNegative ? "-" : "+"}${DateTime.now().timeZoneOffset.inHours.abs()}',
        "stars": 0,
      },
      "gazed": {
        "comes": "",
        "odd": iosInfo.model,
        "mused": "",
        "setting": 1.sh.toInt(),
        "casual": 1.sw.toInt(),
        "legends": iosInfo.name,
        "gods": iosInfo.utsname.machine,
        "seas": iosInfo.utsname.machine,
        "overturn": await PhoneSizeDetector.getPhoneSizeInInches(),
        "mountains": iosInfo.systemVersion,
      },
      "topple": {
        "immortals": await info.getWifiIP(),
        "earth": [
          {
            "activate": await info.getWifiName(),
            "grandmasters": await info.getWifiBSSID(),
            "pointless": await info.getWifiBSSID(),
            "beneath": await info.getWifiName(),
          },
        ],
        "fates": {
          "activate": await info.getWifiName(),
          "grandmasters": await info.getWifiBSSID(),
          "pointless": await info.getWifiBSSID(),
          "beneath": await info.getWifiName(),
        },
        "grandmaster": 1,
      },
      "rise": {
        "perception": (freeDiskSpace * 1024 * 1024 * 1024).toInt(),
        "develop": (totalDiskSpace * 1024 * 1024 * 1024).toInt(),
        "managed": memory['totalMemory'],
        "attain": memory['freeMemory'],
      },
    };
  }
}

class IosMemoryInfo {
  static const _channel = MethodChannel('device/memory');

  static Future<Map<String, int>> getMemoryInfo() async {
    final result = await _channel.invokeMethod<Map>('getMemoryInfo');
    return {
      'totalMemory': result?['totalMemory'] ?? 0,
      'freeMemory': result?['freeMemory'] ?? 0,
    };
  }
}

class ProxyUtil {
  static const MethodChannel _channel = MethodChannel('proxy_util');

  static Future<int> isUsingProxy() async {
    final int result = await _channel.invokeMethod('isUsingProxy');
    return result; // 1: 使用了代理，0: 未使用
  }
}

class VPNUtil {
  static const MethodChannel _channel = MethodChannel('vpn_util');

  static Future<int> isUsingVPN() async {
    final int result = await _channel.invokeMethod('isUsingVPN');
    return result; // 1: 使用 VPN，0: 未使用
  }
}

class Getylanuge {
  static const MethodChannel _channel = MethodChannel('en_us');

  static Future<String> getLanguage() async {
    final String result = await _channel.invokeMethod('language');
    return result;
  }
}

class PhoneSizeDetector {
  static Future<double?> getPhoneSizeInInches() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return _getIosPhoneSize(iosInfo.utsname.machine);
      }
    } catch (e) {
      print('get-device-info-failur===: $e');
    }
    return null;
  }

  static double? _getIosPhoneSize(String model) {
    const sizeMap = {
      // iPhone
      'iPhone1,1': 3.5, // iPhone
      'iPhone1,2': 3.5, // iPhone 3G
      'iPhone2,1': 3.5, // iPhone 3GS
      'iPhone3,1': 3.5, // iPhone 4
      'iPhone4,1': 3.5, // iPhone 4S
      'iPhone5,1': 4.0, // iPhone 5
      'iPhone5,2': 4.0, // iPhone 5
      'iPhone5,3': 4.0, // iPhone 5C
      'iPhone5,4': 4.0, // iPhone 5C
      'iPhone6,1': 4.0, // iPhone 5S
      'iPhone6,2': 4.0, // iPhone 5S
      'iPhone7,1': 5.5, // iPhone 6 Plus
      'iPhone7,2': 4.7, // iPhone 6
      'iPhone8,1': 4.7, // iPhone 6S
      'iPhone8,2': 5.5, // iPhone 6S Plus
      'iPhone8,4': 4.0, // iPhone SE (1st)
      'iPhone9,1': 4.7, // iPhone 7
      'iPhone9,2': 5.5, // iPhone 7 Plus
      'iPhone9,3': 4.7, // iPhone 7
      'iPhone9,4': 5.5, // iPhone 7 Plus
      'iPhone10,1': 4.7, // iPhone 8
      'iPhone10,2': 5.5, // iPhone 8 Plus
      'iPhone10,3': 5.8, // iPhone X
      'iPhone10,4': 4.7, // iPhone 8
      'iPhone10,5': 5.5, // iPhone 8 Plus
      'iPhone10,6': 5.8, // iPhone X
      'iPhone11,2': 5.8, // iPhone XS
      'iPhone11,4': 6.5, // iPhone XS Max
      'iPhone11,6': 6.5, // iPhone XS Max
      'iPhone11,8': 6.1, // iPhone XR
      'iPhone12,1': 6.1, // iPhone 11
      'iPhone12,3': 5.8, // iPhone 11 Pro
      'iPhone12,5': 6.5, // iPhone 11 Pro Max
      'iPhone12,8': 4.7, // iPhone SE (2nd)
      'iPhone13,1': 5.4, // iPhone 12 mini
      'iPhone13,2': 6.1, // iPhone 12
      'iPhone13,3': 6.1, // iPhone 12 Pro
      'iPhone13,4': 6.7, // iPhone 12 Pro Max
      'iPhone14,2': 6.1, // iPhone 13 Pro
      'iPhone14,3': 6.7, // iPhone 13 Pro Max
      'iPhone14,4': 5.4, // iPhone 13 mini
      'iPhone14,5': 6.1, // iPhone 13
      'iPhone14,6': 5.4, // iPhone SE (3rd)
      'iPhone14,7': 6.1, // iPhone 14
      'iPhone14,8': 6.7, // iPhone 14 Plus
      'iPhone15,2': 6.1, // iPhone 14 Pro
      'iPhone15,3': 6.7, // iPhone 14 Pro Max
      'iPhone15,4': 6.1, // iPhone 15
      'iPhone15,5': 6.7, // iPhone 15 Plus
      'iPhone16,1': 6.3, // iPhone 15 Pro
      'iPhone16,2': 6.9, // iPhone 15 Pro Max
      'iPhone17,1': 6.3, // iPhone 16
      'iPhone17,2': 6.3, // iPhone 16 Pro
      'iPhone17,3': 6.9, // iPhone 16 Pro Max
      'iPhone17,4': 6.3, // iPhone 16 Plus
    };
    return sizeMap[model];
  }
}
