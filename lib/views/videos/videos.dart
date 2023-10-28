import 'package:investment_mindset/views/chat/chat_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../constants/app_colors.dart';
import '../../controllers/video/video_controller.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/video_player.dart';
import '../payment/payment_screen.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        init: VideoController(),
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
                  hintText: "Search Videos",
                  controller: _.searchVideo,
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

  Widget bodyData(BuildContext context, VideoController _) {
    return Column(
      children: [
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Roboto'),
                ).marginOnly(top: 40, bottom: 20, left: 25),
                Column(
                  children: [
                    const Text(
                      "Today’s Video's ",
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
                              return Container(
                                height: 182,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: VideoWidget(
                                  play: false,
                                  url: '${_.analysisList[i]['photoPath']}',
                                ),
                              );
                            },
                          )
                        : Center(
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
                                  TyperAnimatedText('No Data Available'),
                                ],
                              ),
                            ).marginSymmetric(vertical: 20),
                          )
                  ],
                ),
              ],
            )),
        const Text(
          "More Vidoes",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 40),
                              itemCount: _.searchVideoData.isEmpty
                                  ? _.analysisList.length
                                  : _.searchVideoData.length,
                              itemBuilder: (context, i) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 302,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.black),
                                      child: VideoWidget(
                                        play: false,
                                        url:
                                            '${_.analysisList[i]['photoPath']}',
                                      ),
                                    ).marginOnly(
                                        left: 25.0, right: 25.0, bottom: 10),
                                    Text(
                                      _.searchVideoData.isEmpty
                                          ? _.analysisList[i]['name']
                                          : _.searchVideoData[i]['name'],
                                      style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ).marginOnly(left: 30, top: 20),
                                  ],
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
