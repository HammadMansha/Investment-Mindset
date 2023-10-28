// ignore_for_file: deprecated_member_use
import 'package:investment_mindset/constants/app_colors.dart';

import '../utils/app_libraries.dart';

class CircularButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const CircularButtons({
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      height: 50,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          gradient: LinearGradient(
              colors: [AppColors.commonColor, AppColors.commonColor1])),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w400,
              fontFamily: "Oswald",
              fontSize: 20),
        ),
      ),
    );
  }
}
