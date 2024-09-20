import 'package:get/get.dart';

class DataController extends GetxController {
  String baseUrl = "https://test.sanpyaexpress-backend.xsphere.co";
  // String baseUrl = "http://192.168.100.34:8081";
  // String baseUrl = "https://sanpyaexpress-backend.xsphere.co";
  String apiPort = "";
  String apiPrefix = "/api";
  String socketPort = ":8500";
  String socketPrefix = "/socket";

  String apiToken = "";
  String fcmToken = "-";
  String deviceId = "";

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async {}
}
