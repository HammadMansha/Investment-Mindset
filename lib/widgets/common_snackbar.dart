import 'package:investment_mindset/utils/app_libraries.dart';

import '../constants/app_colors.dart';

class CustomSnackBar {
  static void showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    bool isWarning = false,
  }) {
    Get.snackbar(title, message,
        padding: const EdgeInsets.all(0),
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isWarning
                ? title == 'You are offline. Please connect to the internet.'
                    ? Image.asset('assets/images/nowifi.png')
                    : Container(
                        height: 23.0,
                        width: 23.0,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.warning,
                          color: AppColors.commonColor,
                          size: 18.0,
                        ),
                      )
                : Container(
                    height: 23.0,
                    width: 23.0,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.done,
                      color: AppColors.commonColor,
                      size: 18.0,
                    ),
                  ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                title,
                textScaleFactor: 1.0,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4),
              ),
            )
          ],
        ).marginOnly(top: 18.0, left: 10.0),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ).marginOnly(left: 10, bottom: 10),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(0));
  }
}
