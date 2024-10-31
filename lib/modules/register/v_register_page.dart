import 'package:auth_324/_common/_widgets/w_auth_bg.dart';
import 'package:auth_324/_common/constants/app_constants.dart';
import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/modules/auth_main/v_auth_main_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_captcha_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_email_otp_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_email_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_password_page.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../_services/theme_services/w_custom_theme_builder.dart';
import '../../_common/constants/app_functions.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterPageController());
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return SizedBox.expand(
          child: Stack(
            children: [
              AuthBgWidget(theme: theme),
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text("Register",style: TextStyle(color: theme.text1,fontSize: 20,fontWeight: FontWeight.w700),),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: BackButton(
                    color: theme.text1,
                    onPressed: () {
                      Get.offAll(()=> const AuthMainPage());
                    },
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          RegisterCaptchaPage(theme: theme),
                          RegisterEmailPage(theme: theme),
                          RegisterEmailOtpPage(theme: theme),
                          RegisterPasswordPage(theme: theme),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        );
      },
    );
  }
}