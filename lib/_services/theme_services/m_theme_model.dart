import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ThemeModel {
  Color primary;
  Color primarySoft;
  Color primaryAccent;
  Color primaryOver;
  Color background1;
  Color background2;
  Color disableColor;
  Color text1;
  Color text2;
  Color secondaryAccent;
  Color redDanger;
  Color yellowWarning;
  Color greenSuccess;
  LinearGradient bgGradient1;
  Color borderGray;
  Color icon;
  Color userIcon;
  Color mgmtIcon;

  ThemeModel(
      {required this.primary,
      required this.primarySoft,
      required this.primaryAccent,
      required this.primaryOver,
      required this.background1,
      required this.background2,
      required this.disableColor,
      required this.text1,
      required this.text2,
      required this.secondaryAccent,
      required this.greenSuccess,
      required this.redDanger,
      required this.yellowWarning,
      required this.bgGradient1,
      required this.borderGray,
      required this.icon,
      required this.userIcon,
      required this.mgmtIcon});

  Color getBgSoftColor() {
    return text1.withOpacity(0.1);
  }
}
