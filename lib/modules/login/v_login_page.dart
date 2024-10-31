import 'package:auth_324/_common/_widgets/w_auth_bg.dart';
import 'package:auth_324/modules/auth_main/v_auth_main_page.dart';
import 'package:auth_324/modules/login/c_login_controller.dart';
import 'package:auth_324/modules/login/sub_widgets/v_login_captcha_page.dart';
import 'package:auth_324/modules/login/sub_widgets/v_login_email_otp_page.dart';
import 'package:auth_324/modules/login/sub_widgets/v_login_email_page.dart';
import 'package:auth_324/modules/login/sub_widgets/v_login_password_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_captcha_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_email_otp_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_email_page.dart';
import 'package:auth_324/modules/register/_sub_widgets/v_register_password_page.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../_services/theme_services/w_custom_theme_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: BackButton(
                      color: theme.text1,
                      onPressed: () {
                        Get.offAll(()=> const AuthMainPage());
                      },
                    ),
                    title: Text("Login",style: TextStyle(color: theme.text1,fontSize: 20,fontWeight: FontWeight.w700),),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            LoginCaptchaPage(theme: theme),
                            LoginEmailPage(theme: theme),
                            LoginEmailOtpPage(theme: theme),
                            LoginPasswordPage(theme: theme),
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