import 'package:auth_324/_services/others/extensions.dart';
import 'package:auth_324/_services/theme_services/m_theme_model.dart';
import 'package:auth_324/modules/login/c_login_controller.dart';
import 'package:auth_324/modules/register/c_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../_common/constants/app_constants.dart';
import '../../../_common/constants/app_functions.dart';

class LoginEmailOtpPage extends StatelessWidget {
  final ThemeModel theme;
  const LoginEmailOtpPage({super.key,required this.theme});

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
                "Please check your mail for OTP".tr,
                style: TextStyle(
                  color: theme.text1,
                  fontSize: AppConstants.fontSizeXXL,
                  fontWeight: FontWeight.bold,
                ),
              ),
              40.heightBox(),
              Pinput(
                keyboardType: TextInputType.number,
                autofocus: true,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: c1.maxWidth * 0.2,
                  height: c1.maxWidth * 0.15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.primary,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                  ),
                  textStyle: TextStyle(
                    color: theme.text1,
                    fontSize: 16
                  )
                ),
                controller: controller.txtOtp,
                onTapOutside: (event) {
                  dismissKeyboard();
                },
                closeKeyboardWhenCompleted: true,

              ),
              10.heightBox(xResponsive: false),
              SizedBox(
                height: Get.height * 0.1,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: controller.otpRefreshCooldown,
                    builder: (context, refreshCoolDown, child) {
                      if(refreshCoolDown<1){
                        return TextButton(onPressed: () {
                          controller.sendOTP();
                        }, child: Text("Click here to resend OTP to the email : ${controller.txtEmail.text}",style: TextStyle(
                          color: theme.primary,
                        ),textAlign: TextAlign.center,));
                      }
                      else{
                        return Text(
                          "Resend OTP in $refreshCoolDown s",
                          style: TextStyle(
                              color: theme.redDanger
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              10.heightBox(),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: AppConstants.baseButtonHeightM,
                      child: ElevatedButton(
                        onPressed: () {
                          vibrateNow();
                          controller.onClickOtpNext();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200)
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.basePadding*1.5
                            ),
                            elevation: 0,
                            backgroundColor: theme.primary
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Next".tr,
                              style: TextStyle(
                                  color: theme.primaryAccent,
                                  fontSize: AppConstants.fontSizeL,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            5.widthBox(),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: theme.primaryAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
