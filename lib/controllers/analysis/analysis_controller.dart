import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';

class AnalysisController extends GetxController {
  bool isLoading = true;

  bool isStarred = false;

  final storage = GetStorage();

  var isSocketError = false.obs;

  List analysisList = [].obs;

  Map singleanalysisList = {};

  String singleAnalysisId = '';

  var searchAnalysisData = [].obs;

  var nodata = false.obs;

  // ignore: prefer_typing_uninitialized_variables
  var response;

  TextEditingController searchAnalysis = TextEditingController();

  @override
  void onReady() async {
    await getAnalysis();
    isLoading = false;

    update();
    super.onReady();
  }

  // < --------------------- Get All News --------------------- >

  Future<void> getAnalysis() async {
    analysisList.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.getAllanalysis),
          headers: {'Authorization': 'Bearer $token'});
      var result = json.decode(res.body);
      response = json.decode(res.statusCode.toString());
      if (kDebugMode) {
        print("The status code of analysis api is $response");
      }
      Get.log('News API Data ${res.body}');
      analysisList.addAll(result["results"]);
      if (kDebugMode) {
        print("ALl News List is ${analysisList.toString()}");
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
          title: "Your Internet Connection is not stable", isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("The error is $e");
      }
    }
  }

  // < --------------------- Get single News --------------------- >

  Future<void> getSingleNews(String analysisId) async {
    singleanalysisList.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse("${ApiData.baseUrl}${ApiData.getAllanalysis}/$analysisId"),
          headers: {'Authorization': 'Bearer $token'});

      var result = json.decode(res.body);
      Get.log('Single News API Data ${res.body}');
      singleanalysisList.addAll(result);
      if (kDebugMode) {
        print("Single News Data is ${singleanalysisList.toString()}");
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
          title: "Your Internet Connection is not stable", isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      CommonToast.showToast(title: e.toString(), isWarning: true);
    }
  }
  // < --------------------------- Search Function -------------------------- >

  searchFunction(String v) {
    nodata.value = false;
    if (v.isEmpty || v == '') {
      searchAnalysisData.clear();
    } else {
      searchAnalysisData.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      analysisList.forEach((e) {
        if (e['title'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchAnalysisData.add(e);
        } else if (e['description']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchAnalysisData.add(e);
        } else if (e['title']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').first.toLowerCase()) &&
            e['description']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').last.toLowerCase())) {
          searchAnalysisData.add(e);
        }
      });
      if (searchAnalysisData.isEmpty) {
        nodata.value = true;
      }
    }
  }
}
