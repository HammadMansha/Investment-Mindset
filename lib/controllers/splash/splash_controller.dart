import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';

class SplashController extends GetxController {
  bool isLoading = true;
  @override
  void onReady() {
    loaddata();
    update();
    super.onReady();
  }

  Future<Timer> loaddata() async {
    return Timer(const Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() {
    Get.toNamed(Routes.dashBoardRoute);
  }
}
