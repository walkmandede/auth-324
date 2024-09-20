import 'package:auth_324/_services/others/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../_common/constants/app_constants.dart';
import '../../../../_common/constants/app_functions.dart';
import '../../../theme_services/c_theme_controller.dart';
import '../../../theme_services/m_theme_model.dart';
import '../detail/v_logger_detail_page.dart';
import 'c_logger_list.dart';

class LoggerListPage extends StatelessWidget {
  const LoggerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoggerListController());
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
                title: Text("Application Log",style: TextStyle(
                  color: theme.text1
                ),),
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
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: controller.xLoading,
                          builder: (context, xLoading, child) {
                            if(xLoading){
                              return Center(
                                child: CupertinoActivityIndicator(color: theme.primary,),
                              );
                            }
                            else{
                              return ValueListenableBuilder(
                                valueListenable: controller.currentData,
                                builder: (context, currentData, child) {
                                  currentData.sort((a, b) {
                                    return b.id.compareTo(a.id);
                                  },);
                                  return Column(
                                    children: List.generate(controller.pageSize, (index) {
                                      try{
                                        final each = currentData[index];
                                        return Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              vibrateNow();
                                              Get.to(()=> LoggerDetailPage(log: each));
                                            },
                                            child: ColoredBox(
                                              color: Colors.transparent,
                                              child: SizedBox.expand(
                                                child: LayoutBuilder(
                                                  builder: (a1, c1) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${each.id} - ${each.title}",
                                                            style: TextStyle(
                                                                color: theme.text1
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: FittedBox(
                                                            child: Text(
                                                              each.currentPage,
                                                              style: TextStyle(
                                                                  color: theme.text2
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: FittedBox(
                                                            child: Text(
                                                              each.dateTime.toString(),
                                                              style: TextStyle(
                                                                  color: theme.primarySoft
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Divider(),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      catch(e1){
                                        return const Expanded(child: SizedBox.expand());
                                      }
                                    },),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      10.heightBox(xResponsive: true),
                      pageControlBar(theme)
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

  Widget pageControlBar(ThemeModel theme){
    LoggerListController controller = Get.find();
    return ValueListenableBuilder(
      valueListenable: controller.totalItems,
      builder: (context, totalItems, child) {
        return ValueListenableBuilder(
          valueListenable: controller.currentPage,
          builder: (context, currentPage, child) {
            bool xLast = false;
            int currentTotalItems = currentPage*controller.pageSize;
            if(currentTotalItems>=totalItems){
              xLast = true;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  vibrateNow();
                  if(currentPage>1){
                    controller.onClickPrev();
                  }
                }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: currentPage>1?theme.text1:theme.text2.withOpacity(0.2),)),
                Text(
                  "$currentPage / ${(totalItems/controller.pageSize).ceil()}",
                  style: TextStyle(color: theme.text1),
                ),
                IconButton(onPressed: () {
                  vibrateNow();
                  if(!xLast){
                    controller.onClickNext();
                  }
                }, icon: Icon(Icons.arrow_forward_ios_rounded,color: !xLast?theme.text1:theme.text2.withOpacity(0.2),)),
              ],
            );
          },
        );
      },
    );
  }
}