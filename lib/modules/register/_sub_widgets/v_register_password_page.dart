import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/_services/theme_services/m_theme_model.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../_common/constants/app_constants.dart';
import '../../../_common/constants/app_functions.dart';

class RegisterPasswordPage extends StatelessWidget {
  final ThemeModel theme;
  const RegisterPasswordPage({super.key,required this.theme});

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
              Text(
                "Create a strong password".tr,
                style: TextStyle(
                  color: theme.text1,
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.heightBox(xResponsive: false),
              ValueListenableBuilder(
                valueListenable: controller.xObscured,
                builder: (context, xObscured, child) {
                  return TextField(
                    controller: controller.txtPassword,
                    onTapOutside: (event) {
                      vibrateNow();
                      dismissKeyboard();
                    },
                    onTap: () {
                    },
                    onChanged: (value) {
                      controller.updatePasswordModel();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: theme.primary,
                        hintText: "Type your password here",
                        hintStyle: TextStyle(
                            color: theme.text2
                        ),
                        suffix: IconButton(onPressed: () {
                          vibrateNow();
                          controller.xObscured.value = !xObscured;
                        }, icon: Icon(Icons.remove_red_eye_rounded,color: xObscured?theme.primary:theme.disableColor,))
                    ),
                    obscureText: xObscured,
                    style: TextStyle(
                        fontSize: AppConstants.fontSizeL,
                        color: theme.text1
                    ),
                  );
                },
              ),
              20.heightBox(xResponsive: false),
              ValueListenableBuilder(
                valueListenable: controller.passwordModel,
                builder: (context, passwordModel, child) {
                  return Column(
                    children: [
                      ...[
                        ["Length must be at least 8",passwordModel.xIsLengthAtLeastEight],
                        ["Has at least one lower case digit",passwordModel.xHasDigit],
                        ["Has at least one lower case letter",passwordModel.xHasLowerCase],
                        ["Has at least one upper case letter",passwordModel.xHasUpperCase],
                        ["Has special characters e.g (%,@,\$,...)",passwordModel.xHasSpecial],
                        ["not similar with leaked 10k common passwords",!passwordModel.xIsCommon],
                      ].map((e) {
                        String label = e[0].toString();
                        bool xValue = bool.tryParse(e[1].toString())??false;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              xValue?Icons.check_circle_rounded:Icons.radio_button_unchecked_rounded,
                              color: xValue?theme.primary:theme.text2,
                            ),
                            (c1.maxWidth * 0.05).widthBox(xResponsive: false),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color: xValue?theme.primary:theme.text1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },).toList()
                    ],
                  );
                },
              ),
              (c1.maxHeight * 0.025).heightBox(xResponsive: false),
              SizedBox(
                height: c1.maxHeight * 0.075,
                child: ValueListenableBuilder(
                  valueListenable: controller.passwordAiScore,
                  builder: (context, passwordAiScore, child) {
                    if(passwordAiScore==null){
                      return Text(
                        controller.txtPassword.text.isEmpty?"":"Checking password strength with ML classifier",
                        style: TextStyle(
                          color: theme.text2
                        ),
                      );
                    }
                    else{
                      return RichText(
                        text: TextSpan(
                          text: "The password is ${passwordAiScore.label}",
                          style: TextStyle(
                              color: passwordAiScore.color
                          ),
                          children: [
                            TextSpan(
                              text: "\n* This result is generated by a machine learning classifier algorithm",
                              style: TextStyle(
                                color: theme.text2
                              )
                            )
                          ]
                        ),
                      );
                    }
                  },
                ),
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
                        valueListenable: controller.passwordModel,
                        builder: (context, passwordModel, child) {
                          return ElevatedButton(
                            onPressed: () {
                              vibrateNow();
                              if(passwordModel.xShouldPass()){
                                controller.onClickPasswordNext();
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
                                backgroundColor: !passwordModel.xShouldPass()?theme.primary.withOpacity(0.2):theme.primary
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Next".tr,
                                  style: TextStyle(
                                      color:!passwordModel.xShouldPass()?theme.primary.withOpacity(0.6):theme.primaryAccent,
                                      fontSize: AppConstants.fontSizeL,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                5.widthBox(),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: !passwordModel.xShouldPass()?theme.primary.withOpacity(0.6):theme.primaryAccent,
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
