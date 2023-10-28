import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../constants/app_colors.dart';
import '../../controllers/payment/payment_controller.dart';
import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';

class CreditCardView extends StatelessWidget {
  const CreditCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                Container(
                  height: Get.height / 4.0,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/background.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.dashBoardRoute);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.whiteColor,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Payment",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: AppColors.whiteColor),
                      ),
                    ],
                  ).marginOnly(left: 20),
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      _.useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: _.cardNumber,
                  expiryDate: _.expiryDate,
                  cardHolderName: _.cardHolderName,
                  cvvCode: _.cvvCode,
                  showBackView: _.isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: AppColors.commonColor,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: _.formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: _.cardNumber.toString(),
                          cvvCode: _.cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: _.cardHolderName,
                          expiryDate: _.expiryDate,
                          themeColor: AppColors.commonColor,
                          textColor: Colors.black,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle:
                                const TextStyle(color: AppColors.commonColor),
                            labelStyle:
                                const TextStyle(color: AppColors.commonColor),
                            focusedBorder: _.border,
                            enabledBorder: _.border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.commonColor),
                            labelStyle:
                                const TextStyle(color: AppColors.commonColor),
                            focusedBorder: _.border,
                            enabledBorder: _.border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.commonColor),
                            labelStyle:
                                const TextStyle(color: AppColors.commonColor),
                            focusedBorder: _.border,
                            enabledBorder: _.border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.commonColor),
                            labelStyle:
                                const TextStyle(color: AppColors.commonColor),
                            focusedBorder: _.border,
                            enabledBorder: _.border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: _.onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Glassmorphism',
                              style: TextStyle(
                                color: AppColors.commonColor,
                                fontSize: 18,
                              ),
                            ),
                            Switch(
                                value: _.useGlassMorphism,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.white,
                                activeTrackColor: AppColors.commonColor,
                                onChanged: (bool value) {
                                  _.useGlassMorphism = value;
                                  _.update();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: const Color(0xff1b447b),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: const Text(
                              'Validate',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_.formKey.currentState!.validate()) {
                              if (kDebugMode) {
                                print('valid!');
                              }
                              _.paymentWithStripe();
                            } else {
                              if (kDebugMode) {
                                print('invalid!');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
