import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';
import '../../controllers/edit profile/edit_profile_controller.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (_) {
        return CommonScaffold(
          showAppBar: false,
          appbarTitle: AppTexts.editProfile,
          extendBodyBehindAppBar: false,
          appbarcolor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.chevron_left,
              size: 20,
              color: Colors.white,
            ),
          ),
          appbarelevation: 0.0,
          bodyData: bodyData(context, _),
        );
      },
    );
  }

  // ------------------ Main Widget of the class ------------------

  Widget bodyData(BuildContext context, EditProfileController _) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
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
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.commonColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),
                ),
                const Text(
                  "Your can edit your profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ).marginOnly(top: 10, bottom: 30),
                CommonTextField(
                  controller: _.firstName,
                  hintText: "First Name",
                  prefixIcon: Icons.person_rounded,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                    controller: _.lastName,
                    hintText: "Last Name",
                    prefixIcon: Icons.person_rounded),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                  controller: _.email,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                  controller: _.username,
                  hintText: "Username",
                  prefixIcon: Icons.accessibility,
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ).marginOnly(left: 40, right: 40),
            CircularButtons(
              onPressed: () {
                _showMyDialog(context, _);
              },
              text: AppTexts.updateProfile,
            ).marginOnly(top: Get.height / 20.0, bottom: Get.height / 35.0),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(context, EditProfileController _) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Update Profile?',
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
                  'Are you sure you want to update profile?',
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
                        "No",
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
                      onPressed: () async {
                        await _.updateUser();
                      },
                      minWidth: Get.width / 3.5,
                      height: 38,
                      child: const Text(
                        "Yes",
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
