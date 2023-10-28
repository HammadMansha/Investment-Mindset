import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_colors.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_snackbar.dart';

class SearchEventsController extends GetxController {
  bool isLoading = true;
  dynamic argumentData = Get.arguments;
  var isSocketError = false.obs;
  String? search;
  final storage = GetStorage();
  List searchEventList = [];
  // EventsController eventsController1=Get.put(EventsController());
  // EventsController eventsController=Get.find<EventsController>();
  @override
  void onInit() {
    if (kDebugMode) {
      search = argumentData['search'];
    }

    super.onInit();
  }

  @override
  void onReady() async {
    await searchEvent();

    isLoading = false;
    super.onReady();
  }

  Future<void> searchEvent() async {
    isLoading = true;
    update();
    try {
      String token = await storage.read('accesstoken');
      var res = await http.post(
          Uri.parse(ApiData.baseUrl + ApiData.searchNews + search!),
          headers: {'Authorization': 'Bearer $token'},
          body: {"queryText": search});
      // var result = json.decode(res.body);
      if (res.statusCode == 200) {
        var result = json.decode(res.body);
        if (kDebugMode) {
          print("status code for search api is${res.statusCode}");
        }
        Get.log('Search api  $result');
        searchEventList.addAll(result);
        if (kDebugMode) {
          print("The result of search is $searchEventList");
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("error$e");
      }
      CustomSnackBar.showSnackBar(
          title: "Info",
          message: e.toString(),
          isWarning: true,
          backgroundColor: AppColors.redColor);
      //Get.snackbar("Error", e.toString());
    }
  }
}
