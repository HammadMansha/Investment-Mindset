import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';

class ScalingController extends GetxController {
  bool isLoading = true;

  bool isStarred = false;

  String? scalingid;

  List scalingData = [];

  final storage = GetStorage();

  var isSocketError = false.obs;

  var details = {};

  @override
  void onInit() async {
    if (Get.arguments != null) {
      if (kDebugMode) {
        print(' Single Scaling data is is ${Get.arguments['id']}');
      }
      scalingid = Get.arguments['id'];

      await getSingleScaling(scalingid!);
      super.onInit();
    }
  }

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getSingleScaling(String scaleid) async {
    scalingData.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse("${ApiData.baseUrl}${ApiData.getAllScaling}/$scaleid"),
          headers: {'Authorization': 'Bearer $token'});

      var result = json.decode(res.body);
      Get.log('Single News API Data ${res.body}');
      details.addAll(result);
      update();
      if (kDebugMode) {
        print("Single Scaling Data ${scalingData.toString()}");
      }
    } on SocketException catch (e) {
      isLoading = false;
      isSocketError.value = true;
      update();
      if (kDebugMode) {
        print(e);
      }
      CommonToast.showToast(
          title: "Your internet connection is not stable", isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("The error is $e");
      }
    }
  }
}
