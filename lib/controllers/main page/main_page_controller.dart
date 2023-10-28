import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';
import '../payment/payment_controller.dart';

class MainPageController extends GetxController {
  bool isLoading = true;

  bool isStarred = false;

  final storage = GetStorage();

  var isSocketError = false.obs;

  var newsList = [].obs;

  Map singleNewsList = {};

  String singleNewsId = '';

  TextEditingController searchNews = TextEditingController();

  PaymentController paymentController = Get.put(PaymentController());
  PaymentController paymentController1 = Get.find<PaymentController>();

  var searchNewsData = [].obs;

  var nodata = false.obs;

  // ignore: prefer_typing_uninitialized_variables
  var response;

  @override
  void onReady() async {
    await getNews();
    isLoading = false;

    update();
    super.onReady();
  }

  // < --------------------- Get All News --------------------- >

  Future<void> getNews() async {
    newsList.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(Uri.parse(ApiData.baseUrl + ApiData.getAllNews),
          headers: {'Authorization': 'Bearer $token'});
      var result = json.decode(res.body);
      response = json.decode(res.statusCode.toString());
      if (kDebugMode) {
        print("The status code of news api is $response");
      }
      Get.log('News API Data ${res.body}');
      newsList.addAll(result["results"]);
      if (kDebugMode) {
        print("ALl News List is ${newsList.toString()}");
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

  // < --------------------- Get All News --------------------- >

  Future<void> getSingleNews(String newsId) async {
    singleNewsList.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse("${ApiData.baseUrl}${ApiData.getAllNews}/$newsId"),
          headers: {'Authorization': 'Bearer $token'});

      var result = json.decode(res.body);
      Get.log('Single News API Data ${res.body}');
      singleNewsList.addAll(result);
      update();
      if (kDebugMode) {
        print("Single News Data is $singleNewsList");
      }

      if (kDebugMode) {}
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

  // < --------------------------- Search Function -------------------------- >

  searchFunction(String v) {
    nodata.value = false;
    if (v.isEmpty || v == '') {
      searchNewsData.clear();
    } else {
      searchNewsData.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      newsList.forEach((e) {
        if (e['title'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchNewsData.add(e);
        } else if (e['description']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchNewsData.add(e);
        } else if (e['title']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').first.toLowerCase()) &&
            e['description']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').last.toLowerCase())) {
          searchNewsData.add(e);
        }
      });
      if (searchNewsData.isEmpty) {
        nodata.value = true;
      }
    }
  }
}
