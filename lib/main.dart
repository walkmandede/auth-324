import 'dart:async';
import 'dart:convert';
import 'package:auth_324/_common/models/m_password_model.dart';
import 'package:auth_324/modules/auth_main/v_auth_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '_common/_widgets/flutter_super_scaffold.dart';
import '_common/constants/app_colors.dart';
import '_common/constants/app_constants.dart';
import '_common/constants/app_functions.dart';
import '_common/controllers/c_data_controller.dart';
import '_services/logger_services/c_logger_controller.dart';
import '_services/theme_services/c_theme_controller.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Future.delayed(const Duration(seconds: 1));
  } catch (e1, e2) {
    saveLogFromException(e1, e2);
    null;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    injectDependencies();
    ThemeController themeController = Get.find();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: '324 - Auth',
          useInheritedMediaQuery: true,
          navigatorObservers: [routeObserver],
          locale: const Locale('en', 'EN'),
          fallbackLocale: const Locale('en', 'US'),
          theme: ThemeData(
            primarySwatch: MaterialColor(
                themeController.currentTheme.value.primary.value, const {
              050: Color.fromRGBO(29, 44, 77, .1),
              100: Color.fromRGBO(29, 44, 77, .2),
              200: Color.fromRGBO(29, 44, 77, .3),
              300: Color.fromRGBO(29, 44, 77, .4),
              400: Color.fromRGBO(29, 44, 77, .5),
              500: Color.fromRGBO(29, 44, 77, .6),
              600: Color.fromRGBO(29, 44, 77, .7),
              700: Color.fromRGBO(29, 44, 77, .8),
              800: Color.fromRGBO(29, 44, 77, .9),
              900: Color.fromRGBO(29, 44, 77, 1),
            }),
            datePickerTheme: DatePickerTheme.of(context).copyWith(
                headerForegroundColor: AppColors.white,
                elevation: 2,
                shadowColor: AppColors.white.withOpacity(0.4)),
            fontFamily: 'Nunito',
            fontFamilyFallback: const ['Book'],
            textTheme: TextTheme(
              bodyMedium: AppConstants.defaultTextStyle,
              titleMedium: AppConstants.defaultTextStyle,
              labelLarge: AppConstants.defaultTextStyle,
              bodyLarge: AppConstants.defaultTextStyle,
              bodySmall: AppConstants.defaultTextStyle,
              titleLarge: AppConstants.defaultTextStyle,
              titleSmall: AppConstants.defaultTextStyle,
            ),
            useMaterial3: false,
          ),
          // home: const AuthMainPage()
          home: const PasswordTestPage()
      ),
    );
  }

  void injectDependencies() {
    Get.put(ThemeController());
    Get.put(LoggerController());
    Get.put(DataController());
  }
}

class PasswordTestPage extends StatefulWidget {
  const PasswordTestPage({super.key});

  @override
  State<PasswordTestPage> createState() => _PasswordTestPageState();
}

class _PasswordTestPageState extends State<PasswordTestPage> {

  TextEditingController txtPassword = TextEditingController(text: "");
  ValueNotifier<PasswordModel> passwordModel = ValueNotifier(PasswordModel.fromString(password: ""));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: txtPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  label: Text("Password")
                ),
                onChanged: (value) {
                  passwordModel.value = PasswordModel.fromString(password: value);
                },
              ),
              ValueListenableBuilder(
                valueListenable: passwordModel,
                builder: (context, pm, child) {
                  return Column(
                    children: [
                      ...pm.toMap().keys.map((e) {
                        bool xResult = bool.tryParse(pm.toMap()[e].toString())??false;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.toString(),
                            ),
                            Icon(
                              xResult?Icons.check_circle_rounded:Icons.radio_button_unchecked_rounded,
                              color: xResult?Colors.green:Colors.red,
                            )
                          ],
                        );
                      },).toList()
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

