import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../widgets/common_toast.dart';

class EditProfileController extends GetxController {
  bool isEdit = true;
  bool isLoading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  final storage = GetStorage();
  String userId = '';
  @override
  void onReady() async {
    firstName.text = await storage.read('firstname');
    lastName.text = await storage.read('lastname');
    username.text = await storage.read('username');
    email.text = await storage.read('email');
    super.onReady();
  }

  Future<void> updateUser() async {
    userId = await storage.read('id');
    String token = await storage.read('accesstoken');
    var res = await http.patch(
        Uri.parse(ApiData.baseUrl + ApiData.updateUser + userId),
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          'firstName': firstName.text,
          'lastName': lastName.text,
          'userName': username.text,
        });
    var result = jsonDecode(res.body);
    if (kDebugMode) {
      print("Code for update profile api${res.statusCode}");
    }
    if (kDebugMode) {
      print(res.body);
    }
    if (res.statusCode == 200) {
      await storage.write('firstname', result['firstName']);
      await storage.write('lastname', result['lastName']);
      await storage.write('username', result['userName']);
      Get.back();
      CommonToast.showToast(
          title: "Profile Updated Successfully", isWarning: false);
    }
  }
}
