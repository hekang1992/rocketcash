import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rocketcash/http/login_info.dart';

const String h5Host = 'http://8.212.151.134:10393';

class GetApiUrlManager {
  Future<String?> buildApiUrl() async {
    String baseurl = '$h5Host/rocketcashapi';
    return baseurl;
  }
}

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  late Dio _dio;

  HttpService._internal();

  // 异步初始化方法
  Future<void> init() async {
    String? baseUrl = await GetApiUrlManager().buildApiUrl();
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    _dio = Dio(options);

    // 添加日志拦截器，方便调试
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print(obj),
      ),
    );

    await _configureProxy();
  }

  Dio get dio => _dio;

  // 配置代理
  Future<void> _configureProxy() async {
    // 替换为你的电脑IP和Proxyman的端口
    // String proxyIP = "10.1.1.58";
    String proxyIP = "192.168.71.88";
    String proxyPort = "9090";

    if (proxyIP.isNotEmpty) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (uri) {
          return 'PROXY $proxyIP:$proxyPort';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  // GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Map<String, String> dict = await LoginInfoManager.getLoginInfo();
    String? apiUrl = URLParameterHelper.appendQueryParameters(path, dict) ?? '';
    return await _dio.get(apiUrl, queryParameters: queryParameters);
  }

  // POST JSON 请求
  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    Map<String, String> dict = await LoginInfoManager.getLoginInfo();
    String? apiUrl = URLParameterHelper.appendQueryParameters(path, dict) ?? '';
    return await _dio.post(apiUrl, data: data);
  }

  // POST 表单请求
  Future<Response> postForm(String path, Map<String, dynamic> formData) async {
    final form = FormData.fromMap(formData);
    Map<String, String> dict = await LoginInfoManager.getLoginInfo();
    String? apiUrl = URLParameterHelper.appendQueryParameters(path, dict) ?? '';
    return await _dio.post(
      apiUrl,
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
