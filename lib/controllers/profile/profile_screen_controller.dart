import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../model/user_model.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';

class ProfileScreenController extends GetxController {
  bool isLoading = true;
  RxBool isBottomSheet = false.obs;

  late UserModel userModel;
  List followinglist = [];
  List followerslist = [];
  List userPostList = [];
  List eventlist = [];
  List attendedEventList = [];

  final storage = GetStorage();
  String bio = '';

  @override
  void onReady() async {
    await getUserProfile();

    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getUserProfile() async {
    followinglist.clear();
    followerslist.clear();
    update();
    String id = await storage.read('uid');
    String token = await storage.read('accesstoken');
    try {
      var res = await http.get(
          Uri.parse('${ApiData.baseUrl + ApiData.getProfile}/$id'),
          headers: {'Authorization': 'Bearer $token'});
      var result = json.decode(res.body);
      Get.log('User All data on Home is ${res.body}');
      userModel = UserModel.fromJson(result['user']);
      // bio = result['bio'];
      // followinglist.addAll(result['following']);
      // followerslist.addAll(result['followers']);
      update();
    } on SocketException catch (e) {
      isLoading = false;
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
