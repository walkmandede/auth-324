import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sp_services/sp_keys.dart';
import 'd_dark_theme_data.dart';
import 'd_light_theme_data.dart';
import 'm_theme_model.dart';

enum EnumAppTheme { light, dark }

class ThemeController extends GetxController {
  ValueNotifier<ThemeModel> currentTheme = ValueNotifier(DarkThemeData.theme);
  final ValueNotifier<EnumAppTheme> _currentAppThemEnum =
      ValueNotifier(EnumAppTheme.dark);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    _currentAppThemEnum.addListener(
      () {
        updateTheme();
      },
    );
    await Future.delayed(const Duration(microseconds: 10));
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final savedTheme = sharedPreferences.getString(SpKeys.enumCurrentTheme);
      if (savedTheme != null) {
        _currentAppThemEnum.value = EnumAppTheme.values
                .where(
                  (element) => element.name == savedTheme,
                )
                .firstOrNull ??
            EnumAppTheme.dark;
      }
    } catch (e) {
      //
    }
    await Future.delayed(const Duration(microseconds: 10));
    updateTheme();
  }

  // void refreshTheme(){
  //   final platformDispatcher = View.of(Get.context!).platformDispatcher;
  //   setTheme(enumAppTheme: platformDispatcher.platformBrightness==Brightness.light?EnumAppTheme.light:EnumAppTheme.dark);
  //   _updateTheme();
  // }

  void setTheme({required EnumAppTheme enumAppTheme}) {
    _currentAppThemEnum.value = enumAppTheme;
  }

  void toggleTheme() {
    if (_currentAppThemEnum.value == EnumAppTheme.light) {
      _currentAppThemEnum.value = EnumAppTheme.dark;
    } else {
      _currentAppThemEnum.value = EnumAppTheme.light;
    }
  }

  void updateTheme() async {
    if (_currentAppThemEnum.value == EnumAppTheme.light) {
      currentTheme.value = LightThemeData.theme;
    } else {
      currentTheme.value = DarkThemeData.theme;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        SpKeys.enumCurrentTheme, _currentAppThemEnum.value.name);
  }

  bool xIsDarkTheme() {
    return _currentAppThemEnum.value == EnumAppTheme.dark;
  }
}

bool xIsDarkTheme() {
  ThemeController themeController = Get.find();
  return themeController.xIsDarkTheme();
}

T getThemeValue<T>({required T lightThemeValue, required T darkThemeValue}) {
  return xIsDarkTheme() ? darkThemeValue : lightThemeValue;
}
