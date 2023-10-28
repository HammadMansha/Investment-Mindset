import 'dart:collection';

import '../../utils/app_libraries.dart';

class DashboardController extends GetxController {
  int currentindex = 0;
  ListQueue<int> navigationQueue = ListQueue();

// this is a very useless application made by hamza, hammad and moeez

  void changeTabIndex(int index) {
    currentindex = index;

    if (index == currentindex) {
      navigationQueue.clear();
      // navigationQueue.removeWhere((element) => element == index);
      navigationQueue.addLast(index);
      currentindex = index;
      update();
    }
    update();
    checkdata();
  }

  void checkdata() {
    // ignore: avoid_function_literals_in_foreach_calls
    navigationQueue.forEach((element) {});
  }
}
