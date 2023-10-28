
import 'package:investment_mindset/constants/app_assets.dart';
import 'package:investment_mindset/constants/app_colors.dart';
import 'package:investment_mindset/constants/app_text.dart';
import 'package:investment_mindset/models/graph_model.dart';
import 'package:investment_mindset/utils/app_libraries.dart';

import '../../controllers/crypto_tracker/crypto_details_controller.dart';
import '../../widgets/common_loader.dart';

class CryptoDetailsScreen extends StatelessWidget {
  const CryptoDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // showAppBar: true,
      // appbarcolor: AppColors.transparentColor,
      // appbarelevation: 0.0,
      extendBodyBehindAppBar: true,
      body: bodyData(),
    );
  }

  Widget bodyData() {
    return GetBuilder<CryptoDetailController>(
        init: CryptoDetailController(),
        builder: (_) {
          return _.isLoading
              ? const Center(
                  child: AppLoaders.appLoader,
                )
              : Column(
                  children: [
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
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: AppColors.whiteColor,
                              )),
                          SizedBox(
                            width: Get.width / 1.2,
                            child: Text(
                              '${_.coinsModel.name} Details',
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: _.coinsModel.logo == ''
                                          ? const AssetImage(AppImage.bitcoin)
                                          : NetworkImage(_.coinsModel.logo!)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: Get.width / 1.4,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${_.coinsModel.name}',
                                          style: const TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        TextSpan(
                                          text: ' /${_.coinsModel.symbol}',
                                          style: const TextStyle(
                                              color: AppColors.greyColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                commonText(AppTexts.price),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    commonText("1h%"),
                                    commonText("24h%")
                                        .marginSymmetric(horizontal: 10),
                                    commonText("7days%"),
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                              color: AppColors.dividerColor,
                              thickness: 1.5,
                            ).marginSymmetric(vertical: 7),
                            Row(
                              children: [
                                Text(
                                  "${double.parse(_.coinsModel.quote!.usd!.price!.toString()).round()}",
                                  style: const TextStyle(
                                      color: AppColors.greenColor,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      _.coinsModel.quote!.usd!.percentChange1H!
                                          .toStringAsFixed(5),
                                      style: TextStyle(
                                          color: _.coinsModel.quote!.usd!
                                                      .percentChange1H! <
                                                  0.0
                                              ? AppColors.redColor
                                              : AppColors.greenColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      _.coinsModel.quote!.usd!.percentChange24H!
                                          .toStringAsFixed(5),
                                      style: TextStyle(
                                          color: _.coinsModel.quote!.usd!
                                                      .percentChange24H! <
                                                  0.0
                                              ? AppColors.redColor
                                              : AppColors.greenColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ).marginSymmetric(horizontal: 10),
                                    Text(
                                      _.coinsModel.quote!.usd!.percentChange7D!
                                          .toStringAsFixed(5),
                                      style: TextStyle(
                                        color: _.coinsModel.quote!.usd!
                                                    .percentChange7D! <
                                                0.0
                                            ? AppColors.redColor
                                            : AppColors.greenColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: Get.height / 2.5,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  legend: Legend(isVisible: false),
                                  series: <LineSeries<SalesData, String>>[
                                    LineSeries<SalesData, String>(
                                      enableTooltip: false,
                                      color: AppColors.greenColor,
                                      isVisibleInLegend: false,
                                      isVisible: true,
                                      animationDelay: 5.0,
                                      dataSource: <SalesData>[
                                        SalesData(
                                            '90 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange90D!),
                                        SalesData(
                                            '60 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange60D!),
                                        SalesData(
                                            '30 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange30D!),
                                        SalesData(
                                            '7 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange7D!),
                                        SalesData(
                                            '24 H',
                                            _.coinsModel.quote!.usd!
                                                .percentChange24H!),
                                        SalesData(
                                            '1 H',
                                            _.coinsModel.quote!.usd!
                                                .percentChange1H!),
                                      ],
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.sales,
                                    )
                                  ]),
                            ).marginSymmetric(vertical: 30),
                            SizedBox(
                              height: Get.height / 3.0,
                              width: Get.width,
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  legend: Legend(isVisible: false),
                                  series: <ChartSeries<SalesData, String>>[
                                    ColumnSeries<SalesData, String>(
                                      enableTooltip: false,
                                      color: const Color(0xff2C42B4),
                                      isVisibleInLegend: false,
                                      isVisible: true,
                                      animationDelay: 5.0,
                                      dataSource: <SalesData>[
                                        SalesData(
                                            '90 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange90D!),
                                        SalesData(
                                            '60 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange60D!),
                                        SalesData(
                                            '30 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange30D!),
                                        SalesData(
                                            '7 D',
                                            _.coinsModel.quote!.usd!
                                                .percentChange7D!),
                                        SalesData(
                                            '24 H',
                                            _.coinsModel.quote!.usd!
                                                .percentChange24H!),
                                        SalesData(
                                            '1 H',
                                            _.coinsModel.quote!.usd!
                                                .percentChange1H!),
                                      ],
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.sales,
                                    )
                                  ]),
                            )
                          ],
                        ).marginSymmetric(horizontal: 20, vertical: 20),
                      ),
                    )
                  ],
                );
        });
  }

  Widget commonText(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: AppColors.greyTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w300),
    );
  }
}
