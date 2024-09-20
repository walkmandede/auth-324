

class ApiResponse{

  int statusCode;
  int apiStatusCode;
  dynamic bodyData;
  String? bodyString;
  String message;
  bool xSuccess;
  String requestUrl;
  String requestMethod;

  ApiResponse({
    required this.statusCode,
    this.apiStatusCode = 0,
    required this.requestMethod,
    required this.requestUrl,
    required this.bodyData,
    required this.bodyString,
    required this.message,
    required this.xSuccess
  });

  factory ApiResponse.getInstance(){
    return ApiResponse(
      bodyData: null,
      bodyString: null,
      requestMethod: "",
      requestUrl: "",
      message: "",
      statusCode: 0,
      apiStatusCode: 0,
      xSuccess: false
    );
  }

}