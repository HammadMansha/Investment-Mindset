import 'dart:math' as math;

import 'package:investment_mindset/utils/app_libraries.dart';

import '../../models/graph_model.dart';

class CryptoTrackerController extends GetxController {
  bool isLoading = true;

  bool isStocks = false;

  bool isCrypto = true;

  TextEditingController searchStocks = TextEditingController();

  List<LiveData> chartData = [];

  var searchCryptoData = [].obs;

  var nodata = false.obs;

  int time = 10;

  late ChartSeriesController chartSeriesController;

  void initState() async {
    chartData = [
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
    update();
  }

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  void getControllerData(ChartSeriesController controller) {
    chartSeriesController = controller;
    update();
  }

  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }
}
