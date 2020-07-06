import 'dart:async';
import 'package:cctalk/Global.dart';
import 'package:cctalk/value/colors.dart';
import 'package:cctalk/value/dimens.dart';
import 'package:cctalk/value/strings.dart';
import 'package:cctalk/value/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
EdgeInsets _getCommonEdgeInsets(){
  return EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 2);
}

/// 项目输入框定义类
/// 右侧删除按钮
class MaterialDelBtn extends IconButton {
  final VoidCallback onDelete;

  MaterialDelBtn({Key key, this.onDelete})
      : super(
          key: key,
          onPressed: onDelete,
          padding: EdgeInsets.only(left: 15),
          icon: Icon(
            Icons.cancel,
            size: dimens.icon_size,
            color: colors.text_gray,
          ),
        );
}

/// 删除btn
class DeleteButton extends Container {
  final double width;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;

  DeleteButton({
    Key key,
    this.width = dimens.title_height - dimens.edit_padding * 2,
    this.color = Colors.transparent,
    this.height = dimens.title_height - 13,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.only(top: 0),
  }) : super(
          key: key,
          padding: padding,
          margin: margin,
          height: height,
          alignment: Alignment.center,
          color: color,
          width: width,
          child: Icon(
            Icons.cancel,
            size: dimens.icon_size,
            color: colors.icon_gray,
          ),
        );
}

/// 普通输入框的样式
class CommonInputDecoration extends InputDecoration {
  final String hintText;
  final VoidCallback onDelete;
  final Color fillColor;
  final bool filled;
  final InputBorder border;
  final Widget prefixIcon;

  CommonInputDecoration({
    this.hintText,
    this.onDelete,
    this.border,
    this.filled = false,
    this.fillColor = Colors.transparent,
    this.prefixIcon,
  }) : super(
          hintText: hintText,
          filled: filled,
          fillColor: fillColor,
          contentPadding: _getCommonEdgeInsets(),
          prefixIcon:prefixIcon,
          border: border ??
              UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: colors.divide_color,
                ),
              ),
          enabledBorder: border ??
              UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: colors.divide_color,
                ),
              ),
          focusedBorder: border ??
              UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: colors.divide_color,
                ),
              ),
          hintStyle: TextStyle(color: colors.text_hint),
          suffix: GestureDetector(
            child: DeleteButton(),
            onTap: onDelete,
            behavior: HitTestBehavior.opaque,
          ),
        );
}

/// 通用输入框
class CommonTextField extends TextField {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final VoidCallback onDelete;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool filled;
  final Color fillColor;
  final InputBorder border;
  final bool autofocus;

  CommonTextField({
    Key key,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.style = const CommonStyle(),
    this.focusNode,
    this.hintText,
    this.onDelete,
    this.autofocus = false,
    this.fillColor,
    this.filled,
    this.border,
    this.keyboardType,
    this.inputFormatters,
  }) : super(
          key: key,
          controller: controller,
          textInputAction: textInputAction,
          focusNode: focusNode,
          style: style,
          autofocus:autofocus,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: CommonInputDecoration(
            hintText: hintText,
            onDelete: onDelete,
            border: border,
            filled: filled,
            fillColor: fillColor,
          ),
        );
}

/// 手机号输入框
class PhoneTextField extends TextField {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final VoidCallback onDelete;
  final Color fillColor;
  final FocusNode focusNode;
  final bool filled;
  final Widget prefixIcon;

  PhoneTextField({
    Key key,
    this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.style = const CommonStyle(),
    this.hintText,
    this.filled,
    this.fillColor,
    this.onDelete,
    this.prefixIcon,
  }) : super(
          key: key,
          controller: controller,
          textInputAction: textInputAction,
          style: style,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
            LengthLimitingTextInputFormatter(Global.MAX_PHONE), //限制长度
          ],
          decoration: CommonInputDecoration(
            prefixIcon:prefixIcon,
            hintText: hintText,
            onDelete: onDelete,
            fillColor: fillColor,
            filled: filled,
          ),
        );
}

/// 短信验证码输入框，包含获取验证码的点击回调和倒计时
class SmsTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final FocusNode focusNode;
  final Brightness keyboardAppearance;
  final VoidCallback onDelete;
  final AsyncValueGetter<bool> onSmsClick;
  final bool smsEnable;
  final ValueChanged<String> onChanged;
  final Color fillColor;
  final bool filled;
  final bool showSplit;
  final Widget prefixIcon;
  final TextAlign textAlign;
  final double smsFontSize;
  final double smsWidth;

  SmsTextField({
    Key key,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.smsEnable = false,
    this.focusNode,
    this.hintText,
    this.style = const CommonStyle(),
    this.onDelete,
    this.onChanged,
    this.filled,
    this.fillColor,
    this.onSmsClick,
    this.textAlign = TextAlign.left,
    this.showSplit = true,
    this.keyboardAppearance = Brightness.light,
    this.prefixIcon,
    this.smsFontSize,
    this.smsWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimens.item_height,
      alignment: Alignment.centerLeft,
      child: SmsEdit(
        controller: controller,
        textInputAction: textInputAction,
        style: style,
        hintText: hintText,
        onDelete: onDelete,
        fillColor: fillColor,
        focusNode: focusNode,
        onChanged: onChanged,
        filled: filled,
        prefixIcon: prefixIcon,
        textAlign: textAlign,
        suffixIcon: Container(
          width: smsWidth??dimens.sms_width,
          height: dimens.title_height-1,
          alignment: Alignment.centerRight,
          child: SmsText(
            onSmsPressed: onSmsClick,
            enable: smsEnable,
            fontSize: smsFontSize,
            showSplit: showSplit,
          ),
        ),
      ),
    );
  }
}

/// 短信验证码子组件
/// 服务于[SmsTextField]组件
class SmsEdit extends TextField {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final VoidCallback onDelete;
  final String hintText;
  final Color fillColor;
  final FocusNode focusNode;
  final bool filled;
  final ValueChanged<String> onChanged;
  final Widget prefixIcon;
  final TextAlign textAlign;
  final Widget suffixIcon;

  SmsEdit({
    Key key,
    this.controller,
    this.textInputAction,
    this.style,
    this.onChanged,
    this.filled,
    this.focusNode,
    this.fillColor,
    this.onDelete,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
    this.hintText,
    this.suffixIcon,
  }) : super(
          key: key,
          textAlign: textAlign,
          controller: controller,
          textInputAction: textInputAction,
          style: style,
          onChanged: onChanged,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: <TextInputFormatter>[
//            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
            LengthLimitingTextInputFormatter(Global.MAX_SMS) //限制长度
          ],
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: filled,
            prefixIcon: prefixIcon,
            contentPadding: _getCommonEdgeInsets(),
            suffix: GestureDetector(
              child: DeleteButton(),
              onTap: onDelete,
              behavior: HitTestBehavior.opaque,
            ),
            hintText: hintText,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            hintStyle: TextStyle(color: colors.text_hint),
            suffixIcon: suffixIcon,
          ),
        );
}

/// 短信验证码计数组件
/// 服务于[SmsTextField]组件
class SmsText extends StatefulWidget {
  /// 按钮是否可以点击
  final bool enable;

  /// 点击时间
  final AsyncValueGetter<bool> onSmsPressed;

  /// 提示信息[preHint]59s
  final String preHint;

  /// 提示信息在前还是在后isPreLeft==true:[preHint]59s,isPreLeft==false:59s[preHint]
  final bool isPreLeft;

  final double fontSize;

  final bool showSplit;

  SmsText({
    Key key,
    this.enable = false,
    this.onSmsPressed,
    this.preHint = "倒计时",
    this.isPreLeft = true,
    this.showSplit = true,
    this.fontSize = dimens.font_size_item,
  }) : super(key: key);

  State createState() => _SmsTextState();
}

class _SmsTextState extends State<SmsText> {
  Timer timer;
  int timeCount = 60;
  bool afterClick = false;
  String text = strings.get_sms_code;

  @override
  void initState() {
    super.initState();
  }

  void _setState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return buildText();
  }

  Widget buildText() {
    if (afterClick) {
      if (widget.showSplit) {
        return Text.rich(TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "|  ",
              style: TextStyle(
                color: colors.divide_color,
                fontSize: dimens.font_size_hit,
              ),
            ),
            TextSpan(
              text: text,
              style: CommonStyle(
                color: colors.text_disable,
                fontSize: widget.fontSize,
              ),
            ),
          ],
        ));
      }
      return Text(
        text,
        style: CommonStyle(
          color: colors.text_disable,
          fontSize: widget.fontSize,
        ),
      );
    } else {
      Color color = widget.enable ? colors.app_color : colors.text_disable;
      Widget tempWidget;
      if (widget.showSplit) {
        tempWidget = Text.rich(TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "|  ",
              style: TextStyle(
                color: colors.divide_color,
                fontSize: dimens.font_size_hit,
              ),
            ),
            TextSpan(
              text: text,
              style: CommonStyle(color: color, fontSize: widget.fontSize),
            ),
          ],
        ));
      } else {
        tempWidget = Text(
          text,
          style: CommonStyle(color: color, fontSize: widget.fontSize),
        );
      }
      return GestureDetector(
        child: tempWidget,
        onTap: widget.enable
            ? () {
                afterClick = !afterClick;
                _startTimer();
                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  _startTimer();
                });
                if (widget.onSmsPressed != null) {
                  widget.onSmsPressed().then((result) {
                    if (!result) {
                      _reset();
                    }
                  });
                }
              }
            : () {},
      );
    }
  }

  void _startTimer() {
    timeCount--;
    text = widget.isPreLeft
        ? "${widget.preHint}${timeCount}s"
        : "${timeCount}s${widget.preHint}";
    if (timeCount == 0) {
      _reset();
    } else {
      _setState();
    }
  }

  void _reset() {
    timeCount = 60;
    afterClick = !afterClick;
    text = strings.get_sms_code;
    timer?.cancel();
    _setState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

/// 密码输入框
class PwdTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final VoidCallback onDelete;
  final FocusNode focusNode;
  final Color fillColor;
  final bool filled;
  final bool showSecret;
  final Widget prefixIcon;
  final TextAlign textAlign;
  final double suffixIconSize;

  PwdTextField({
    Key key,
    this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.style,
    this.onDelete,
    this.showSecret = true,
    this.filled,
    this.fillColor,
    this.hintText,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
    this.suffixIconSize = dimens.icon_size,
  }) : super(key: key);

  @override
  State createState() => _PwdTextFieldState();
}

class _PwdTextFieldState extends State<PwdTextField> {
  bool showPwd = false;

  @override
  void initState() {
    super.initState();
  }

  Image _getImage(bool showPwd) {
    if (showPwd) {
      return Image.asset("assets/images/icon_pwd_open.png");
    } else {
      return Image.asset("assets/images/icon_pwd_close.png");
    }
  }

  void _setState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimens.item_height,
      alignment: Alignment.centerLeft,
      child: PwdEdit(
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        style: widget.style,
        hintText: widget.hintText,
        obscureText: !showPwd,
        onDelete: widget.onDelete,
        showSecret: widget.showSecret,
        fillColor: widget.fillColor,
        filled: widget.filled,
        prefixIcon: widget.prefixIcon,
        textAlign: widget.textAlign,
        suffixIcon: widget.showSecret
            ? GestureDetector(
                child: Container(
                  child: _getImage(showPwd),
                  width: widget.suffixIconSize,
                  height: dimens.title_height - 1,
                ),
                onTap: () {
                  showPwd = !showPwd;
                  _setState();
                },
              )
            : null,
      ),
    );
  }
}

class PwdEdit extends TextField {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final VoidCallback onDelete;
  final FocusNode focusNode;
  final bool obscureText;
  final Color fillColor;
  final bool filled;
  final bool showSecret;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextAlign textAlign;

  PwdEdit({
    Key key,
    this.controller,
    this.textInputAction,
    this.focusNode,
    this.filled,
    this.fillColor,
    this.style,
    this.obscureText = true,
    this.onDelete,
    this.showSecret,
    this.hintText,
    this.textAlign,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(
          key: key,
          textAlign: textAlign,
          controller: controller,
          textInputAction: textInputAction,
          style: style,
          focusNode: focusNode,
          obscureText: obscureText,
          inputFormatters: <TextInputFormatter>[
            //[a-zA-Z]|[\u4e00-\u9fa5]|[0-9] 汉字或者字母或数字
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")), // 数字和字母
            LengthLimitingTextInputFormatter(Global.MAX_PASSWORD) //限制长度
          ],
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: filled,
            hintText: hintText,
            contentPadding: _getCommonEdgeInsets(),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: colors.divide_color,
              ),
            ),
            hintStyle: TextStyle(color: colors.text_hint),
            suffixIcon: suffixIcon,
            suffix: GestureDetector(
              child: DeleteButton(),
              onTap: onDelete,
              behavior: HitTestBehavior.opaque,
            ),
          ),
        );
}

/// 搜索输入框
class SearchTextField extends TextField {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final String hintText;
  final Color fillColor;
  final VoidCallback onDelete;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;

  SearchTextField({
    Key key,
    this.controller,
    this.textInputAction = TextInputAction.search,
    this.style,
    this.fillColor = Colors.white,
    this.onDelete,
    this.focusNode,
    this.hintText,
    this.onSubmitted,
  }) : super(
          key: key,
          onSubmitted: onSubmitted,
          controller: controller,
          textInputAction: textInputAction,
          style: style ?? TextStyle(fontSize: dimens.font_size),
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: _getCommonEdgeInsets(),
            prefixIcon: Image.asset("assets/images/icon_search.png"),
            hintText: hintText,
            hintStyle: TextStyle(
              color: colors.text_hint,
              fontSize: dimens.font_size_item,
            ),
            fillColor: fillColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: dimens.divide_height,
                color: colors.background_color,
              ),
              borderRadius: BorderRadius.circular(dimens.radius_search),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: dimens.divide_height,
                color: colors.background_color,
              ),
              borderRadius: BorderRadius.circular(dimens.radius_search),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: dimens.divide_height,
                color: colors.background_color,
              ),
              borderRadius: BorderRadius.circular(dimens.radius_search),
            ),
            suffix: GestureDetector(
              child: DeleteButton(),
              onTap: onDelete,
              behavior: HitTestBehavior.opaque,
            ),
          ),
        );
}

/// 搜索输入框引
class SearchView extends StatelessWidget {
  final double height;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final Color color;

  SearchView({
    Key key,
    this.height,
    this.padding,
    this.onPressed,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 0, color: colors.background_color),
          borderRadius: BorderRadius.all(Radius.circular(dimens.radius_search)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/icon_search.png"),
            SizedBox(width: dimens.margin_small),
            Text(
              strings.search,
              style: TextStyle(
                color: colors.text_hint,
                fontSize: dimens.font_size_item,
              ),
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}

/// 6位数输入框，兼容明文和密文
class SixEditText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextStyle style;
  final FocusNode focusNode;
  final bool filled;

  /// 是否密文
  final bool obscureText;
  final Color fillColor;
  final double width;
  final double dashHeight;
  final double dashWidth;
  final Color dashColor;
  final double dashMargin = 6;

  SixEditText({
    Key key,
    this.controller,
    this.textInputAction,
    this.style = const TextStyle(
      fontSize: 24,
      color: colors.text_black,
      fontWeight: dimens.bold,
      letterSpacing: 35,
    ),
    this.fillColor = Colors.transparent,
    this.focusNode,
    this.obscureText = false,
    this.filled = true,
    this.width = 330,
    this.dashHeight = 1,
    this.dashWidth = 37,
    this.dashColor = colors.divide_color,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: controller,
          textInputAction: textInputAction,
          style: style,
          focusNode: focusNode,
          obscureText: obscureText,
          showCursor: false,
          scrollPadding: EdgeInsets.all(0),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(Global.MAX_SMS) //限制长度
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            fillColor: fillColor,
            filled: filled,
            border: InputBorder.none,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: <Widget>[
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
              Container(
                width: dashWidth,
                height: dashHeight,
                margin: EdgeInsets.only(right: dashMargin, left: dashMargin),
                color: dashColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
