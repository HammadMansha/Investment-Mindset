import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../utils/app_libraries.dart';
import '../../../utils/routes/app_routes.dart';
import '../../../widgets/common_toast.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;

  bool securetext = false;

  bool securetext1 = false;

  bool securetext2 = false;

  String email = '';

  String id = '';

  final formkey = GlobalKey<FormState>();

  TextEditingController confirmpassword = TextEditingController();

  TextEditingController oldpassword = TextEditingController();

  TextEditingController password = TextEditingController();

  final storage = GetStorage();

  @override
  void onReady() async {
    email = await storage.read('email');
    if (kDebugMode) {
      print("The email of logged user is $email");
    }
    id = storage.read('id').toString();
    isLoading = false;
    update();
    super.onReady();
  }

  bool validateAndSaveUser() {
    final form = formkey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> changePasswordFun() async {
    isLoading = true;
    update();
    String token = await storage.read('accesstoken');
    try {
      if (formkey.currentState!.validate()) {
        var res = await http.post(
            Uri.parse(ApiData.baseUrl + ApiData.changePassword),
            headers: {
              'Authorization': 'Bearer $token',
            },
            body: {
              "email": email,
              "oldPassword": oldpassword.text,
              "newPassword": confirmpassword.text
            });
        if (kDebugMode) {
          print("Body Result is ${res.body}");
        }
        var result = json.decode(res.body);
        isLoading = false;
        update();
        if (res.statusCode == 200) {
          Get.offAllNamed(Routes.authenticationRoutes);
          CommonToast.showToast(
              title: "Password Changed Successfully", isWarning: false);
        } else {
          CommonToast.showToast(title: result['message'], isWarning: true);
        }
      }
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
      CommonToast.showToast(title: e.toString(), isWarning: true);
    }
  }
}
