import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/splash/splash_controller.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      bodyData: bodyData(),
    );
  }

  Widget bodyData() {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.appGradients)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImage.appLogo),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: Get.width / 2.5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.loadingColor,
                      color: AppColors.whiteColor,
                      minHeight: 5,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
