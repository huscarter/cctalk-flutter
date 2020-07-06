import 'package:cctalk/view/app_page_route.dart';
import 'package:flutter/material.dart';

///
class PageUtil {
  PageUtil._();

  /// 开启页面
  static Future<dynamic> startPage(BuildContext context, Widget page) {
//    return Navigator.of(context).push(PageRouteSlide(page));
    return Navigator.of(context)
        .push(CommonPageRoute(builder: (context) => page));
  }

  /// 开启页面
  /// 调用此方法会将栈中当前page push掉，再打开[page]
  static void startPageReplace(BuildContext context, Widget page) {
//    Navigator.of(context).pushReplacement(PageRouteSlide(page));
    Navigator.of(context)
        .pushReplacement(CommonPageRoute(builder: (context) => page));
  }

  /// 开启页面
  /// 调用此方法会将栈中page都push掉，再打开[page]
  static void startPageInstance(BuildContext context, Widget page) {
//    Navigator.of(context).pushAndRemoveUntil(PageRouteSlide(page), (route) => false);
    Navigator.of(context).pushAndRemoveUntil(
        CommonPageRoute(builder: (context) => page), (route) => false);
  }
}
