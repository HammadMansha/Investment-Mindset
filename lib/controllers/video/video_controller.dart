import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';

class VideoController extends GetxController {
  // late BetterPlayerController betterPlayerController;
  bool isLoading = true;

  bool videoPlayed = false;

  Duration startAt = const Duration();

  List analysisList = [].obs;

  bool isStarred = false;

  final storage = GetStorage();

  var isSocketError = false.obs;

  TextEditingController searchVideo = TextEditingController();

  var searchVideoData = [].obs;

  var nodata = false.obs;

  // ignore: prefer_typing_uninitialized_variables
  var response;

  @override
  void onReady() async {
    await getAnalysis();
    isLoading = false;

    update();
    super.onReady();
  }
// < --------------------------- Search Function -------------------------- >

  searchFunction(String v) {
    nodata.value = false;
    if (v.isEmpty || v == '') {
      searchVideoData.clear();
    } else {
      searchVideoData.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      analysisList.forEach((e) {
        if (e['name'].toString().toLowerCase().contains(v.toLowerCase())) {
          searchVideoData.add(e);
        } else if (e['photoPath']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchVideoData.add(e);
        } else if (e['name']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').first.toLowerCase()) &&
            e['photoPath']
                .toString()
                .toLowerCase()
                .contains(v.split(' ').last.toLowerCase())) {
          searchVideoData.add(e);
        }
      });
      if (searchVideoData.isEmpty) {
        nodata.value = true;
      }
    }
  }
  // < --------------------- Get All News --------------------- >

  Future<void> getAnalysis() async {
    analysisList.clear();
    update();
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.getAllVideos),
          headers: {'Authorization': 'Bearer $token'});
      var result = json.decode(res.body);
      response = json.decode(res.statusCode.toString());
      if (kDebugMode) {
        print("The status code of videos api is $response");
      }
      Get.log('Video API Data ${res.body}');
      analysisList.addAll(result["results"]);
      if (kDebugMode) {
        print("ALl Video List is ${analysisList.toString()}");
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
