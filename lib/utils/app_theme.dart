import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTheme {
  // 颜色
  // 63bbd0 1661ab  景泰蓝 2775b6
  static const Color mainColor = Color(0xFF2775b6);
  static const Color hintColor = Color(0xFFA8ABB2);
  static const Color enabledColor = Color(0xFFe5e6eb);
  static const Color dangerColor = Color(0xFFf03752);
  static const Color warnColor = Color(0xFFfcc307);
  static const Color successColor = Color(0xFF43b244); // 43b244
  static const Color lakeColor = Color(0x192775b6);
  static const Color dividerColor =
      Color(0xffDDDDDD); // #9B9097  #F0F2F7 #DDDDDD

  static const Color defaultContentTextColor = Color(0xFF606266); // 默认输入框内容字体颜色
  static const Color errorContentTextColor =
      Color(0xFFf03752); // 错误时的颜色   海棠红 f03752

  static const double defaultWindowTitleHeight = 40; // 窗体标题高度

  // 字体
  static const double defaultFontSize = 12; // 字体大小
  static const double fontSize_15 = 15; // 字体大小
  static const double fontSize_16 = 16; // 字体大小
  static const double fontSize_17 = 17; // 字体大小
  static const double fontSize_18 = 18; // 字体大小
  static const String defaultFontFamily = '微软雅黑'; // 默认字体
  static const FontWeight defaultFontWeight = FontWeight.w400;

  static const double defaultTextFieldHeight = 30; // 输入框高度
  static const double defaultAppBarHeight = 40; // 标题高度
  static BorderRadiusGeometry defaultRadius = BorderRadius.circular(4); // 默认圆角

  static const AppBarTheme appBarTheme = AppBarTheme(
    toolbarHeight: AppTheme.defaultAppBarHeight,
    titleTextStyle: TextStyle(
      fontSize: AppTheme.defaultFontSize,
      fontWeight: defaultFontWeight,
      fontFamily: AppTheme.defaultFontFamily,
    ),
    backgroundColor: AppTheme.mainColor,
  );

  static const defaultTextStyle = TextStyle(
    fontSize: AppTheme.defaultFontSize,
    fontFamily: AppTheme.defaultFontFamily,
    color: AppTheme.defaultContentTextColor,
  );

  static TextStyle sizeTextStyle(double size,
      {Color color = AppTheme.defaultContentTextColor}) {
    return TextStyle(
      fontSize: size,
      fontFamily: AppTheme.defaultFontFamily,
      color: color,
    );
  }

  static const lightTextStyle = TextStyle(
    fontSize: AppTheme.defaultFontSize,
    fontFamily: AppTheme.defaultFontFamily,
    color: Colors.white,
  );

  static const EdgeInsetsGeometry defaultButtonPadding =
      EdgeInsets.symmetric(horizontal: 14, vertical: 14); // 默认内边距

  static const EdgeInsetsGeometry repoItemMargin =
      EdgeInsets.symmetric(horizontal: 10, vertical: 5); // 默认内边距

  static const EdgeInsetsGeometry defaultTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 8, vertical: 10); //

  static const BorderRadius mainRadius = BorderRadius.all(Radius.circular(2)); // 圆角
}

class Resources {
  static SvgPicture delete = SvgPicture.asset('assets/svg/delete.svg');
  static SvgPicture edit = SvgPicture.asset('assets/svg/edit.svg');
  static SvgPicture cancel = SvgPicture.asset('assets/svg/cancel.svg');
  static SvgPicture stop({Color color = AppTheme.dangerColor}) {
    return SvgPicture.asset(
      'assets/svg/stop.svg',
      // ignore: deprecated_member_use
      color: color,
    );
  }

  static SvgPicture cancel2(
      {Color color = AppTheme.successColor, double size = 10}) {
    return SvgPicture.asset(
      'assets/svg/cancel.svg',
      // ignore: deprecated_member_use
      color: color,
      width: size,
      height: size,
    );
  }

  static SvgPicture start({Color color = AppTheme.successColor}) {
    return SvgPicture.asset(
      'assets/svg/start.svg',
      // ignore: deprecated_member_use
      color: color,
    );
  }

  static SvgPicture restart({Color color = AppTheme.successColor}) {
    return SvgPicture.asset(
      'assets/svg/restart.svg',
      // ignore: deprecated_member_use
      color: color,
    );
  }
}
