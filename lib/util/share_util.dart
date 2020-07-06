import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreference 单例
class ShareUtil {
  static SharedPreferences _share;

  /// 私有构造函数
  ShareUtil._();

  /// 获取实例
  /// 调用此方法前请确保[initSP]方法执行完
  static SharedPreferences getInstance() {
    return _share;
  }

  /// 初始化，请于app开启时调用
  static Future<SharedPreferences> initSP() async {
    if (_share == null) {
      _share = await SharedPreferences.getInstance();
    }
    return _share;
  }
}
