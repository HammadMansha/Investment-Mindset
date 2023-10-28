import 'package:investment_mindset/views/chat/chat_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/analysis/analysis_controller.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_loader.dart';
import '../../widgets/common_textfield.dart';
import '../payment/payment_screen.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalysisController>(
        init: AnalysisController(),
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
                  hintText: "Search Analysis",
                  controller: _.searchAnalysis,
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

  Widget bodyData(BuildContext context, AnalysisController _) {
    return _.isLoading
        ? const Center(
            child: AppLoaders.appLoader,
          )
        : Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
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
                  children: [
                    const Text(
                      "Today’s Analysis ",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _.analysisList.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount: _.analysisList.length,
                            options: CarouselOptions(
                              height: 152.0,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 15),
                              autoPlayAnimationDuration: const Duration(
                                milliseconds: 800,
                              ),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 0.8,
                              aspectRatio: 16 / 9,
                            ),
                            itemBuilder: (context, i, id) {
                              //for onTap to redirect to another screen
                              return GestureDetector(
                                onTap: () async {
                                  _.singleAnalysisId = _.analysisList[i]['id'];
                                  if (kDebugMode) {
                                    print("id analysis${_.singleAnalysisId}");
                                  }
                                  await _.getSingleNews(_.singleAnalysisId);
                                  // ignore: use_build_context_synchronously
                                  showMyDialog(context, _);
                                },
                                child: Container(
                                  height: 182,
                                  width: Get.width / 1.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: AppColors.whiteColor,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: _.analysisList[i][
                                                                  'photoPath'] ==
                                                              null ||
                                                          _.analysisList[i]
                                                                  ['photoPath']
                                                              .toString()
                                                              .contains('/null')
                                                      ? const AssetImage(
                                                          AppImage.bitcoin)
                                                      : NetworkImage(
                                                              _.analysisList[i]
                                                                  ['photoPath'])
                                                          as ImageProvider),
                                            ),
                                          ).marginOnly(left: 6, top: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _.analysisList[i]['title'],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.textColor),
                                              ).marginOnly(
                                                  left: 9, right: 9, top: 12),
                                              SizedBox(
                                                width: Get.width / 2.0,
                                                height: 40,
                                                child: Text(
                                                  _.analysisList[i]
                                                      ['description'],
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .commonColor),
                                                ).marginOnly(
                                                    left: 9, right: 5, top: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          _.analysisList[i]['description'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.commonColor),
                                        ).marginOnly(
                                            top: 15, left: 7, right: 12),
                                      ),
                                    ],
                                  ),
                                ),
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
                                TyperAnimatedText('No Data Available'),
                              ],
                            ),
                          ).marginSymmetric(vertical: 20)
                  ],
                ),
              ),
              const Text(
                "More from this week",
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Roboto',
                    color: AppColors.textColor),
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
                              instructionsDialog(context);
                            })
                      ],
                    )
                  : Obx(
                      () => Expanded(
                        child: LiquidPullToRefresh(
                            onRefresh: _.getAnalysis,
                            color: AppColors.commonColor,
                            child: _.analysisList.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 40),
                                    itemCount: _.searchAnalysisData.isEmpty
                                        ? _.analysisList.length
                                        : _.searchAnalysisData.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () async {
                                          _.singleAnalysisId =
                                              _.analysisList[i]['id'];
                                          if (kDebugMode) {
                                            print(
                                                "id analysis${_.singleAnalysisId}");
                                          }
                                          await _.getSingleNews(
                                              _.singleAnalysisId);
                                          // ignore: use_build_context_synchronously
                                          showMyDialog(context, _);
                                        },
                                        child: Container(
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: AppColors.commonColor,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: Get.width / 3.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: _.searchAnalysisData
                                                                  .isEmpty
                                                              ? _.analysisList[i]['photoPath'] ==
                                                                          null ||
                                                                      _.analysisList[i]['photoPath']
                                                                          .toString()
                                                                          .contains(
                                                                              '/null')
                                                                  ? const AssetImage(
                                                                      AppImage
                                                                          .bitcoin)
                                                                  : NetworkImage(
                                                                          _.analysisList[i]['photoPath'])
                                                                      as ImageProvider
                                                              : _.searchAnalysisData[i]['photoPath'] ==
                                                                          null ||
                                                                      _.searchAnalysisData[i]
                                                                              ['photoPath']
                                                                          .toString()
                                                                          .contains('/null')
                                                                  ? const AssetImage(AppImage.bitcoin)
                                                                  : NetworkImage(_.searchAnalysisData[i]['photoPath']) as ImageProvider),
                                                    ),
                                                  ).marginOnly(
                                                      left: 12, top: 12),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        width: Get.width / 2.5,
                                                        child: Text(
                                                          _.searchAnalysisData
                                                                  .isEmpty
                                                              ? _.analysisList[
                                                                  i]['title']
                                                              : _.searchAnalysisData[
                                                                  i]['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                        ).marginOnly(
                                                            left: 9,
                                                            right: 5,
                                                            top: 12),
                                                      ),
                                                      SizedBox(
                                                          height: 40,
                                                          width:
                                                              Get.width / 2.5,
                                                          child: Text(
                                                                  _.searchAnalysisData
                                                                          .isEmpty
                                                                      ? _.analysisList[i]
                                                                          [
                                                                          'description']
                                                                      : _.searchAnalysisData[i]
                                                                          [
                                                                          'description'],
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white),
                                                                  maxLines: 2)
                                                              .marginOnly(
                                                                  left: 9,
                                                                  right: 9,
                                                                  top: 12)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: ReadMoreText(
                                                  _.searchAnalysisData.isEmpty
                                                      ? _.analysisList[i]
                                                          ['description']
                                                      : _.searchAnalysisData[i]
                                                          ['description'],
                                                  style: const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          AppColors.whiteColor),
                                                  trimLines: 2,
                                                  colorClickableText:
                                                      Colors.pink,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      'Show more',
                                                  trimExpandedText: 'Show less',
                                                  lessStyle: const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.whiteColor),
                                                  moreStyle: const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.whiteColor),
                                                ).marginOnly(
                                                    top: 15,
                                                    left: 12,
                                                    right: 12,
                                                    bottom: 10),
                                              ),
                                            ],
                                          ),
                                        ).marginOnly(
                                            bottom: 20, left: 40, right: 40),
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
                                        TyperAnimatedText('No Data Available'),
                                      ],
                                    ),
                                  ).marginSymmetric(vertical: 50)),
                      ),
                    )
            ]),
          );
  }

  Future<void> showMyDialog(context, AnalysisController _) async {
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
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: _.singleanalysisList['photoPath'] == null ||
                                _.singleanalysisList['photoPath']
                                    .toString()
                                    .contains('null')
                            ? const AssetImage(AppImage.bitcoin)
                            : NetworkImage(_.singleanalysisList['photoPath'])
                                as ImageProvider)),
              ),
              Text(
                _.singleanalysisList['title'].toString(),
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
              _.singleanalysisList['description'].toString(),
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
