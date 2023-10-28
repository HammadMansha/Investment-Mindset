import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../widgets/common_scaffold.dart';
import '../analysis/analysis.dart';
import '../crypto_tracker/crypto_tracker_screen.dart';
import '../main page/main_page.dart';
import '../scale/all_scaling_screen.dart';
import '../setting/setting_screen.dart';
import '../videos/videos.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (_.navigationQueue.isEmpty) {
              return showWillPopMessage(context);
            }
            _.navigationQueue.removeLast();
            int position =
                _.navigationQueue.isEmpty ? 0 : _.navigationQueue.last;
            _.currentindex = position;
            _.update();
            return false;
          },
          child: CommonScaffold(
              bodyData: getBody(_),
              showBottomNav: true,
              bottombar: bottomnavbar(_)),
        );
      },
    );
  }

  showWillPopMessage(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: CommonColor.bottomSheetBackgroundColour,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Exit App?',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: SizedBox(
            height: 100.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Are you sure you want to exit App?',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto'),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () async {
                        Get.back();
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "CANCEL",
                        textScaleFactor: 1.0,
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 16),
                      ),
                      minWidth: Get.width / 3.5,
                      height: 48,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        side: const BorderSide(
                          color: AppColors.commonColor,
                        ),
                      ),
                      onPressed: () async {
                        if (Platform.isAndroid) {
                          exit(0);
                        } else {
                          exit(0);
                        }
                      },
                      minWidth: Get.width / 3.4,
                      height: 40,
                      child: const Text(
                        "Exit",
                        textScaleFactor: 1.0,
                        style: TextStyle(fontSize: 16),
                      ),
                      // color: CommonColor.greenColorWithOpacity,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomnavbar(DashboardController _) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          label: "",
          icon: Icon(
            // ignore: deprecated_member_use
            FontAwesomeIcons.home,

            size: 25.0,
          ),

          backgroundColor: AppColors.textColor,
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            FontAwesomeIcons.chartSimple,
            size: 25.0,
          ),
          backgroundColor: AppColors.textColor,
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            FontAwesomeIcons.scaleBalanced,
          ),
          backgroundColor: AppColors.textColor,
        ),
        BottomNavigationBarItem(
          label: "",
          // ignore: deprecated_member_use
          icon: Icon(
            // ignore: deprecated_member_use
            FontAwesomeIcons.search,
          ),
          backgroundColor: AppColors.textColor,
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            FontAwesomeIcons.circlePlay,
          ),
          backgroundColor: AppColors.whiteColor,
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.settings),
          backgroundColor: AppColors.whiteColor,
        ),
      ],
      currentIndex: _.currentindex,
      selectedItemColor: AppColors.textColor,
      selectedFontSize: 12.0,
      backgroundColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.dividerColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: _.changeTabIndex,
    );
  }

  Widget getBody(DashboardController _) {
    List<Widget> pages = const [
      MainPageScreen(),
      CryptoTrackerScreen(),
      AllScalingScreen(),
      AnalysisScreen(),
      VideoScreen(),
      AccountScreen()
    ];
    return IndexedStack(
      index: _.currentindex,
      children: pages,
    );
  }
}

class CommonColor {}
