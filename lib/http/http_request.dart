import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rocketcash/http/login_info.dart';

class GetApiUrlManager {
  Future<String?> buildApiUrl() async {
    String baseurl = '';
    Map<String, String> dict = await LoginInfoManager.getLoginInfo();
    String? apiUrl = URLParameterHelper.appendQueryParameters(baseurl, dict);
    return apiUrl;
  }
}

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  late Dio _dio;

  HttpService._internal();

  // 异步初始化方法
  Future<void> init() async {
    String? apiUrl = await GetApiUrlManager().buildApiUrl();
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl ?? '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    _dio = Dio(options);
  }

  Dio get dio => _dio;

  // GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // POST JSON 请求
  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return await _dio.post(path, data: data);
  }

  // POST 表单请求
  Future<Response> postForm(String path, Map<String, dynamic> formData) async {
    final form = FormData.fromMap(formData);
    return await _dio.post(
      path,
      data: form,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  // 上传单张图片 + 可选参数
  Future<Response> uploadImage(
    String path,
    File imageFile, {
    Map<String, dynamic>? additionalData,
    String fileField = 'file',
  }) async {
    String fileName = imageFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      fileField: await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
      ...?additionalData,
    });

    return await _dio.post(path, data: formData);
  }
}
