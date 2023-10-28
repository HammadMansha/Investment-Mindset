import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/app_libraries.dart';

class ForgotPasswordController extends GetxController {
  bool isLoading = true;

  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pin = TextEditingController();

  String lastcode = '';

  final storage = GetStorage();

  late Timer otptimer;
  int start = 60;

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> forgotPassword() async {
    if (formkey.currentState!.validate()) {
      pin.clear();
      if (kDebugMode) {
        print("email is ${emailController.text}");
      }
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        if (kDebugMode) {
          print(url);
        }
        var res = await http.post(Uri.parse(url + ApiData.forgot),
            body: {'email': emailController.text});
        if (kDebugMode) {
          print("status code is${res.statusCode}");
        }
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          storage.write('forgetemail', emailController.text);
          lastcode = data.toString();
          update();
          if (start == 0) {
            start = 60;
            startTimer();
          } else {
            start = 60;
            startTimer();
          }
        }
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print("Check All data ");
        }
        var res = await http.post(Uri.parse(ApiData.baseUrl + ApiData.forgot),
            body: {'email': emailController.text});
        if (kDebugMode) {
          print("status code is${res.statusCode}");
        }
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          lastcode = data.toString();
          update();
          if (start == 0) {
            start = 60;
            startTimer();
          } else {
            start = 60;
            startTimer();
          }
        }
        if (kDebugMode) {
          print(data);
        }
      }
    }
  }

  void startTimer() {
    const onesec = Duration(seconds: 1);
    otptimer = Timer.periodic(onesec, (Timer timer) {
      if (start < 1) {
        timer.cancel();
      } else if (pin.text.isEmpty) {
        start = start - 1;
      } else if (pin.text.isNotEmpty) {
        start = start - 1;
      }
      update();
    });
  }
}
