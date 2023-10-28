// import 'package:crypto/controllers/auth/password/forget_password_controller.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../../utils/app_libraries.dart';

// class ForgotPassword extends StatelessWidget {
//   const ForgotPassword({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ForgotPasswordController>(
//         init: ForgotPasswordController(),
//         builder: (_) {
//           return Scaffold(
//               appBar: AppBar(
//                 backgroundColor: AppColors.commonColor,
//                 centerTitle: false,
//                 title: const Text(
//                   "Forget Password",
//                   style: TextStyle(color: AppColors.whiteColor),
//                 ),
//                 elevation: 0.0,
//                 leading: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: const Icon(
//                         Icons.chevron_left,
//                         color: AppColors.whiteColor,
//                       )),
//                 ),
//               ),
//               body: SizedBox(
//                 height: Get.height,
//                 width: Get.width,
//                 child: GestureDetector(
//                   onTap: () {
//                     FocusScopeNode currentFocus = FocusScope.of(context);
//                     if (!currentFocus.hasPrimaryFocus) {
//                       currentFocus.unfocus();
//                     }
//                   },
//                   child: SingleChildScrollView(
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height / 1.2,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text("Forgot Your Password?",
//                                 textScaleFactor: 1.0,
//                                 style: TextStyle(
//                                     color: AppColors.commonColor,
//                                     fontSize: 25.0,
//                                     letterSpacing: 0.7,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'Roboto'),
//                                 textAlign: TextAlign.center),
//                             const SizedBox(
//                               height: 25.0,
//                             ),
//                             Center(
//                               child: SizedBox(
//                                 width: Get.width / 1.5,
//                                 height: 32,
//                                 child: const Text(
//                                   "Enter your registered email below to receive password reset instructions",
//                                   textScaleFactor: 1.0,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       letterSpacing: 0.4,
//                                       color: Colors.black,
//                                       fontSize: 12.0),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 43.0,
//                             ),
//                             Form(
//                               key: _.formkey,
//                               child: CommonTextField(
//                                 fillcolor: Colors.transparent,
//                                 controller: _.emailController,
//                                 hintText: 'Email Address',
//                                 textInputAction: TextInputAction.next,
//                                 // ignore: body_might_complete_normally_nullable
//                                 validator: (value) {
//                                   if (value!.isEmpty) return "Enter email";
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//                             SizedBox(
//                               width: 162,
//                               height: 48,
//                               //color: CommonColor.loginAndSendCodeButtonColor,
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   if (_.start == 0 || _.start == 60) {
//                                     _.forgotPassword();
//                                   }
//                                 },
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(10.0),
//                                   ),
//                                   side: BorderSide(
//                                     color: AppColors.commonColor,
//                                   ),
//                                 ),
//                                 // color: Color.fromRGBO(72, 190, 235, 1),
//                                 // color: CommonColor.,
//                                 minWidth: Get.width / 3,
//                                 height: 36,
//                                 child: const Text(
//                                   "SEND CODE",
//                                   textScaleFactor: 1.0,
//                                   style: TextStyle(
//                                       color: AppColors.commonColor,
//                                       fontSize: 16.0,
//                                       letterSpacing: 0.4,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//                             SizedBox(
//                               width: Get.width / 1.8,
//                               child: PinCodeTextField(
//                                 appContext: context,
//                                 pastedTextStyle: const TextStyle(
//                                     color: Colors.white, fontSize: 11),
//                                 length: 4,
//                                 // animationType: AnimationType.fade,
//                                 textStyle: const TextStyle(
//                                     letterSpacing: 0.4,
//                                     color: Colors.white,
//                                     fontSize: 11),
//                                 // ignore: body_might_complete_normally_nullable
//                                 validator: (v) {
//                                   // if (v!.length < 3) {
//                                   //   return "I'm from validator";
//                                   // } else {
//                                   //   return null;
//                                   // }
//                                 },
//                                 pinTheme: PinTheme(
//                                   // selectedFillColor: CommonColor.snackbarColour,
//                                   // selectedColor: CommonColor.snackbarColour,
//                                   borderWidth: 2,
//                                   disabledColor: AppColors.commonColor,
//                                   shape: PinCodeFieldShape.box,
//                                   borderRadius: BorderRadius.circular(5),
//                                   fieldHeight: 46,
//                                   fieldWidth: 46,
//                                   inactiveColor:
//                                       const Color(0xff1E975D).withOpacity(0.27),
//                                   inactiveFillColor:
//                                       const Color(0xff1E975D).withOpacity(0.27),
//                                   activeColor:
//                                       const Color(0xff1E975D).withOpacity(0.27),
//                                   activeFillColor:
//                                       const Color(0xff1E975D).withOpacity(0.27),
//                                 ),
//                                 // cursorColor: CommonColor.snackbarColour,
//                                 animationDuration:
//                                     const Duration(milliseconds: 300),
//                                 enableActiveFill: true,
//                                 // errorAnimationController: _.errorController,
//                                 controller: _.pin,
//                                 keyboardType: TextInputType.number,
//                                 // ignore: prefer_const_literals_to_create_immutables
//                                 boxShadows: [
//                                   // ignore: prefer_const_constructors
//                                   BoxShadow(
//                                     offset: const Offset(0, 1),
//                                     color: Colors.black12,
//                                     blurRadius: 10,
//                                   )
//                                 ],
//                                 onCompleted: (v) {
//                                   if (kDebugMode) {
//                                     print('Complete value $v');
//                                   }
//                                   if (_.start == 60 || _.start == 0) {
//                                     CustomSnackBar.showSnackBar(
//                                         title:
//                                             'OTP code has expired please retry',
//                                         message: "",
//                                         backgroundColor: AppColors.commonColor,
//                                         isWarning: true);
//                                   } else {
//                                     if (v.toString() == _.lastcode.toString()) {
//                                       if (kDebugMode) {
//                                         print('Code Done');
//                                       }
//                                       _.start = 0;
//                                       _.update();

//                                       // Get.to(() => CreateNewPasswordScreen(),
//                                       //     arguments: _.emailController.text);
//                                     } else {
//                                       CustomSnackBar.showSnackBar(
//                                           title: "AppStrings.otpNotMatch",
//                                           message: "",
//                                           backgroundColor:
//                                               AppColors.commonColor,
//                                           isWarning: true);
//                                     }
//                                   }
//                                 },
//                                 onChanged: (value) {},
//                                 beforeTextPaste: (text) {
//                                   return true;
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10.0,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'ENTER CODE',
//                                 textScaleFactor: 1.0,
//                                 style: TextStyle(
//                                   fontSize: 12.0,
//                                   letterSpacing: 0.4,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10.0,
//                             ),
//                             Center(
//                               child: Text(
//                                 '00 : ${_.start}',
//                                 textScaleFactor: 1.0,
//                                 style: const TextStyle(
//                                   fontSize: 18.0,
//                                   letterSpacing: 0.4,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.commonColor,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ).marginOnly(left: 55.0, right: 30.0),
//                   ),
//                 ),
//               ));
//         });
//   }
// }
