import 'package:cctalk/value/colors.dart';
import 'package:cctalk/value/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// 公共按钮，带有渐变色背景
class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double minWidth;
  final double height;
  final double radius;
  final bool enabled;

  /// 是服务商
  final bool isService;
  final EdgeInsetsGeometry padding;

  CommonButton({
    Key key,
    this.child,
    this.enabled = true,
    this.padding,
    this.radius,
    this.isService = false,
    this.onPressed,
    this.minWidth,
    this.height = dimens.btn_height,
  }) : super(key: key);

  //  this.textColor, //按钮文字颜色
  //  this.disabledTextColor, //按钮禁用时的文字颜色
  //  this.color, //按钮背景颜色
  //  this.disabledColor,//按钮禁用时的背景颜色
  //  this.highlightColor, //按钮按下时的背景颜色
  //  this.splashColor, //点击时，水波动画中水波的颜色
  //  this.colorBrightness,//按钮主题，默认是浅色主题
  //  this.padding, //按钮的填充
  //  this.shape, //外形
  //  @required this.child, //按钮的内容
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: colors.app_color,
        borderRadius: BorderRadius.circular(radius ?? dimens.radius),
      ),
      child: MaterialButton(
        padding: padding,
        textColor: Colors.white,
        onPressed: enabled ? onPressed : null,
        minWidth: minWidth,
        height: height,
        child: child,
        disabledColor: colors.disable_btn_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? dimens.radius),
        ),
      ),
    );
  }
}

/// 普通圆角按钮
class ShapeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double minWidth;
  final double height;
  final double radius;
  final Color color;
  final bool enabled;

  /// 是服务商
  final bool isService;
  final EdgeInsetsGeometry padding;

  ShapeButton({
    Key key,
    this.color = colors.app_color,
    this.child,
    this.enabled = true,
    this.padding,
    this.radius = dimens.radius,
    this.isService = false,
    this.onPressed,
    this.minWidth,
    this.height = dimens.btn_height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? dimens.radius),
      ),
      child: MaterialButton(
        padding: padding,
        textColor: Colors.white,
        onPressed: enabled ? onPressed : null,
        minWidth: minWidth,
        height: height,
        child: child,
        elevation: 0,
        disabledColor: colors.disable_btn_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? dimens.radius),
        ),
      ),
    );
  }
}

/// 边框按钮
class BorderButton extends MaterialButton {
  final VoidCallback onPressed;
  final Widget child;
  final double minWidth;
  final double height;
  final double radius;
  final Color borderColor;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  BorderButton({
    Key key,
    this.child,
    this.onPressed,
    this.minWidth,
    this.radius = dimens.radius,
    this.color = Colors.white,
    this.height = dimens.btn_height,
    this.borderColor = colors.app_color,
    this.textColor = colors.app_color,
    this.padding,
  }) : super(
          key: key,
          color: color,
          textColor: textColor,
          onPressed: onPressed,
          minWidth: minWidth,
          padding: padding,
          height: height,
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(width: 1, color: borderColor),
          ),
        );
}

/// 图片按钮(只有图片，没有文字)
class ImageButton extends OutlineButton {
//  RawMaterialButton button;
  final VoidCallback onPressed;
  final String imgUri;
  final EdgeInsetsGeometry padding;

//  final double minWidth;
//  final double height;
  final Color color;
  final Color backgroundColor;
  final BoxFit fit;
  final double imgSize;

  ImageButton({
    Key key,
    this.imgUri,
    this.backgroundColor = Colors.white,
    this.padding,
    this.color,
    this.fit = BoxFit.cover,
    this.onPressed,
    this.imgSize,
//    this.minWidth,
//    this.height = dimens.btn_height,
  }) : super(
          key: key,
          onPressed: onPressed,
          textColor: color,
          borderSide: BorderSide.none,
          color: backgroundColor,
          padding: padding,
          child: Image.asset(imgUri,
              fit: fit, color: color, width: imgSize, height: imgSize),
//          height: height,
//          elevation: 0,
//          highlightElevation: 0,
        );
}

/// 用于展示标题右侧的action按钮
class ActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  ActionButton({Key key, this.child, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: dimens.title_height,
        height: dimens.title_height,
        alignment: Alignment.center,
        child: child,
      ),
      onTap: onPressed,
    );
  }
}

/// 普通的按钮，无渐变，无圆角
class NormalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color color;

  NormalButton({
    Key key,
    this.child,
    this.onPressed,
    this.width,
    this.height = dimens.btn_height_min,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        color: color,
        child: Container(
          color: color,
          width: width,
          height: height,
          alignment: Alignment.center,
          child: child,
        ),
      ),
      onTap: onPressed,
    );
  }
}
