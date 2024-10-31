import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/_services/theme_services/m_theme_model.dart';
import 'package:auth_324/modules/login/c_login_controller.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../_common/constants/app_constants.dart';
import '../../../_common/constants/app_functions.dart';

class LoginEmailPage extends StatelessWidget {
  final ThemeModel theme;
  const LoginEmailPage({super.key,required this.theme});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find();
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
                "Enter your email".tr,
                style: TextStyle(
                  color: theme.text1,
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.bold,
                ),
              ),
              40.heightBox(),
              TextField(
                controller: controller.txtEmail,
                onTapOutside: (event) {
                  vibrateNow();
                  dismissKeyboard();
                },
                onTap: () {
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: theme.primary,
                    hintText: "e.g. johnsan@xcompany.com",
                    hintStyle: TextStyle(
                        color: theme.text2
                    )
                ),
                style: TextStyle(
                    fontSize: AppConstants.fontSizeL,
                    color: theme.text1
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
                        valueListenable: controller.xValidEmail,
                        builder: (context, xValid, child) {
                          return ElevatedButton(
                            onPressed: () {
                              vibrateNow();
                              if(xValid){
                                controller.onClickEmailNext();
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
