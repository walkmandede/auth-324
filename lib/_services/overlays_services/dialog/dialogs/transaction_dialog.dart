import 'package:auth_324/_services/others/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_common/constants/app_assets.dart';
import '../../../../_common/constants/app_constants.dart';
import '../../../theme_services/c_theme_controller.dart';
import '../dialog_service.dart';

class TransactionDialog extends StatelessWidget {
  final String text;
  final Function() onClickYes;
  final Function() onClickNo;
  final String yesButtonText;
  final String noButtonText;
  const TransactionDialog({
    super.key,
    this.text = "Are you sure?",
    required this.onClickYes,
    required this.onClickNo,
    this.yesButtonText = "ဆက်လက်လုပ်ဆောင်မည်",
    this.noButtonText = "ပိတ်မည်",
  });

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return ValueListenableBuilder(
      valueListenable: themeController.currentTheme,
      builder: (context, theme, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
          child: Material(
            color: theme.background1,
            child: SizedBox(
              width: Get.width * 0.35,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: theme.primary,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppConstants.baseBorderRadius)
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.basePadding*0.5,
                            vertical: AppConstants.basePadding*0.5
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(AppAssets.logoIcon,width: Get.width * 0.05,color: theme.primaryOver,),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: theme.background1,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(AppConstants.baseBorderRadius)
                        )
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.text1
                          ),
                        ),
                        10.heightBox(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: LayoutBuilder(
                            builder: (a1, c1) {
                              return SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        onClickNo();
                                        DialogService().dismissDialog();
                                      },
                                      child: FittedBox(child: Text(noButtonText.tr,style: TextStyle(color: theme.primarySoft,fontWeight: FontWeight.w800),)),
                                    ),
                                    (c1.maxWidth * 0.01).widthBox(),
                                    TextButton(
                                      onPressed: () {
                                        onClickYes();
                                        DialogService().dismissDialog();
                                      },
                                      child: FittedBox(child: Text(yesButtonText.tr,style: TextStyle(color: theme.primary,fontWeight: FontWeight.w800),)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
