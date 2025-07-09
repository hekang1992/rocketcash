import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static const String _boxName = 'user_data_box';
  static const String _phoneKey = 'user_phone';
  static const String _tokenKey = 'user_token';
  static const String _clickGuideKey = '_clickguide_key';
  static const String _loginStartTime = '_loginStartTime';
  static const String _nettype = '_nettype';
  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  /// 保存是否点击引导页面
  static Future<void> saveClick(String guideStr) async {
    await _box?.put(_clickGuideKey, guideStr);
  }

  /// 获取引导页面
  static String? getClick() {
    return _box?.get(_clickGuideKey);
  }

  /// 保存用户手机号
  static Future<void> savePhone(String phone) async {
    await _box?.put(_phoneKey, phone);
  }

  /// 获取用户手机号
  static String? getPhone() {
    return _box?.get(_phoneKey);
  }

  /// 保存登录时间
  static Future<void> saveloginTime(String time) async {
    await _box?.put(_loginStartTime, time);
  }

  /// 获取登录时间
  static String? getloginTime() {
    return _box?.get(_loginStartTime);
  }

  /// 保存用户 token
  static Future<void> saveToken(String token) async {
    await _box?.put(_tokenKey, token);
  }

  /// 获取用户 token
  static String? getToken() {
    return _box?.get(_tokenKey);
  }

  /// 保存网络类型呢
  static Future<void> savenet(String nettype) async {
    await _box?.put(_nettype, nettype);
  }

  /// 获取网络类型
  static String? getnet() {
    return _box?.get(_nettype);
  }

  /// 同时保存手机号和 token
  static Future<void> saveUserData({
    required String phone,
    required String token,
  }) async {
    await Future.wait([savePhone(phone), saveToken(token)]);
  }

  /// 获取所有用户数据
  static Map<String, String?> getUserData() {
    return {'phone': getPhone(), 'token': getToken()};
  }

  /// 清除手机号
  static Future<void> clearPhone() async {
    await _box?.delete(_phoneKey);
  }

  /// 清除 token
  static Future<void> clearToken() async {
    await _box?.delete(_tokenKey);
  }

  /// 清除 login1
  static Future<void> clearLoginTime() async {
    await _box?.delete(_loginStartTime);
  }

  /// 清除 网络类型
  static Future<void> clearnettype() async {
    await _box?.delete(_nettype);
  }

  /// 清除所有用户数据
  static Future<void> clearAll() async {
    await _box?.clear();
  }

  /// 检查是否已登录（是否有token）
  static bool isLoggedIn() {
    return getToken() != null;
  }

  /// 检查点击了引导页
  static bool isClick() {
    return getClick() != null;
  }

  /// 关闭 Hive 盒子（在应用退出时调用）
  static Future<void> close() async {
    await _box?.close();
  }
}
