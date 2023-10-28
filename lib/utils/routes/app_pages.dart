import 'package:get/get.dart';
import 'package:investment_mindset/views/auth/password/change_password.dart';
import 'package:investment_mindset/views/scale/scaling_screen.dart';

import '../../middleware/auth_middleware.dart';
import '../../views/analysis/analysis.dart';
import '../../views/auth/authentication_screen.dart';
import '../../views/crypto_tracker/crypto_details_screen.dart';
import '../../views/crypto_tracker/crypto_tracker_screen.dart';
import '../../views/dashboard/dashboard_screen.dart';
import '../../views/edit_profile/edit_profile_screen.dart';
import '../../views/main page/main_page.dart';
import '../../views/splash/splash_screen.dart';
import '../../views/splash/welcome_screen.dart';
import '../../views/videos/videos.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splashRoutes;
  // static const initial1 = Routes.dashBoardRoute;

  static final routes = [
    // < -------------------- Splash Page ----------------->

    GetPage(
      name: Routes.splashRoutes,
      page: () => const SplashScreen(),
    ),

    // < -------------------- Welcome Page ----------------->

    GetPage(
      name: Routes.welcomeRoutes,
      page: () => const WelcomeScreen(),
    ),

    // < -------------------- Authentication Page ----------------->

    GetPage(
      name: Routes.authenticationRoutes,
      page: () => const AuthenticationScreen(),
    ),

    // < -------------------- Main Page ----------------->

    GetPage(
      name: Routes.mainPageRoutes,
      page: () => const MainPageScreen(),
    ),

    // < --------------------Analysis Page ----------------->

    GetPage(
      name: Routes.analysisPageRoutes,
      page: () => const AnalysisScreen(),
    ),

    // < -------------------- Crypto Tracker Page ----------------->

    GetPage(
      name: Routes.cryptoTrackerRoutes,
      page: () => const CryptoTrackerScreen(),
    ),

    // < -------------------- Scaling Page ----------------->

    GetPage(
      name: Routes.scalingRoutes,
      page: () => const ScalingScreen(),
    ),

    //---------------  Video page Routes----------
    GetPage(
      name: Routes.videoPageRoute,
      page: () => const VideoScreen(),
    ),

    //--------------- DashBoard page Routes----------
    GetPage(
      name: Routes.dashBoardRoute,
      middlewares: [AuthMiddleware()],
      page: () => const Dashboard(),
    ),

    //--------------- Crypto Details page Routes----------
    GetPage(
      name: Routes.cryptoDetailsRoute,
      page: () => const CryptoDetailsScreen(),
    ),

    //--------------- Crypto Details page Routes----------
    GetPage(
      name: Routes.changePasswordRoute,
      page: () => const ChangePassword(),
    ),
//---------------------Update user profile screen
    GetPage(
      name: Routes.editProfileRoute,
      page: () => const EditProfileScreen(),
    ),
  ];
}
