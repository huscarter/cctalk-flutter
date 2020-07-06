import 'dart:io';
import 'package:cctalk/Global.dart';
import 'package:cctalk/mode/bean/base_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'session_manager.dart';
import 'net_config.dart';

/// 网络请求类
class Request {
  static const String tag = "Request";

  static Request _instance;
  static Dio _dio;

  /// 私有构造
  Request._();

  static Request init() {
    if (_instance == null) {
      _instance = Request._();
    }
    return _instance;
  }

  /// 当用户更换了角色之后需要重新生成网络请求
  ///
  /// 目前移动app的角色相对后台都是06，所以可以不用调用此方法
  static clearNet() {
    _dio?.close(force: true);
    _dio?.clear();
    _dio = null;
  }

  ///获取通用网络请求
  static Dio create() {
    if (_dio == null) {
      _dio = Dio();
      // 设置网络配置和header
      _dio.options = RequestOption().getOptions(NetConfig.BASE_URL);
      // 设置cookie
      _dio.interceptors.add(SessionManager.getInstance().cookieManager);
      _dio.interceptors.add(getErrorLog());
      if (Global.DEBUG) {
        _dio.interceptors.add(getLog());
      }
    }
    return _dio;
  }

  /// 设置log
  static LogInterceptor getLog() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
    );
  }

  /// 设置全局的error拦截
  static InterceptorsWrapper getErrorLog() {
    RequestOptions tempOptions;
    return InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      tempOptions = options;
      return options; //continue
    }, onResponse: (Response response) async {
      // Do something with response data
      Map<String, dynamic> data = response.data;

      if (BaseBean.fromJson(data).code != NetConfig.OK) {
        debugPrint("$tag error:$data");
      }
      return response; // continue
    }, onError: (DioError e) async {
      return e; //continue
    });
  }
}

/// 网络配置
class RequestOption {
  RequestOption();

  BaseOptions getOptions(String baseUrl) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: NetConfig.CONNECTION_TIME_OUT,
      receiveTimeout: NetConfig.RECEIVE_TIME_OUT,
      sendTimeout: NetConfig.SEND_TIME_OUT,
      headers: getHeaders(),
      contentType: NetConfig.CONTENT_TYPE_JSON,
    );
  }

  /// 生成header
  Map<String, dynamic> getHeaders() {
    Map<String, dynamic> headers = Map();
    headers.putIfAbsent("platform", () => Platform.isIOS ? "ios" : "android");
    return headers;
  }
}
