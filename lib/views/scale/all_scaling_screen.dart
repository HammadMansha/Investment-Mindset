import 'package:investment_mindset/views/chat/chat_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/scaling/all_scaling_controller.dart';
import '../../utils/app_libraries.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_loader.dart';
import '../../widgets/common_textfield.dart';
import '../payment/payment_screen.dart';

class AllScalingScreen extends StatelessWidget {
  const AllScalingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllScalingController>(
        init: AllScalingController(),
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
                  hintText: "Search Scaling",
                  controller: _.searchScaling,
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

  Widget bodyData(BuildContext context, AllScalingController _) {
    return _.isLoading
        ? const Center(
            child: AppLoaders.appLoader,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height / 4.0,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(AppImage.background)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Take a look at \n Scaling !!!",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.commonColor),
              ).marginOnly(left: 20),
              _.response == 400
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              instructionsDialog(
                                context,
                              );
                            })
                      ],
                    ).marginSymmetric(horizontal: 60)
                  : Obx(() => Expanded(
                      child: LiquidPullToRefresh(
                          onRefresh: _.getScaling,
                          color: AppColors.commonColor,
                          child: _.scalingList.isNotEmpty
                              ? ListView.separated(
                                  padding: const EdgeInsets.only(
                                      bottom: 25, top: 10),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: _.searchScalingData.isEmpty
                                      ? _.scalingList.length
                                      : _.searchScalingData.length,
                                  itemBuilder: (context, index) => Container(
                                        height: 70,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: _.searchScalingData
                                                            .isEmpty
                                                        ? _.scalingList[index]['photoPath'] ==
                                                                null
                                                            ? const AssetImage(
                                                                AppImage
                                                                    .bitcoin)
                                                            : NetworkImage(_.scalingList[index]['photoPath'])
                                                                as ImageProvider
                                                        : _.searchScalingData[index]['photoPath'] ==
                                                                null
                                                            ? const AssetImage(
                                                                AppImage
                                                                    .bitcoin)
                                                            : NetworkImage(_
                                                                        .searchScalingData[index]
                                                                    ['photoPath'])
                                                                as ImageProvider),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _.searchScalingData.isEmpty
                                                  ? _.scalingList[index]
                                                      ['title']
                                                  : _.searchScalingData[index]
                                                      ['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.commonColor),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _.searchScalingData.isEmpty
                                                      ? _.scalingList[index]
                                                          ['company']
                                                      : _.searchScalingData[
                                                          index]['company'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          Routes.scalingRoutes,
                                                          arguments: {
                                                            "id": _.searchScalingData
                                                                    .isEmpty
                                                                ? '${_.scalingList[index]["id"]}'
                                                                : '${_.searchScalingData[index]["id"]}'
                                                          });
                                                      if (kDebugMode) {
                                                        print(
                                                            "The id of that scaling is ${_.scalingList[index]["id"]}");
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.chevron_right,
                                                      color:
                                                          AppColors.commonColor,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ).marginSymmetric(horizontal: 10),
                                      ).marginSymmetric(horizontal: 20))
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
                                  ).marginSymmetric(vertical: 50),
                                ))))
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
