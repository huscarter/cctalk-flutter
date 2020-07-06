import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

/// cookie 单例
class SessionManager {
  static SessionManager _instance;
  CookieManager cookieManager;

  SessionManager._();

  static SessionManager getInstance() {
    if (_instance == null) {
      _instance = SessionManager._();
    }
    return _instance;
  }

  /// cookie初始化，推荐在app启动时调用
  void init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar = PersistCookieJar(dir: "$appDocPath/.cookies/");
    cookieManager = CookieManager(cookieJar);
  }

  /// 根据请求的url获取响应的cookie
  String getCookies(String url){
    var cookies = cookieManager.cookieJar.loadForRequest(Uri.parse(url));
    cookies.removeWhere((cookie) {
      if (cookie.expires != null) {
        return cookie.expires.isBefore(DateTime.now());
      }
      return false;
    });
    String cookie = _getCookieStr(cookies);
    return cookie;
  }

  String _getCookieStr(List<Cookie> cookies) {
    return cookies.map((cookie) => "${cookie.name}=${cookie.value}").join('; ');
  }
}
