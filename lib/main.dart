import 'package:flutter/services.dart';
import 'package:investment_mindset/app.dart';
import 'package:investment_mindset/services/auth_service.dart';
import 'package:investment_mindset/utils/app_libraries.dart';
import 'package:firebase_core/firebase_core.dart';


import 'constants/app_colors.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.dark),
  );
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  AuthService auth = AuthService();
  await Get.putAsync(() => auth.init());
}
