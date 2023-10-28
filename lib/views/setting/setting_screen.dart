import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/setting/setting_controller.dart';
import '../../utils/routes/app_routes.dart';
import '../../widgets/common_toast.dart';
import '../auth/password/change_password.dart';
import '../edit_profile/edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: GlobalBottomNav(),
      body: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
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
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Setting",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: AppColors.whiteColor),
                      ),
                    ).marginOnly(left: 30),
                  ),
                  ListView(shrinkWrap: true, children: [
                    options(
                      text: 'Change Password',
                      subTitle: 'You can change your password',
                      icon: Icons.lock,
                      onTap: () {
                        Get.to(() => const ChangePassword());
                      },
                    ),
                    options(
                      text: 'Edit Profile',
                      subTitle: 'You can edit your profile',
                      icon: Icons.account_circle_outlined,
                      onTap: () {
                        Get.to(() => const EditProfileScreen());
                      },
                    ),
                    // options(
                    //   text: 'Upgrade Premium',
                    //   subTitle:
                    //       'You can pay through Stripe to enjoy full features',
                    //   icon: Icons.workspace_premium,
                    //   onTap: () {
                    //     Get.to(() => const GroupChatScreen());
                    //   },
                    // ),
                    options(
                      text: 'Logout',
                      subTitle: '',
                      icon: Icons.logout,
                      onTap: () {
                        _showMyDialog(context, _);
                      },
                    ),
                  ])
                ],
              ));
        });
  }

  Widget options(
      {String? text, String? subTitle, IconData? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.commonColor,
      hoverColor: AppColors.commonColor,
      focusColor: AppColors.commonColor,
      child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.0,
                width: 60.0,
                child: Icon(icon, color: AppColors.commonColor),
              ).marginOnly(left: 20.0),
              const SizedBox(
                width: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 1.4,
                    child: Text(
                      text!,
                      textScaleFactor: 1.0,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: AppColors.commonColor),
                    ),
                  ),
                  subTitle == ''
                      ? const SizedBox()
                      : const SizedBox(
                          height: 5.0,
                        ),
                  subTitle == ''
                      ? const SizedBox()
                      : SizedBox(
                          width: Get.width / 1.4,
                          child: Text(
                            subTitle!,
                            textScaleFactor: 1.0,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                ],
              )
            ],
          )),
    ).marginOnly(bottom: 30.0);
  }

  Widget getRow({String? des}) {
    return Row(
      children: [
        Container(
          height: 5.0,
          width: 5.0,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            des!,
            textScaleFactor: 1.0,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 0.4,
                fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(context, AccountController _) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Log Out?',
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
                  'Are you sure you want to log out?',
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
                      onPressed: () async {
                        Get.back();
                      },
                      minWidth: Get.width / 3.5,
                      height: 38,
                      child: const Text(
                        "CANCEL",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    MaterialButton(
                      // color: CommonColor.greenColorWithOpacity,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppColors.commonColor,
                          ),
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () {
                        _.storage.erase();
                        Get.offAllNamed(Routes.authenticationRoutes);
                        CommonToast.showToast(
                            title: "Logout Successfully", isWarning: false);
                      },
                      minWidth: Get.width / 3.5,
                      height: 38,
                      child: const Text(
                        "LOGOUT",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
