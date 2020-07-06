import 'package:cctalk/page/base_page.dart';
import 'package:cctalk/page/main_page.dart';
import 'package:cctalk/util/common_util.dart';
import 'package:cctalk/util/page_util.dart';
import 'package:cctalk/value/colors.dart';
import 'package:cctalk/value/dimens.dart';
import 'package:cctalk/value/strings.dart';
import 'package:cctalk/value/text_style.dart';
import 'package:cctalk/view/button.dart';
import 'package:cctalk/view/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends BaseStatelessPage {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();
  final FocusNode _blankFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("Login Page")),
      body: Column(
        children: <Widget>[
          SizedBox(height: 80),
          ClipOval(
            child: Container(
              height: 70,
              width: 70,
              color: colors.app_color,
              alignment: Alignment.center,
              child: Text(
                strings.app_name,
                style: CommonStyle(
                  fontWeight: dimens.bold,
                  fontSize: dimens.font_size_big,
                  color: colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          Padding(
            child: PhoneTextField(
              hintText: "Mobile",
              controller: _phoneController,
              filled: true,
              style: CommonStyle(
                fontSize: dimens.font_size,
              ),
              fillColor: colors.background_color,
              onDelete: () {
                _clearText(context, _phoneFocus, _phoneController);
              },
            ),
            padding: EdgeInsets.all(dimens.margin),
          ),
          Padding(
            child: PwdTextField(
              hintText: "Password",
              controller: _pwdController,
              showSecret: false,
              filled: true,
              style: CommonStyle(
                fontSize: dimens.font_size,
              ),
              fillColor: colors.background_color,
              onDelete: () {
                _clearText(context, _pwdFocus, _pwdController);
              },
            ),
            padding: EdgeInsets.all(dimens.margin),
          ),
          SizedBox(height: dimens.item_height),
          Padding(
            child: CommonButton(
              height: dimens.item_height,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: dimens.font_size,
                ),
              ),
              enabled: true,
              onPressed: () {
                PageUtil.startPageReplace(context, MainPage());
              },
              minWidth: double.infinity,
            ),
            padding: EdgeInsets.all(dimens.margin),
          ),
        ],
      ),
    );
  }

  ///
  void _clearText(
      BuildContext context, FocusNode focus, TextEditingController controller) {
    FocusScope.of(context).requestFocus(focus); // 获取焦点
    Future.delayed(Duration(milliseconds: 100)).then((arg) {
      controller.text = "";
    });
  }
}
