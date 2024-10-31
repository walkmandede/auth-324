import 'package:auth_324/_common/_widgets/w_auth_bg.dart';
import 'package:auth_324/_common/constants/app_assets.dart';
import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/modules/auth_main/c_auth_main_controller.dart';
import 'package:auth_324/modules/login/v_login_page.dart';
import 'package:auth_324/modules/register/v_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../_services/theme_services/w_custom_theme_builder.dart';
import '../../_common/_widgets/fitted_widget.dart';
import '../../_common/constants/app_constants.dart';
import '../../_common/constants/app_functions.dart';
import '../../_services/logger_services/views/list/v_logger_list_page.dart';

class AuthMainPage extends StatelessWidget {
  const AuthMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthMainController());

    List<int> numbers = [0,9,1,2,3,65,723];

    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.background1,
          body: SizedBox.expand(
            child: Stack(
              children: [
                AuthBgWidget(theme: theme,),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.mediaQuery.viewPadding.top,
                    bottom: Get.mediaQuery.viewPadding.bottom,
                    left: AppConstants.basePadding,
                    right: AppConstants.basePadding
                  ),
                  child: LayoutBuilder(
                    builder: (a1, c1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    vibrateNow();
                                    Get.to(() => const LoggerListPage());
                                  },
                                  child: Text(
                                    "Log",
                                    style: TextStyle(color: theme.text1),
                                  ))
                            ],
                          ),
                          const Spacer(),
                          // Text(),
                          25.heightBox(),
                          Text(
                            "The application name here".toUpperCase(),
                            style: TextStyle(
                                color: theme.text1,
                                fontSize: AppConstants.fontSizeXL.lfs(),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(
                              "The application slogan here".tr,
                              style: TextStyle(
                                  color: theme.text2,
                                  fontSize: AppConstants.fontSizeM.lfs(),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          45.heightBox(),
                          SizedBox(
                            width: double.infinity,
                            height: AppConstants.baseButtonHeightL,
                            child: ElevatedButton(
                              onPressed: () {
                                vibrateNow();
                                Get.offAll(() => const RegisterPage());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.baseBorderRadius))),
                              child: Text(
                                "Create new account".tr,
                                style: TextStyle(
                                    fontSize: AppConstants.fontSizeL.lfs(),
                                    fontWeight: FontWeight.w600,
                                    color: theme.primaryAccent),
                              ),
                            ),
                          ),
                          15.heightBox(),
                          GestureDetector(
                            onTap: () async {
                              vibrateNow();
                              Get.offAll(() => const LoginPage());
                            },
                            child: Container(
                              width: Get.width,
                              height: AppConstants.baseButtonHeightM,
                              decoration:
                              const BoxDecoration(color: Colors.transparent),
                              child: FittedWidget(
                                mainAxisAlignment: MainAxisAlignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? Login".tr,
                                      style: TextStyle(
                                          color: theme.text1,
                                          fontSize: AppConstants.fontSizeM.lfs()),
                                    ),
                                    5.widthBox(),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: theme.text1,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          20.heightBox(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }
}