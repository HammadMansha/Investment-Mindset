import 'package:flutter_credit_card/credit_card_model.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_toast.dart';

class PaymentController extends GetxController {
  bool isLoading = true;

  String cardNumber = '';

  String expiryDate = '';

  String expiryMonth = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  OutlineInputBorder? border;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final storage = GetStorage();

  String apiMesage = '';

  @override
  void onReady() async {
    // await getScaling();
    isLoading = false;
    update();
    super.onReady();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber = creditCardModel!.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    update();
  }

  Future paymentWithStripe() async {
    try {
      String token = await storage.read('accesstoken');

      if (kDebugMode) {
        print("number$cardNumber");
      }

      if (kDebugMode) {
        print("date$expiryDate");
      }

      cardNumber.replaceAll(' ', '');
      var abc = expiryDate.split('/').toString();
      expiryMonth = abc[1] + abc[2];
      var expiryYear = abc[5] + abc[6];
      if (kDebugMode) {
        print("expiry month is$abc");
      }
      if (kDebugMode) {
        print("expiry month is$expiryMonth");
      }
      if (kDebugMode) {
        print("expiry month is$expiryYear");
      }

      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.stripePayment),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "number": cardNumber,
          "exp_month": expiryMonth,
          "exp_year": expiryYear,
          "cvc": cvvCode
        }),
      );
      var result = json.decode(res.body);
      if (kDebugMode) {
        print("status code for stripe api${res.statusCode}");
      }
      if (res.statusCode == 200) {
        CommonToast.showToast(
            title:
                "Payment has been successed Login again to use the full features of the app",
            isWarning: false);

        Get.offAllNamed(Routes.dashBoardRoute);
      }

      Get.log('SPayment link in view $result');
      apiMesage = result;
      if (kDebugMode) {
        print("The data is $result ");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error$e");
      }
    }
  }
}
