import 'dart:convert';
import 'package:auth_324/_services/others/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../_common/constants/app_constants.dart';
import '../../../theme_services/c_theme_controller.dart';
import '../../m_logger_model.dart';

class LoggerDetailPage extends StatelessWidget {
  final LoggerModel log;
  const LoggerDetailPage({super.key,required this.log});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return ValueListenableBuilder(
          valueListenable: themeController.currentTheme,
          builder: (context, theme, child) {
            return Scaffold(
              backgroundColor: theme.background1,
              appBar: AppBar(
                backgroundColor: theme.background1,
                elevation: 10,
                title: Text("Log Detail for ${log.id}",style: TextStyle(
                    color: theme.text1
                ),),
                actions: [

                ],
                leading: BackButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: theme.text1,
                ),
              ),
              body: SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppConstants.basePadding,
                      top: AppConstants.basePadding,
                      right: AppConstants.basePadding,
                      bottom: AppConstants.basePadding+Get.mediaQuery.padding.bottom
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.title,
                        style: TextStyle(
                            color: theme.text1
                        ),
                      ),
                      Text(
                        log.currentPage.toString(),
                        style: TextStyle(
                            color: theme.text2
                        ),
                      ),
                      Text(
                        log.dateTime.toString(),
                        style: TextStyle(
                            color: theme.primarySoft
                        ),
                      ),
                      20.heightBox(xResponsive: true),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "CONTENT",
                          style: TextStyle(
                            color: theme.text1,
                          ),
                        ),
                      ),
                      10.heightBox(xResponsive: true),
                      Flexible(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Text(
                              log.content.toString(),
                              style: TextStyle(
                                color: theme.text1
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}