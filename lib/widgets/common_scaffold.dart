import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:investment_mindset/widgets/common_textfield.dart';

import '../constants/app_colors.dart';

class CommonScaffold extends StatelessWidget {
  final Widget? bodyData;
  final bool showFAB;
  final bool showAppBar;
  final bool extendBodyBehindAppBar;
  final double appbarelevation;
  final bool showDrawer;
  final String? appbarTitle;
  final Color? backGroundColors;
  final Color? appbarcolor;
  final Color? backarrow;
  final List<Widget>? actions;
  final Key? scaffoldKey;
  final bool showBottomNav;
  final IconData floatingIcon;
  final bool centerDocked;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final Widget? bottombar;

  const CommonScaffold({
    Key? key,
    this.bodyData,
    this.automaticallyImplyLeading = false,
    this.backarrow,
    this.appbarelevation = 0.0,
    this.appbarcolor,
    this.appbarTitle,
    this.leading,
    this.actions,
    this.bottombar,
    this.showFAB = false,
    this.showDrawer = false,
    this.showAppBar = false,
    this.extendBodyBehindAppBar = false,
    this.backGroundColors,
    this.scaffoldKey,
    this.showBottomNav = false,
    this.centerDocked = false,
    this.floatingIcon = Icons.add,
  }) : super(key: key);
// Widget myBottomBar() => BottomAppBar(
//         clipBehavior: Clip.antiAlias,
//         child: Container(
//           height:60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ReusableIconButton(
//                 icon: Icon(
//                   Icons.home_outlined,
//                   size: 20,
//                   color:
//                       Get.currentRoute
//                       == Routes.homeRoutes
//                       ? AppColors.indigo
//                       :
//                       Colors.grey,
//                 ),
//                 btntxt: Text(
//                   "Home",
//                   style:Get.currentRoute
//                       == Routes.homeRoutes ?
//                    GoogleFonts.mochiyPopOne(color: AppColors.indigo,fontWeight: FontWeight.bold,fontSize: 9) :
//                  GoogleFonts.mochiyPopOne(color: Colors.grey,fontSize: 9,fontWeight: FontWeight.w600)
//                 ),
//                 onPressed: () {
//                   if (Get.currentRoute != Routes.homeRoutes) {
//                     Get.toNamed(Routes.homeRoutes);
//                   }
//                 },
//               ),
//               ReusableIconButton(
//                 icon:  Icon(
//                   Icons.attach_money,
//                   size: 20,
//                   color:
//                       Get.currentRoute
//                       == Routes.rMp1oViPb3EdvcJ5kxoqe52RuaiK6YiUYo
//                       ? AppColors.indigo
//                       :
//                       Colors.grey,
//                 ),
//                 btntxt:  Text(
//                     "Transaction",
//                     textAlign: TextAlign.center,
//                      style:Get.currentRoute
//                       == Routes.rMp1oViPb3EdvcJ5kxoqe52RuaiK6YiUYo ?
//                    GoogleFonts.mochiyPopOne(color: AppColors.indigo,fontWeight: FontWeight.bold,fontSize: 9) :
//                  GoogleFonts.mochiyPopOne(color: Colors.grey,fontSize: 9,fontWeight: FontWeight.w600)
//                 ),

//                 onPressed: () {
//                    if (Get.currentRoute != Routes.rMp1oViPb3EdvcJ5kxoqe52RuaiK6YiUYo) {
//                     Get.toNamed(Routes.rMp1oViPb3EdvcJ5kxoqe52RuaiK6YiUYo);
//                   }
//                 },
//               ),
//               ReusableIconButton(
//                 icon:  Icon(
//                   Icons.person_outline,
//                   size: 20,
//                  color:
//                       Get.currentRoute
//                       == Routes.myaccountRoutes
//                       ? AppColors.indigo
//                       :
//                       Colors.grey,
//                 ),
//                 btntxt:  Text(
//                     "Account",
//                      style:Get.currentRoute
//                       == Routes.myaccountRoutes ?
//                    GoogleFonts.mochiyPopOne(color: AppColors.indigo,fontWeight: FontWeight.bold,fontSize: 9) :
//                  GoogleFonts.mochiyPopOne(color: Colors.grey,fontSize: 9,fontWeight: FontWeight.w600)
//                 ),

//                 onPressed: () {
//                    if (Get.currentRoute != Routes.myaccountRoutes) {
//                     Get.toNamed(Routes.myaccountRoutes);}
//                 }
//               ),

//             ],
//           ),
//         ),
//       );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: showAppBar
          ? AppBar(
              elevation: appbarelevation,
              automaticallyImplyLeading: automaticallyImplyLeading,
              backgroundColor: appbarcolor,
              title: Row(
                children: [
                  InkWell(
                      child: const Icon(
                        FontAwesomeIcons.user,
                        color: AppColors.whiteColor,
                      ),
                      onTap: () {
                        Get.back(result: true);
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 30,
                      child: CommonTextFormField1(
                        hintText: "Search Stocks",
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                InkWell(
                    child: const Icon(
                      FontAwesomeIcons.headset,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      Get.back(result: true);
                    }),
                InkWell(
                    child: const Icon(
                      FontAwesomeIcons.bell,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      Get.back(result: true);
                    }).marginSymmetric(horizontal: 7),
                InkWell(
                    child: const Icon(
                      FontAwesomeIcons.message,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      Get.back(result: true);
                    }).marginOnly(right: 10),
              ],
            )
          : null,
      //drawer: showDrawer ? ClipDrawer() : null,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          decoration: BoxDecoration(
            color: backGroundColors ?? const Color(0xffffffff),
          ),
          width: (MediaQuery.of(context).size.width.ceil()).toDouble(),
          height: (MediaQuery.of(context).size.height.ceil()).toDouble(),
          child: bodyData,
        );
      }),
      floatingActionButton: showFAB ? const SizedBox() : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: bottombar,
    );
  }
}
