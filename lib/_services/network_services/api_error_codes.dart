
import 'package:get/get.dart';

extension ErrorCodeExtension on int{

  ///errorCodeDescription
  String ecd(){
    return ApiErrorCodes().getCode(this);
  }

}

class ApiErrorCodes{

  String getCode(int errorCode){
    return _errorCodeDescriptions[errorCode]??"";
  }

  final Map<int,String> _errorCodeDescriptions = {
    0 : "Something went wrong".tr,
  };

}