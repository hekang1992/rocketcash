import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rocketcash/http/http_request.dart';
import 'package:rocketcash/other/idfa/get_idfa.dart';

class LocationService {
  /// 获取当前地址信息（包含坐标与地址）
  static Future<Map<String, dynamic>> getDetailedLocation() async {
    // 检查定位服务
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('定位服务未开启');
    }

    // 权限检查
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('location error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('location erroe');
    }

    // 获取位置
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    // 逆地理编码：经纬度转地址
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception('locaton error');
    }

    final Placemark place = placemarks.first;

    return {
      'etern': position.latitude,
      'grant': position.longitude,
      'drowning': place.country,
      'grasping': place.isoCountryCode,
      'straw': place.administrativeArea,
      'divine': place.locality ?? place.subAdministrativeArea,
      'track': '${place.subLocality ?? ''} ${place.street ?? ''}',
    };
  }
}

class Uploadfindinginfo {
  static Future<void> scInfo({
    required String startTime,
    required String type,
    required String producdID,
  }) async {
    final putting = await DeviceIdentifierManager.getOrCreateDeviceIdentifier();
    final energy = await AppTrackingTransparency.getAdvertisingIdentifier();
    final endTiem = DateTime.now().millisecondsSinceEpoch.toString();
    final position = await LocationService.getDetailedLocation();
    final dict = {
      'glad': producdID,
      'access': type,
      'glowing': '',
      'putting': putting,
      'energy': energy,
      'grant': position['grant'],
      'etern': position['etern'],
      'absorb': startTime,
      'herbs': endTiem,
    };
    try {
      final _ = await HttpService().postForm('/computed/finding', dict);
    } catch (e) {}
  }
}
