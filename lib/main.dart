import 'package:cctalk/Global.dart';
import 'package:cctalk/page/launcher_page.dart';
import 'package:cctalk/util/share_util.dart';
import 'package:cctalk/value/colors.dart';
import 'package:cctalk/value/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

/// 全局导航context
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

///
void _initApp()async{
  //
  await ShareUtil.initSP();
  //
  RongcloudImPlugin.init(Global.IM_APP_KEY);
}

/// 启动入口
void main() {
  // provider 设置
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();

  // 强制竖屏
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  //app状态栏设置
  SystemChrome.setSystemUIOverlayStyle(
//    Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    SystemUiOverlayStyle.dark,
  );

  _initApp();

  runApp(TalkApp());
}

///
class TalkApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: colors.app_color,
        accentColor: colors.app_color,
        backgroundColor: colors.background_color,
        unselectedWidgetColor: colors.un_select_color,
        disabledColor: colors.disabled_color,
        dividerColor: colors.divide_color,
        textTheme: TextTheme(
          title: TextStyle(fontSize: dimens.font_size_title),
          button: TextStyle(fontSize: dimens.font_size),
          caption: TextStyle(
            fontSize: dimens.font_size,
            color: colors.text_black,
          ),
          subhead: TextStyle(textBaseline: TextBaseline.alphabetic),
        ),
      ),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        // 下面两个是Material widgets的delegate, 包含中文
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
//        const Locale('en', 'US'), // English
        const Locale('zh', 'Hans'), // China
        const Locale('zh', ''), // China
      ],
      // 关闭debug图标
      debugShowCheckedModeBanner: false,
      home: LauncherPage(),
    );
  }
  
}

