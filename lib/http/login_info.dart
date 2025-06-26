import 'package:device_info_plus/device_info_plus.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:rocketcash/hive/save_info.dart';

class LoginInfoManager {
  static Future<Map<String, String>> getLoginInfo() async {
    await HiveStorage.init();
    final loginInfo = await DeviceInfoPlugin().iosInfo;
    var token = HiveStorage.getToken() ?? '';
    return {
      'qian': 'ios',
      'sima': '1.0.0',
      'goal': loginInfo.utsname.machine.iOSProductName,
      'lifes': loginInfo.identifierForVendor ?? '',
      'perform': loginInfo.systemVersion,
      'deal': 'recketcashapi',
      'blow': token,
      'heavy': loginInfo.identifierForVendor ?? '',
    };
  }
}

class URLParameterHelper {
  static String? appendQueryParameters(
    String url,
    Map<String, String> parameters,
  ) {
    Uri? uri = Uri.tryParse(url);
    if (uri == null) return null;

    final existingQueryParams = Map<String, String>.from(uri.queryParameters);
    final allParams = {...existingQueryParams, ...parameters};

    final newUri = uri.replace(queryParameters: allParams);
    return newUri.toString();
  }
}
