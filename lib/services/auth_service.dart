
import '../utils/app_libraries.dart';

class AuthService extends GetxService {
  bool loggedInUser = false;
  final storage = GetStorage();

  Future<AuthService> init() async {
    await isBiocheck();
    return this;
  }

  Future<bool> isBiocheck() async {
    if (kDebugMode) {
      print(storage.read("accesstoken"));
    }
    if (storage.hasData("accesstoken")) {
      loggedInUser = true;
    } else {
      loggedInUser = false;
    }
    return loggedInUser;
  }
}
