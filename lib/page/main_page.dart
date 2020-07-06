import 'package:cctalk/Global.dart';
import 'package:cctalk/page/base_page.dart';
import 'package:cctalk/util/common_util.dart';
import 'package:cctalk/util/page_util.dart';
import 'package:cctalk/util/share_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("Main page"),
      ),
      body: Center(
        child: Text("还在开发 ..."),
      ),
    );
  }
}
