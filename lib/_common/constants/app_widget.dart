import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import '../../_services/theme_services/m_theme_model.dart';
import 'app_constants.dart';
import 'app_functions.dart';

class AppWidgets {
  // Widget logoWidget({Color carColor = Colors.grey}) {
  //   return LayoutBuilder(
  //     builder: (c1, c2) {
  //       final shortestSide = min(c2.maxHeight, c2.maxWidth);
  //       return Container(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: shortestSide * 0.25,
  //           vertical: shortestSide * 0.25,
  //         ),
  //         child: Image.asset(
  //           color: carColor,
  //           fit: BoxFit.contain,
  //         ),
  //       );
  //     },
  //   );
  // }

  static InputBorder getOutlineInputBorder(ThemeModel theme){
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: theme.text2.withOpacity(0.2),
            width: 2
        ),
        borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
    );
  }

  static Widget appTextField({
    required ThemeModel theme,
    required TextEditingController txtCtrl,
    required String label,
    bool xObscured = false,
    List<TextInputFormatter> inputFormatters = const [],
    TextInputType keyboardType = TextInputType.text,
    EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 10)
  }){
    return Padding(
      padding: margin,
      child: TextField(
        controller: txtCtrl,
        decoration: InputDecoration(
            border: AppConstants.baseOutlineInputBorder,
            enabledBorder: AppConstants.baseOutlineInputBorder,
            label: Text(
              label,
              style: TextStyle(
                  color: theme.text1
              ),
            )
        ),
        style: TextStyle(
          color: theme.text1
        ),
        obscureText: xObscured,
        inputFormatters: inputFormatters,
        cursorColor: theme.primary,
        keyboardType: keyboardType,
        onTapOutside: (event) {
          vibrateNow();
          dismissKeyboard();
        },
      ),
    );
  }

}
