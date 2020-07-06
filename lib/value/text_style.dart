import 'package:cctalk/value/colors.dart';
import 'package:cctalk/value/dimens.dart';
import 'package:flutter/cupertino.dart';

/// 通用text样式
class CommonStyle extends TextStyle {
  final double fontSize;
  final FontStyle fontStyle;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final double height;

  const CommonStyle({
    this.fontSize = dimens.font_size,
    this.color = colors.text_black,
    this.decoration,
    this.fontFamily,
    this.fontWeight = FontWeight.normal,
    this.fontStyle,
    this.height,
  }) : super(
          fontSize: fontSize,
          color: color,
          decoration: decoration,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic,
          fontFamily: fontFamily,
          height: height,
        );
}

///
class TitleStyle extends TextStyle {
  final double fontSize;
  final FontStyle fontStyle;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  static TitleStyle titleStyle(){
    return TitleStyle(fontSize:dimens.font_size_title);
  }

  TitleStyle({
    this.fontSize,
    this.color = colors.text_black,
    this.decoration,
    this.fontFamily,
    this.fontWeight = dimens.bold,
    this.fontStyle,
  }) : super(
          fontSize: fontSize ?? dimens.font_size_title,
          color: color,
          decoration: decoration,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        );
}

///
class DescStyle extends TextStyle {
  final double fontSize;
  final FontStyle fontStyle;
  final String fontFamily;
  final Color color;

  const DescStyle({
    this.fontSize = dimens.font_size_des,
    this.color,
    this.fontFamily,
    this.fontStyle,
  }) : super(
          fontSize: fontSize,
          color: color,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
        );
}

///
class ImTextStyle extends TextStyle {
  final double fontSize;
  final FontStyle fontStyle;
  final String fontFamily;
  final Color color;

  const ImTextStyle({
    this.fontSize = dimens.font_size,
    this.color = colors.text_black,
    this.fontFamily,
    this.fontStyle,
  }) : super(
          fontSize: fontSize,
          color: color,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
        );
}
