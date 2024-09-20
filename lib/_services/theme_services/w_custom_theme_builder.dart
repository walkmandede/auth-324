import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'c_theme_controller.dart';
import 'm_theme_model.dart';

class MyThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeModel theme,
      ThemeController themeController) builder;
  final bool xRefreshSystemUiOverlay;
  const MyThemeBuilder(
      {super.key, required this.builder, this.xRefreshSystemUiOverlay = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return ValueListenableBuilder(
          valueListenable: themeController.currentTheme,
          builder: (context, theme, child) {
            if (xRefreshSystemUiOverlay) {
              SystemChrome.setSystemUIOverlayStyle(
                  themeController.xIsDarkTheme()
                      ? SystemUiOverlayStyle.light
                      : SystemUiOverlayStyle.dark);
            }
            return builder(context, theme, themeController);
          },
        );
      },
    );
  }
}
