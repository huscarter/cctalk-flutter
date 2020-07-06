import 'package:cctalk/Global.dart';
import 'package:cctalk/page/base_page.dart';
import 'package:cctalk/page/login_page.dart';
import 'package:cctalk/page/main_page.dart';
import 'package:cctalk/util/common_util.dart';
import 'package:cctalk/util/page_util.dart';
import 'package:cctalk/util/share_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
class LauncherPage extends BaseStatefulPage {
  @override
  State<StatefulWidget> createState() => _LauncherPageState();
}

class _LauncherPageState extends BaseState {
  @override
  void initState() {
    super.initState();
    //
    initShare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }

  ///
  void initShare() {
    ShareUtil.initSP().then((arg) {
      switchPage(context);
    });
  }

  ///
  void switchPage(BuildContext context) {
    if (CommonUtil.isEmpty(
        ShareUtil.getInstance().getString(Global.IM_TOKEN))) {
      PageUtil.startPageReplace(context, LoginPage());
    } else {
      PageUtil.startPageReplace(context, MainPage());
    }
  }
}

