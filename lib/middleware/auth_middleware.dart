import '../services/auth_service.dart';
import '../utils/app_libraries.dart';
import '../utils/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  AuthService authService = Get.find<AuthService>();
  @override
  RouteSettings? redirect(String? route) {
    return authService.loggedInUser
        ? null
        : const RouteSettings(name: Routes.authenticationRoutes);
  }
}
