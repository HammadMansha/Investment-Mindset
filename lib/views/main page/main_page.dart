import 'package:investment_mindset/views/chat/chat_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';
import '../../controllers/main page/main_page_controller.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_loader.dart';
import '../../widgets/common_textfield.dart';
import '../payment/payment_screen.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
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
              elevation: 0.0,
              automaticallyImplyLeading: true,
              backgroundColor: AppColors.transparentColor,
              title: SizedBox(
                height: 30,
                child: CommonTextFormField1(
                  hintText: "Search News",
                  controller: _.searchNews,
                  onChanged: (c) {
                    _.searchFunction(c);
                  },
                ),
              ).marginOnly(right: 15),
            ),
            extendBodyBehindAppBar: true,
            body: bodyData(context, _),
          );
        });
  }

  Widget bodyData(BuildContext context, MainPageController _) {
    return _.isLoading
        ? const Center(
            child: AppLoaders.appLoader,
          )
        : Container(
            height: Get.height,
            width: Get.width,
            color: AppColors.whiteColor,
            child: Column(children: [
              Container(
                height: Get.height / 2.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    "assets/images/background.png",
                  ),
                  fit: BoxFit.fill,
                )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        AppTexts.hotCryptoNews,
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: AppColors.whiteColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(FontAwesomeIcons.chevronDown,
                          color: AppColors.whiteColor)
                    ]),
              ),
              _.response == 400
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
                              // Get.to(const CreditCardView());
                              instructionsDialog(context, _);
                            })
                      ],
                    )
                  : _.paymentController1.apiMesage ==
                              'App Charges Paid Successfully'.toString() ||
                          _.response != 400
                      ? Obx(
                          () => Expanded(
                            child: LiquidPullToRefresh(
                                onRefresh: _.getNews,
                                color: AppColors.commonColor,
                                child: _.newsList.isNotEmpty
                                    ? ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 60),
                                        itemCount: _.searchNewsData.isEmpty
                                            ? _.newsList.length
                                            : _.searchNewsData.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                            onTap: () async {
                                              _.singleNewsId =
                                                  _.newsList[i]['id'];
                                              if (kDebugMode) {
                                                print(
                                                    "Single job id is${_.singleNewsId}");
                                              }

                                              await _.getSingleNews(
                                                  _.singleNewsId);
                                              // ignore: use_build_context_synchronously
                                              showMyDialog(context, _);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.buttonColor,
                                                borderRadius:
                                                    BorderRadius.circular(17.0),
                                              ),
                                              height: 101,
                                              width: 230,
                                              child: Row(
                                                children: [
                                                  //-----------Image container--------
                                                  Container(
                                                    height: Get.height,
                                                    width: Get.width / 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(17),
                                                        topLeft:
                                                            Radius.circular(17),
                                                      ),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: _.searchNewsData
                                                                  .isEmpty
                                                              ? _.newsList[i]['photoPath'] ==
                                                                          null ||
                                                                      _.newsList[i]['photoPath']
                                                                          .toString()
                                                                          .contains(
                                                                              '/null')
                                                                  ? const AssetImage(
                                                                      AppImage
                                                                          .bitcoin)
                                                                  : NetworkImage(
                                                                          _.newsList[i]['photoPath'])
                                                                      as ImageProvider
                                                              : _.searchNewsData[i]['photoPath'] ==
                                                                          null ||
                                                                      _.searchNewsData[i]
                                                                              ['photoPath']
                                                                          .toString()
                                                                          .contains('/null')
                                                                  ? const AssetImage(AppImage.bitcoin)
                                                                  : NetworkImage(_.searchNewsData[i]['photoPath']) as ImageProvider),
                                                    ),
                                                  ),

                                                  //--------------Text Container-------------
                                                  SizedBox(
                                                    height: Get.height,
                                                    width: 175,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _.searchNewsData
                                                                  .isEmpty
                                                              ? _.newsList[i]
                                                                  ['title']
                                                              : _.searchNewsData[
                                                                  i]['title'],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ).marginOnly(
                                                            top: 14, left: 6),
                                                        Text(
                                                          _.searchNewsData
                                                                  .isEmpty
                                                              ? _.newsList[i][
                                                                  'description']
                                                              : _.searchNewsData[
                                                                      i][
                                                                  'description'],
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .white),
                                                        ).marginOnly(
                                                            top: 3, left: 6),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      _.singleNewsId = _
                                                              .searchNewsData
                                                              .isEmpty
                                                          ? _.newsList[i]['id']
                                                          : _.searchNewsData[i]
                                                              ['id'];
                                                      if (kDebugMode) {
                                                        print(
                                                            "Single job id is${_.singleNewsId}");
                                                      }

                                                      await _.getSingleNews(
                                                          _.singleNewsId);
                                                      // ignore: use_build_context_synchronously
                                                      showMyDialog(context, _);
                                                    },
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColors
                                                                  .whiteColor),
                                                      child: Center(
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_forward_outlined,
                                                          color: AppColors
                                                              .textColor,
                                                          size: 15,
                                                        ).marginOnly(right: 5),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ).marginOnly(
                                                bottom: 10,
                                                right: 15,
                                                left: 15),
                                          );
                                        },
                                      )
                                    : DefaultTextStyle(
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
                                            TyperAnimatedText(
                                                'No Data Available'),
                                          ],
                                        ),
                                      ).marginSymmetric(vertical: 100)),
                          ),
                        )
                      : const Text("data")
            ]),
          );
  }

  Future<void> instructionsDialog(context, MainPageController _) async {
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

  Future<void> showMyDialog(context, MainPageController _) async {
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: Get.height / 4,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: _.singleNewsList['photoPath'] == null ||
                                _.singleNewsList['photoPath']
                                    .toString()
                                    .contains('/null')
                            ? const AssetImage(AppImage.bitcoin)
                            : NetworkImage(_.singleNewsList['photoPath'])
                                as ImageProvider)),
              ),
              Text(
                _.singleNewsList['title'].toString(),
                textScaleFactor: 1.0,
                style: const TextStyle(
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
            child: Text(
              _.singleNewsList['description'].toString(),
              textScaleFactor: 1.0,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.greyColor,
                letterSpacing: 0.4,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        );
      },
    );
  }
}
