import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../_common/constants/app_functions.dart';
import '../../c_logger_controller.dart';
import '../../m_logger_model.dart';

class LoggerListController extends GetxController{

  ValueNotifier<int> totalItems = ValueNotifier(0);
  ValueNotifier<int> currentPage = ValueNotifier(1);
  int pageSize = 10;
  ValueNotifier<List<LoggerModel>> currentData = ValueNotifier([]);
  ValueNotifier<bool> xLoading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async{
    updateData();
  }

  Future<void> updateData() async{
    LoggerController loggerController = Get.find();
    xLoading.value = true;
    try{
      final data = await loggerController.fetchData(
        pageCount: currentPage.value,
        pageSize: pageSize,
        getTotalItem: (p0) => totalItems.value = p0,
      );
      currentData.value = [];
      currentData.value = data;
    }
    catch(e1,e2){
      saveLogFromException(e1, e2);
    }
    xLoading.value = false;
  }

  void onClickNext(){
    currentPage.value = currentPage.value + 1;
    updateData();
  }

  void onClickPrev(){
    currentPage.value = currentPage.value - 1;
    updateData();
  }

}