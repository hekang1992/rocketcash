import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
        throw Exception('定位权限被拒绝');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('定位权限永久被拒绝');
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
      throw Exception('未能解析出地址');
    }

    final Placemark place = placemarks.first;

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'country': place.country,
      'countryCode': place.isoCountryCode,
      'province': place.administrativeArea,
      'city': place.locality ?? place.subAdministrativeArea,
      'district': place.subLocality,
      'street': place.street,
      'name': place.name,
    };
  }
}
