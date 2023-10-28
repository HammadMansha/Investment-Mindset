import '../../utils/app_libraries.dart';
import '../auth/authentication_controller.dart';

class WelcomeController extends GetxController {
  bool isLoading = true;

  bool isStarred = false;
  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  AuthenticationController authenticationController1 =
      Get.find<AuthenticationController>();
}
