import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';

import 'package:http/http.dart' as http;
import 'package:investment_mindset/views/chat/chat_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';
import '../../controllers/crypto_tracker/crypto_tracker_controller.dart';
import '../../models/coinsmodel.dart';
import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import '../payment/payment_screen.dart';

class CryptoTrackerScreen extends StatefulWidget {
  const CryptoTrackerScreen({Key? key}) : super(key: key);

  @override
  State<CryptoTrackerScreen> createState() => _CryptoTrackerScreenState();
}

class _CryptoTrackerScreenState extends State<CryptoTrackerScreen> {
  final storage = GetStorage();

  var graphDataList = <CoinsModel>[].obs;

  var searchDataList = <CoinsModel>[].obs;

  bool isLoading = true;

  // ignore: prefer_typing_uninitialized_variables
  var response;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 15), (Timer t) => getGraph());
    super.initState();
  }

  Future<void> getGraph() async {
    setState(() {
      isLoading = true;
    });
    graphDataList.clear();
    try {
      String token = await storage.read('accesstoken');
      var res = await http.get(
          Uri.parse('${ApiData.baseUrl}${ApiData.cryptocurrency}1000'),
          headers: {'Authorization': 'Bearer $token'});
      var result = jsonDecode(res.body);
      response = json.decode(res.statusCode.toString());
      if (kDebugMode) {
        print("The status code of crypto api is $response");
      }
      result.forEach((e) {
        setState(() {
          graphDataList.add(CoinsModel.fromJson(e));
        });
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error is ${e.toString()}");
      }
    }
  }

  searchFunction(String v) {
    if (v.isEmpty || v == '') {
      searchDataList.clear();
    } else {
      searchDataList.clear();
      for (var e in graphDataList) {
        if (e.name.toString().toLowerCase().contains(v.toLowerCase())) {
          searchDataList.add(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CryptoTrackerController>(
        init: CryptoTrackerController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: true,
              backgroundColor: AppColors.transparentColor,
              title: SizedBox(
                height: 30,
                child: CommonTextFormField1(
                  hintText: "Search Stocks",
                  controller: _.searchStocks,
                  onChanged: (c) {
                    searchFunction(c);
                  },
                ),
              ).marginOnly(right: 15),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(const GroupChatScreen());
                      },
                      child: const Icon(Icons.chat)),
                )
              ],
            ),
            extendBodyBehindAppBar: true,
            body: bodyData(context, _),
          );
        });
  }

  Widget bodyData(BuildContext context, CryptoTrackerController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height / 5,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(AppImage.background)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppTexts.cryptoTracker,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w900),
            ).marginOnly(bottom: 20),
          ],
        ).marginSymmetric(horizontal: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              AppTexts.names,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor),
            ),
            Text(
              AppTexts.price,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor),
            ),
          ],
        ).marginOnly(top: 10, right: 30, left: 70),
        const Divider(
          color: AppColors.dividerColor,
          thickness: 1.5,
          endIndent: 15,
          indent: 50,
        ),
        isLoading
            ? Center(
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Bobbers',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppColors.greyColor),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText('Updating...\nPlease wait!',
                          textAlign: TextAlign.center),
                    ],
                  ),
                ).marginSymmetric(vertical: 100, horizontal: 10),
              )
            : response == 400
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        "Free trial has been expired.\n You need to upgrade your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CircularButtons(
                          text: "Upgrade",
                          onPressed: () {
                            instructionsDialog(context);
                          })
                    ],
                  )
                : Obx(
                    () => Expanded(
                      child: LiquidPullToRefresh(
                        onRefresh: getGraph,
                        color: AppColors.commonColor,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 25,
                          ),
                          itemCount: searchDataList.isEmpty
                              ? graphDataList.length
                              : searchDataList.length,
                          itemBuilder: (c, i) => GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                print("Check Data ${graphDataList[i]}");
                              }
                              searchDataList.isEmpty
                                  ? Get.toNamed(Routes.cryptoDetailsRoute,
                                      arguments: {"details": graphDataList[i]})
                                  : Get.toNamed(Routes.cryptoDetailsRoute,
                                      arguments: {
                                          "details": searchDataList[i]
                                        });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: searchDataList.isEmpty
                                          ? graphDataList[i].logo == ''
                                              ? const AssetImage(
                                                  AppImage.bitcoin)
                                              : NetworkImage(
                                                      graphDataList[i].logo!)
                                                  as ImageProvider
                                          : searchDataList[i].logo == ''
                                              ? const AssetImage(
                                                  AppImage.bitcoin)
                                              : NetworkImage(
                                                      searchDataList[i].logo!)
                                                  as ImageProvider,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        searchDataList.isEmpty
                                            ? "${graphDataList[i].name}"
                                            : "${searchDataList[i].name}",
                                        style: const TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: AppColors.ratingColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${i + 1}",
                                              style: const TextStyle(
                                                  color: AppColors.textColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          searchDataList.isEmpty
                                              ? "${graphDataList[i].symbol}"
                                              : "${searchDataList[i].symbol}",
                                          style: const TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ).marginSymmetric(horizontal: 4),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Sparkline(
                                    data: [
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange90D!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange90D!,
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange60D!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange60D!,
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange30D!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange30D!,
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange7D!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange7D!,
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange24H!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange24H!,
                                      searchDataList.isEmpty
                                          ? graphDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange1H!
                                          : searchDataList[i]
                                              .quote!
                                              .usd!
                                              .percentChange1H!,
                                    ],
                                    lineColor: AppColors.greenColor,
                                    lineWidth: 2.0,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  searchDataList.isEmpty
                                      ? "${double.parse(graphDataList[i].quote!.usd!.price!.toString()).round()}"
                                      : "${double.parse(searchDataList[i].quote!.usd!.price!.toString()).round()}",
                                  style: const TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ).marginOnly(right: 10)
                              ],
                            ),
                          ),
                        ).marginSymmetric(horizontal: 10),
                      ),
                    ),
                  )
      ],
    );
  }

  Future<void> instructionsDialog(
    context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: AppColors.commonColor),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () async {
                    Get.to(const CreditCardView());
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Upgrade",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.commonColor),
                  ),
                  minWidth: Get.width / 3.5,
                  height: 38,
                ),
                MaterialButton(
                  onPressed: () async {
                    Get.back();
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "CLOSE",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.commonColor),
                  ),
                  minWidth: Get.width / 3.5,
                  height: 38,
                ),
              ],
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Instructions",
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.commonColor,
                  letterSpacing: 0.4,
                  fontFamily: 'Roboto',
                ),
              ).marginOnly(top: 10),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: ["Payment will only be done through Stripe"],
                  listOrder: ListOrder.ordered,
                ),
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: ["Payment will be monthly based"],
                  listOrder: ListOrder.ordered,
                ),
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: ["\u002410 will be charged monthly"],
                  listOrder: ListOrder.ordered,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
