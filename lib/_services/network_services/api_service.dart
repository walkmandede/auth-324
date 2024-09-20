import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:dio/dio.dart' as dio;
import '../../_common/constants/app_functions.dart';
import '../../_common/controllers/c_data_controller.dart';
import '../logger_services/c_logger_controller.dart';
import '../logger_services/m_logger_model.dart';
import '../overlays_services/dialog/dialog_service.dart';
import 'package:http/http.dart' as http;

import 'api_response.dart';

class ApiService {
  DataController dataController = Get.find();

  Future<bool> checkInternet() async {
    if (kIsWeb) {
      return true;
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (e1, e2) {
        saveLogFromException(e1, e2);
        return false;
      }
      return false;
    }
  }

  String convertNetworkImage({required String orgPath}) {
    final result = (dataController.baseUrl.replaceAll("/api/v1/", "") +
        dataController.apiPort +
        orgPath);
    return result;
  }

  Response convertHttpResponseToGetResponse(
      {required http.Response response, required Request request}) {
    try {
      return Response(
          statusCode: response.statusCode,
          body: jsonDecode(response.body),
          bodyString: response.body,
          headers: response.headers,
          request: request);
    } catch (e1, e2) {
      saveLogFromException(e1, e2);
      return Response(
          statusCode: response.statusCode,
          body: null,
          bodyString: response.body,
          headers: response.headers,
          request: request);
    }
  }

  Future<Response?> get(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true,
      int timeOutInSec = 100}) async {
    final xHasInternet = await checkInternet();

    DataController dataController = Get.find();
    final Request request = Request(
      url: Uri.parse(xBaseUrlIncluded
          ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
          : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
      method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.get(
        Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
      );
      return convertHttpResponseToGetResponse(
          response: response, request: request);
    } else {
      return Response(request: request);
    }
  }

  Future<Response?> post(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    DataController dataController = Get.find();
    final Request request = Request(
      url: Uri.parse(xBaseUrlIncluded
          ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
          : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
      method: 'GET',
    );

    superPrint(Uri.parse(xBaseUrlIncluded
        ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
        : endPoint));
    if (xHasInternet) {
      final response = await http.post(
        Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        body: jsonEncode(data),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
          "offset": DateTime.now().timeZoneOffset.inMinutes.toString()
        },
      );
      return convertHttpResponseToGetResponse(
          response: response, request: request);
    } else {
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'POST',
      ));
    }
  }

  Future<Response?> patch(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true,
      Map<String, dynamic> data = const {}}) async {
    final xHasInternet = await checkInternet();

    DataController dataController = Get.find();
    final Request request = Request(
      url: Uri.parse(xBaseUrlIncluded
          ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
          : endPoint),
      headers: {
        "accept": "*/*",
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
      method: 'PATCH',
    );

    if (xHasInternet) {
      superPrint(data,
          title: xBaseUrlIncluded
              ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
              : endPoint);
      final response = await GetConnect(timeout: const Duration(seconds: 40)).patch(
          xBaseUrlIncluded
              ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
              : endPoint,
          data,
          headers: {
            "acccept": "*/*",
            "Content-Type": "application/json",
            if (xNeedToken)
              "Authorization": "Bearer ${dataController.apiToken}",
          });
      return response;
    } else {
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'PATCH',
      ));
    }
  }

  Future<Response?> delete(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    DataController dataController = Get.find();
    final Request request = Request(
      url: Uri.parse(xBaseUrlIncluded
          ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
          : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
      method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.delete(
        Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
      );

      return convertHttpResponseToGetResponse(
          response: response, request: request);
    } else {
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'DELETE',
      ));
    }
  }

  Future<Response?> put(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    DataController dataController = Get.find();
    final Request request = Request(
      url: Uri.parse(xBaseUrlIncluded
          ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
          : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
      method: 'GET',
    );
    if (xHasInternet) {
      final response = await http.put(
        Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        body: data,
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
      );
      return convertHttpResponseToGetResponse(
          response: response, request: request);
    } else {
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'PUT',
      ));
    }
  }

  Future<Response?> formDataPost(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      Map<String, dio.MultipartFile?> files = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();

    if (xHasInternet) {
      Response? response;
      try {
        dio.Dio dioClient = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap({...data, ...files});
        DataController dataController = Get.find();
        var dioResponse = await dioClient.post(
            xBaseUrlIncluded
                ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
                : endPoint,
            options: dio.Options(
              contentType: 'text/html; charset=utf-8',
              headers: <String, String>{
                "accept": "*/*",
                "Content-Type": "application/json",
                if (xNeedToken)
                  "Authorization": "Bearer ${dataController.apiToken}",
              },
            ),
            data: formData);
        if (dioResponse.statusCode == 201) {
          response = Response(
            statusCode: 201,
            headers: {},
            body: dioResponse.data,
            statusText: "",
          );
        }
      } catch (e1, e2) {
        saveLogFromException(e1, e2);
        if (e1 is dio.DioException) {
          try {
            superPrint(e1.response!.data, title: e1.response!.statusCode);
            response = Response(
                statusCode: e1.response!.statusCode,
                body: e1.response!.data,
                bodyString: e1.response!.data.toString());
          } catch (e1, e2) {
            saveLogFromException(e1, e2);
            response = const Response(
                statusCode: 0, body: {}, bodyString: "Something went wrong!");
          }
        }
      }
      return response;
    } else {
      DataController dataController = Get.find();
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'POST/FORM_DATA',
      ));
    }
  }

  Future<Response?> formDataMultiPost(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      List<Map<String, dio.MultipartFile?>> files = const [{}],
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();

    if (xHasInternet) {
      Response? response;
      try {
        dio.Dio dioClient = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap({
          ...data,
        });
        for (var map in files) {
          map.forEach((key, file) {
            if (file != null) {
              formData.files.add(MapEntry(key, file));
            }
          });
        }
        DataController dataController = Get.find();
        var dioResponse = await dioClient.post(
            xBaseUrlIncluded
                ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
                : endPoint,
            options: dio.Options(
              contentType: 'text/html; charset=utf-8',
              headers: <String, String>{
                "accept": "*/*",
                "Content-Type": "application/json",
                if (xNeedToken)
                  "Authorization": "Bearer ${dataController.apiToken}",
              },
            ),
            data: formData);
        if (dioResponse.statusCode! >= 200 && dioResponse.statusCode! <= 299) {
          response = Response(
            statusCode: dioResponse.statusCode,
            headers: {},
            body: dioResponse.data,
            statusText: "",
          );
        }
      } catch (e1, e2) {
        saveLogFromException(e1, e2);
        if (e1 is dio.DioException) {
          try {
            superPrint(e1.response!.data, title: e1.response!.statusCode);
            response = Response(
                statusCode: e1.response!.statusCode,
                body: e1.response!.data,
                bodyString: e1.response!.data.toString());
          } catch (e1, e2) {
            saveLogFromException(e1, e2);
            response = const Response(
                statusCode: 0, body: {}, bodyString: "Something went wrong!");
          }
        }
      }
      return response;
    } else {
      DataController dataController = Get.find();
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'POST/FORM_DATA',
      ));
    }
  }

  Future<Response?> formDataMultiPatch(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      List<Map<String, dio.MultipartFile?>> files = const [{}],
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();

    if (xHasInternet) {
      Response? response;
      try {
        dio.Dio dioClient = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap({
          ...data,
        });
        for (var map in files) {
          map.forEach((key, file) {
            if (file != null) {
              formData.files.add(MapEntry(key, file));
            }
          });
        }
        DataController dataController = Get.find();
        var dioResponse = await dioClient.patch(
            xBaseUrlIncluded
                ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
                : endPoint,
            options: dio.Options(
              contentType: 'text/html; charset=utf-8',
              headers: <String, String>{
                "accept": "*/*",
                "Content-Type": "application/json",
                if (xNeedToken)
                  "Authorization": "Bearer ${dataController.apiToken}",
              },
            ),
            data: formData);
        superPrint(dioResponse.data, title: "DIO PATCH");
        if (dioResponse.statusCode! >= 200 && dioResponse.statusCode! <= 299) {
          response = Response(
            statusCode: dioResponse.statusCode,
            headers: {},
            body: dioResponse.data,
            statusText: "",
          );
        }
      } catch (e1, e2) {
        saveLogFromException(e1, e2);
        if (e1 is dio.DioException) {
          try {
            superPrint(e1.response!.data, title: e1.response!.statusCode);
            response = Response(
                statusCode: e1.response!.statusCode,
                body: e1.response!.data,
                bodyString: e1.response!.data.toString());
          } catch (e1, e2) {
            saveLogFromException(e1, e2);
            response = const Response(
                statusCode: 0, body: {}, bodyString: "Something went wrong!");
          }
        }
      }
      return response;
    } else {
      DataController dataController = Get.find();
      return Response(
          request: Request(
        url: Uri.parse(xBaseUrlIncluded
            ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
            : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
        },
        method: 'POST/FORM_DATA',
      ));
    }
  }

  ApiResponse validateResponse({
    required Response? response,
  }) {
    ApiResponse apiResponse = ApiResponse.getInstance();
    try {
      apiResponse.requestMethod = response!.request!.method;
      apiResponse.requestUrl = response.request!.url.path;
    } catch (e) {
      null;
    }
    if (response == null) {
      superPrint('response is null,may be no internet access!');
      DialogService().showTransactionDialog(
        text: "Unable to connect to the server!\nPlease try again later!",
      );
    } else {
      try {
        apiResponse.bodyString = response.bodyString;
        apiResponse.bodyData = response.body;
        apiResponse.statusCode = response.statusCode ?? 0;
        if (response.request != null) {
          apiResponse.requestMethod = response.request!.method;
          apiResponse.requestUrl = response.request!.url.path;
        }
        apiResponse.apiStatusCode = response.statusCode ?? 0;
        if (apiResponse.apiStatusCode < 200 ||
            apiResponse.apiStatusCode > 299) {
          apiResponse.xSuccess = false;
        } else if (apiResponse.apiStatusCode >= 200 &&
            apiResponse.apiStatusCode <= 299) {
          //success
          apiResponse.xSuccess = true;
        } else {
          apiResponse.xSuccess = false;
        }
        apiResponse.message = response.body["meta"]["message"].toString();
        apiResponse.xSuccess =
            bool.tryParse(response.body["meta"]["success"].toString()) ?? false;
      } catch (e1, e2) {
        saveLogFromException(e1, e2);
        if (response.request != null) {
          superPrint(e1, title: response.request!.url);
        }
        apiResponse.message = e1.toString();
        if (response.statusCode == null) {
          // Get.off(()=> const LoginGreetingPage());
          // DialogService().showSnack(
          //     title: "Connection Time Out",
          //     message: "Unable to use the system now.Please contact the development team.");
        } else {
          // DialogService().showSnack(
          //     title: "Something went wrong",
          //     message:
          //         "Unable to use the system now.Please contact the development team.");
        }
      }
    }

    try {
      LoggerController loggerController = Get.find();
      loggerController.insertNewLog(
          log: LoggerModel.fromNetworkCall(apiResponse: apiResponse));
    } catch (e1, e2) {
      saveLogFromException(e1, e2);
      null;
    }

    return apiResponse;
  }
}
