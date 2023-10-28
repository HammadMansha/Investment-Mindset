import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_text.dart';
import '../../controllers/splash/welcome_controller.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      bodyData: bodyData(),
    );
  }

  Widget bodyData() {
    return GetBuilder<WelcomeController>(
        init: WelcomeController(),
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.appLogoBlue),
              SizedBox(
                height: Get.height / 10.0,
              ),
              CircularButtons(
                onPressed: () {
                  _.authenticationController1.isSignup = true;
                  _.authenticationController.isLogin = false;
                  _.update();
                  Get.toNamed(Routes.authenticationRoutes);
                },
                text: AppTexts.signup,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CircularButtons(
                onPressed: () {
                  _.authenticationController1.isSignup = false;
                  _.authenticationController.isLogin = true;
                  _.update();
                  Get.toNamed(Routes.authenticationRoutes);
                },
                text: AppTexts.login,
              ),
              SizedBox(
                height: Get.height / 15.0,
              ),
              const Text(
                AppTexts.continuewith,
                style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 15,
                    fontFamily: "Oswald",
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Get.height / 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcons.facebook,
                  const SizedBox(width: 40),
                  Image.asset(AppImage.google)
                ],
              )
            ],
          );
        });
  }
}
