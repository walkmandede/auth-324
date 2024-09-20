
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import '../../_common/constants/app_functions.dart';
import '../network_services/api_response.dart';

enum EnumLoggerType{
  zonedGuard,
  catchException,
  backendApi,
}

class LoggerModel{
  int id;
  DateTime dateTime;
  EnumLoggerType enumLoggerType;
  String title;
  Map<String,dynamic> content;
  String currentPage;

  LoggerModel({
    this.id = -1,
    required this.dateTime,
    required this.title,
    required this.enumLoggerType,
    required this.content,
    required this.currentPage
  });

  factory LoggerModel.fromMap({required Map<String,dynamic> data}){

    return LoggerModel(
        id: int.tryParse(data["id"].toString())??-1,
        dateTime: DateTime.tryParse(data["dateTime"].toString())??DateTime(0),
        title: data["title"].toString(),
        content: data["content"]==null?{}:jsonDecode(data["content"]),
        currentPage: data["currentPage"].toString(),
        enumLoggerType: EnumLoggerType.backendApi
    );
  }

  factory LoggerModel.fromNetworkCall({required ApiResponse apiResponse}){

    String currentPage = "-";
    try{
      currentPage = Get.currentRoute;
    }
    catch(e1,e2){
      saveLogFromException(e1, e2);
      null;
    }

    return LoggerModel(
      dateTime: DateTime.now(),
      title: "${apiResponse.requestMethod} - ${apiResponse.requestUrl}",
      content: {
        "statusCode" : max(apiResponse.apiStatusCode,apiResponse.statusCode),
        "responseBody" : apiResponse.bodyString.toString()
      },
      currentPage: currentPage,
      enumLoggerType: EnumLoggerType.backendApi
    );
  }

  factory LoggerModel.fromExceptions({required dynamic title,required dynamic stackTrace}){

    String currentPage = "-";
    try{
      currentPage = Get.currentRoute;
    }
    catch(e1,e2){
      saveLogFromException(e1, e2);
      null;
    }

    return LoggerModel(
      dateTime: DateTime.now(),
      title: title,
      content: {
        "stackTrace" : stackTrace.toString()
      },
      currentPage: currentPage,
      enumLoggerType: EnumLoggerType.backendApi
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "dateTime" : dateTime.toString(),
      "enumLoggerType" : enumLoggerType.name,
      "title" : title,
      "content" : jsonEncode(content),
      "currentPage" : currentPage
    };
  }

}
