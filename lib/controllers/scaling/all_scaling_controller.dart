import 'dart:convert';
import 'dart:io';

import '../../utils/app_libraries.dart';

import 'package:http/http.dart' as http;

import '../../widgets/common_toast.dart';

class AllScalingController extends GetxController {
  bool isLoading = true;

  final storage = GetStorage();

  var isSocketError = false.obs;

  List scalingList = [].obs;

  TextEditingController searchScaling = TextEditingController();

  var searchScalingData = [].obs;

  var nodata = false.obs;

  // ignore: prefer_typing_uninitialized_variables
  var response;

  @override
  void onReady() async {
    await getScaling();
    isLoading = false;
    update();
    super.onReady();
  }

  // < --------------------------- Search Function -------------------------- >

  searchFunction(String v) {
    nodata.value = false;
    if (v.isEmpty || v == '') {
      searchScalingData.clear();
    } else {
      searchScalingData.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      scalingList.forEach((e) {
        if (e['title'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchScalingData.add(e);
        } else if (e['company']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchScalingData.add(e);
        } else if (e['title']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').first.toLowerCase()) &&
            e['company']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').last.toLowerCase())) {
          searchScalingData.add(e);
        }
      });
      if (searchScalingData.isEmpty) {
        nodata.value = true;
      }
    }
  }

  Future<void> getScaling() async {
    scalingList.clear();
    update();
    String token = await storage.read('accesstoken');
    if (kDebugMode) {
      print("The token is $token");
    }
    try {
      var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.getAllScaling),
          headers: {'Authorization': 'Bearer $token'});
      var result = json.decode(res.body);
      response = json.decode(res.statusCode.toString());
      if (kDebugMode) {
        print("The status code of scaling api is $response");
      }
      Get.log('Scaling API Data ${res.body}');
      scalingList.addAll(result["results"]);
      if (kDebugMode) {
        print("ALl Scaling List is ${scalingList.toString()}");
      }
      update();
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
