import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_common/constants/app_constants.dart';
import '../../../theme_services/c_theme_controller.dart';

class LoadingDialog extends StatelessWidget {
  final String loadingText;
  const LoadingDialog({super.key,required this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GetBuilder<ThemeController>(
        builder: (controller) {
          return ValueListenableBuilder(
            valueListenable: controller.currentTheme,
            builder: (context, theme, child) {
              return SizedBox(
                width: Get.width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            horizontal: AppConstants.basePadding,
                            vertical: AppConstants.basePadding
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              loadingText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.primaryOver
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(AppConstants.baseBorderRadius)
                          ),
                          color: theme.background1
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: Get.height * 0.025
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoActivityIndicator(
                            radius: 16,
                            color: theme.text1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
