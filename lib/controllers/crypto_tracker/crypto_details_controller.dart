import '../../models/coinsmodel.dart';
import '../../utils/app_libraries.dart';

class CryptoDetailController extends GetxController {
  bool isLoading = true;
  late TooltipBehavior tooltipBehavior;

  late CoinsModel coinsModel;

  @override
  void onInit() async{
    tooltipBehavior = TooltipBehavior(enable: true);
    if (kDebugMode) {
      print("Data is ${Get.arguments}");
    }
    if(Get.arguments != null)
      {
        coinsModel = Get.arguments['details'];
      }
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }
}
