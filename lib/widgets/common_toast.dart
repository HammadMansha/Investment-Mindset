import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';
import '../utils/app_libraries.dart';

class CommonToast {
  static void showToast({
    required String title,
    bool isWarning = false,
  }) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isWarning == true ? Colors.red : AppColors.commonColor2,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
}
