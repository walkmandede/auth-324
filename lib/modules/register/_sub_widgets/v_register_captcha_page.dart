import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/_services/theme_services/m_theme_model.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_captcha/local_captcha.dart';

import '../../../_common/constants/app_constants.dart';
import '../../../_common/constants/app_functions.dart';

class RegisterCaptchaPage extends StatelessWidget {
  final ThemeModel theme;
  const RegisterCaptchaPage({super.key,required this.theme});

  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.find();
    return Padding(
      padding: EdgeInsets.only(
          left: AppConstants.basePadding,
          right: AppConstants.basePadding,
          bottom: Get.mediaQuery.viewPadding.bottom
      ),
      child: LayoutBuilder(
        builder: (a1, c1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Captcha".tr,
                      style: TextStyle(
                        color: theme.text1,
                        fontSize: AppConstants.fontSizeXXL,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: controller.captchaRefreshCooldown,
                      builder: (context, refreshCoolDown, child) {
                        if(refreshCoolDown<1){
                          return IconButton(onPressed: () {
                            vibrateNow();
                            controller.refreshCaptcha();
                          }, icon: Icon(Icons.refresh_rounded,color: theme.primary,));
                        }
                        else{
                          return Text(
                            "Refresh in $refreshCoolDown s",
                            style: TextStyle(
                              color: theme.redDanger
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              40.heightBox(),
              FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 100)),
                initialData: "s",
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return Center(
                      child: LocalCaptcha(
                        key: const Key("My Captcha"),
                        controller: controller.localCaptchaController,
                        height: c1.maxWidth * 0.35,
                        width: c1.maxWidth,
                        chars: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
                        backgroundColor: Colors.transparent,
                        length: 6,
                        fontSize: 60.0,
                        textColors: [
                          theme.text1,
                          theme.text1
                        ],
                        noiseColors: [
                          theme.redDanger,
                          theme.greenSuccess,
                          theme.yellowWarning,
                          theme.primaryOver,
                          theme.primary
                        ],
                        caseSensitive: false,
                        codeExpireAfter: const Duration(minutes: 10),
                      ),
                    );
                  }
                  else{
                    return Container();
                  }
                },
              ),
              20.heightBox(),
              Text(
                "Please type the letters inside the box above\n(Case insensitive)",
                style: TextStyle(
                  color: theme.text1
                ),
              ),
              20.heightBox(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.txtCaptcha,
                      onTapOutside: (event) {
                        vibrateNow();
                        dismissKeyboard();
                      },
                      onTap: () {
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: theme.primary,
                          hintText: "Type here...",
                          hintStyle: TextStyle(
                              color: theme.text2
                          )
                      ),
                      style: TextStyle(
                          fontSize: AppConstants.fontSizeL,
                          color: theme.text1
                      ),
                    ),
                  ),
                  (10.widthBox(xResponsive: false)),
                  ElevatedButton(
                    onPressed: () {
                      vibrateNow();
                      controller.validateCaptcha();
                    },
                    child: const Text("Check"),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: AppConstants.baseButtonHeightM,
                      child: ValueListenableBuilder(
                        valueListenable: controller.xValidCaptcha,
                        builder: (context, xValid, child) {
                          return ElevatedButton(
                            onPressed: () {
                              vibrateNow();
                              if(xValid){
                                controller.onClickCaptchaNext();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppConstants.basePadding*1.5
                                ),
                                elevation: 0,
                                backgroundColor: !xValid?theme.primary.withOpacity(0.2):theme.primary
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Next".tr,
                                  style: TextStyle(
                                      color:!xValid?theme.primary.withOpacity(0.6):theme.primaryAccent,
                                      fontSize: AppConstants.fontSizeL,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                5.widthBox(),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: !xValid?theme.primary.withOpacity(0.6):theme.primaryAccent,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
