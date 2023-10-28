import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/auth_service.dart';
import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_toast.dart';

class AuthenticationController extends GetxController {
  bool isLoading = true;

  bool isLogin = false;

  bool isSignup = true;

  bool isTermsAndConditions = false;

  bool isRememberPassword = false;

  bool isPasswordShown = true;

  bool isConfirmPasswordShown = true;

  bool isLoginPasswordShown = true;

  bool isAuth = false;

  final formkey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController emailAdress = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  TextEditingController loginEmail = TextEditingController();

  TextEditingController loginPassword = TextEditingController();

  // Getx Service for Auth Check
  AuthService authService = Get.find<AuthService>();

  final storage = GetStorage();

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
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

  // < ---------------------  Register User Function ------------------------ >

  Future<void> registerUserFunction() async {
    isLoading = true;
    update();
    try {
      if (formkey.currentState!.validate()) {
        var res = await http
            .post(Uri.parse(ApiData.baseUrl + ApiData.authRegister), body: {
          'firstName': firstName.text,
          'lastName': lastName.text,
          'email': emailAdress.text,
          'userName': firstName.text,
          'password': password.text,
        });
        if (kDebugMode) {
          Get.log("Body Result is ${res.body}");
          Get.log("Registr Api Response is ${res.statusCode}");
        }
        var result = json.decode(res.body);
        isLoading = false;
        update();
        if (res.statusCode == 200) {
          await storage.write('id', result['user']["id"]);
          await storage.write('email', result['user']['email']);
          await storage.write(
              'AccessToken', result['tokens']['access']['token']);

          if (isAuth) {
            await storage.write("uemail", emailAdress.text);
            await storage.write("pass", password.text);
            //  await storage.write('AccessToken', result['token']['access']['token']);
          }

          CommonToast.showToast(
              title: "User Registered Successfully", isWarning: false);
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
          title: "Your Internet Connection is not stable", isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      CommonToast.showToast(
          title: "User Registered Successfully", isWarning: false);
    }
  }

  //---------Login user function----------

  Future<void> loginFunction() async {
    isLoading = true;
    update();
    try {
      if (formkey.currentState!.validate()) {
        var res = await http
            .post(Uri.parse(ApiData.baseUrl + ApiData.authLogin), body: {
          'email': loginEmail.text,
          'password': loginPassword.text,
        });
        if (kDebugMode) {
          Get.log("Body Result is ${res.body}");
        }

        if (kDebugMode) {
          Get.log("Status Code of Login API is ${res.statusCode}");
        }
        var result = json.decode(res.body);
        isLoading = false;
        update();
        if (res.statusCode == 201) {
          await storage.write('id', result['user']['id']);
          await storage.write('email', result['user']['email']);
          await storage.write('firstname', result['user']['firstName']);
          await storage.write('lastname', result['user']['lastName']);
          await storage.write('username', result['user']['userName']);

          await storage.write('token', result['tokens']['refresh']['token']);
          await storage.write(
              'accesstoken', result['tokens']['access']['token']);
          await authService.isBiocheck();
          if (isAuth) {
            await storage.write("uemail", loginEmail.text);
            await storage.write("pass", loginPassword.text);

            // await getUserProfile(
            //     result['user']['id'], result['tokens']['access']['token']);
          }

          Get.toNamed(Routes.dashBoardRoute);
          CommonToast.showToast(title: "Login Successfully", isWarning: false);
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
          title: "Your Internet Connection is not stable", isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      CommonToast.showToast(title: e.toString(), isWarning: true);
    }
  }
}
