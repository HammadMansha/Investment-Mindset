
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/auth/password/change_password_controller.dart';
import '../../../services/password_validation_services.dart';
import '../../../utils/app_libraries.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_loader.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/common_toast.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      // bottomNavigationBar: GlobalBottomNav(),
      body: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (_) {
          return _.isLoading
              ? const Center(
                  child: AppLoaders.appLoader,
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.commonColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                      const Text(
                        "Your new password must be different from\nprevious used password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ).marginOnly(top: 10, bottom: 30),

                      //-------------- textfields ---------------------
                      Form(
                        key: _.formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\b|\b\s"))
                              ],
                              controller: _.oldpassword,
                              hintText: "Old Password",
                              prefixIcon: Icons.lock_outline,
                              isTextHidden: _.securetext,
                              togglePassword: true,
                              toggleIcon: _.securetext == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              toggleFunction: () {
                                _.securetext = !_.securetext;
                                _.update();
                              },
                              validator: (value) {
                                return PasswordValidationWidget
                                    .validatePasswordOnPressed(value!);
                              },
                            ).marginOnly(top: 8, bottom: 15),
                            CommonTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\b|\b\s"))
                              ],
                              controller: _.password,
                              hintText: "New Password",
                              prefixIcon: Icons.lock_outline,
                              isTextHidden: _.securetext1,
                              togglePassword: true,
                              toggleIcon: _.securetext1 == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              toggleFunction: () {
                                _.securetext1 = !_.securetext1;
                                _.update();
                              },
                              validator: (value) {
                                return PasswordValidationWidget
                                    .validatePasswordOnPressed(value!);
                              },
                            ).marginOnly(top: 8, bottom: 8),
                            CommonTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\b|\b\s"))
                              ],
                              controller: _.confirmpassword,
                              hintText: "Confirm New Password",
                              prefixIcon: Icons.lock_outline,
                              isTextHidden: _.securetext2,
                              togglePassword: true,
                              toggleIcon: _.securetext2 == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              toggleFunction: () {
                                _.securetext2 = !_.securetext2;
                                _.update();
                              },
                              validator: (value) {
                                return PasswordValidationWidget
                                    .validatePasswordOnPressed(value!);
                              },
                            ).marginOnly(bottom: 10, top: 16),
                          ],
                        ).marginSymmetric(horizontal: 24),
                      ),

                      CircularButtons(
                        onPressed: () {
                          if (_.password.text != _.confirmpassword.text) {
                            CommonToast.showToast(
                                title:
                                    "New and Confirm Password does not match",
                                isWarning: true);
                          } else if (_.oldpassword.text == _.password.text) {
                            CommonToast.showToast(
                                title:
                                    "New Password should be different from old password",
                                isWarning: true);
                          } else if (_.validateAndSaveUser()) {
                            _showMyDialog(context, _);
                          } else {
                            CommonToast.showToast(
                                title: "Please fill all fields",
                                isWarning: true);
                          }
                        },
                        text: "Continue",
                      ).marginOnly(
                          top: Get.height / 20.0, bottom: Get.height / 20.0),
                    ],
                  ),
                );
        });
  }

  Future<void> _showMyDialog(context, ChangePasswordController _) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Change Password?',
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
                  'Are you sure you want to change password?',
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
                        await _.changePasswordFun();
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
