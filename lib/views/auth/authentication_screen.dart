import 'package:flutter/services.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';
import '../../controllers/auth/authentication_controller.dart';
import '../../services/password_validation_services.dart';
import '../../utils/app_libraries.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_loader.dart';
import '../../widgets/common_scaffold.dart';
import '../../widgets/common_toast.dart';
import '../../widgets/common_textfield.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      bodyData: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (_) {
          return _.isLoading
              ? const Center(
                  child: AppLoaders.appLoader,
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _.formkey,
                    child: GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      onVerticalDragCancel: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(AppImage.smallLogo)
                              .marginSymmetric(vertical: Get.height / 13.0),

                          // < ------------------ Tab Bar of SignUp and Login ----------------------- >

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  _.isSignup = true;
                                  _.isLogin = false;
                                  _.update();
                                },
                                child: Text(
                                  AppTexts.signup,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: _.isSignup == true &&
                                              _.isLogin == false
                                          ? AppColors.commonColor
                                          : const Color(0xff1E1989)
                                              .withOpacity(0.3)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _.isSignup = false;
                                  _.isLogin = true;
                                  _.update();
                                },
                                child: Text(
                                  AppTexts.login,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: _.isSignup == false &&
                                              _.isLogin == true
                                          ? AppColors.commonColor
                                          : const Color(0xff1E1989)
                                              .withOpacity(0.3)),
                                ),
                              ),
                            ],
                          ),
                          _.isSignup == true && _.isLogin == false
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: CommonTextField(
                                            controller: _.firstName,
                                            hintText: AppTexts.firstName,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter First Name";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
                                          child: CommonTextField(
                                            controller: _.lastName,
                                            hintText: AppTexts.lastName,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Last Name";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    CommonTextField(
                                      controller: _.emailAdress,
                                      hintText: AppTexts.emailAddress,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r"\s\b|\b\s"))
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter email";
                                        }
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        var regex = RegExp(pattern as String);
                                        return (!regex.hasMatch(value))
                                            ? 'Please enter valid email'
                                            : null;
                                      },
                                    ).marginSymmetric(vertical: 10),
                                    CommonTextField(
                                        controller: _.password,
                                        hintText: AppTexts.password,
                                        isTextHidden: _.isPasswordShown,
                                        togglePassword: true,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s"))
                                        ],
                                        toggleIcon: _.isPasswordShown == true
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined,
                                        toggleFunction: () {
                                          _.isPasswordShown =
                                              !_.isPasswordShown;
                                          _.update();
                                        },
                                        validator: (value) {
                                          return PasswordValidationWidget
                                              .validatePasswordOnPressed(
                                                  value!);
                                        }),
                                    CommonTextField(
                                        controller: _.confirmPassword,
                                        isTextHidden: _.isConfirmPasswordShown,
                                        togglePassword: true,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s"))
                                        ],
                                        toggleIcon:
                                            _.isConfirmPasswordShown == true
                                                ? Icons.visibility_off_outlined
                                                : Icons.remove_red_eye_outlined,
                                        toggleFunction: () {
                                          _.isConfirmPasswordShown =
                                              !_.isConfirmPasswordShown;
                                          _.update();
                                        },
                                        hintText: AppTexts.confirmPassword,
                                        validator: (value) {
                                          return PasswordValidationWidget
                                              .validatePasswordOnPressed(
                                                  value!);
                                        }).marginSymmetric(vertical: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          activeColor: AppColors.commonColor,
                                          shape: const CircleBorder(),
                                          value: _.isTermsAndConditions,
                                          onChanged: (bool? value) {
                                            _.isTermsAndConditions = value!;
                                            _.update();
                                          },
                                        ),
                                        const Text(
                                          "I Agree to the ",
                                          style: TextStyle(
                                              color: AppColors.commonColor2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            termsCOnditionsDialog(context);
                                          },
                                          child: const Text(
                                            "Terms and Conditions",
                                            style: TextStyle(
                                                color: AppColors.commonColor2,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircularButtons(
                                      onPressed: () async {
                                        if (_.password.text !=
                                            _.confirmPassword.text) {
                                          CommonToast.showToast(
                                              title:
                                                  "Password and Confirm password does not match",
                                              isWarning: true);
                                        } else if (_.isTermsAndConditions ==
                                            false) {
                                          CommonToast.showToast(
                                              title:
                                                  "Please accept Terms and Conditions",
                                              isWarning: true);
                                        } else if (_.validateAndSaveUser()) {
                                          await _.registerUserFunction();
                                          _.emailAdress.clear();
                                          _.firstName.clear();
                                          _.lastName.clear();
                                          _.password.clear();
                                          _.confirmPassword.clear();
                                          _.isTermsAndConditions = false;
                                          _.update();
                                        } else {
                                          CommonToast.showToast(
                                              title: AppTexts.requiredField,
                                              isWarning: true);
                                        }
                                      },
                                      text: AppTexts.signup,
                                    ).marginOnly(
                                        top: Get.height / 35.0,
                                        bottom: Get.height / 35.0),
                                    // const Text(
                                    //   AppTexts.continuewith,
                                    //   style: TextStyle(
                                    //       color: AppColors.greyColor,
                                    //       fontSize: 15,
                                    //       fontFamily: "Oswald",
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    // SizedBox(
                                    //   height: Get.height / 30.0,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     AppIcons.facebook,
                                    //     const SizedBox(width: 40),
                                    //     Image.asset(AppImage.google)
                                    //   ],
                                    // )
                                  ],
                                ).marginOnly(top: 30)
                              : Column(
                                  children: [
                                    CommonTextField(
                                      controller: _.loginEmail,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r"\s\b|\b\s"))
                                      ],
                                      hintText: AppTexts.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter email";
                                        }
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        var regex = RegExp(pattern as String);
                                        return (!regex.hasMatch(value))
                                            ? 'Please enter valid email'
                                            : null;
                                      },
                                    ).marginSymmetric(vertical: 20),
                                    CommonTextField(
                                        controller: _.loginPassword,
                                        isTextHidden: _.isLoginPasswordShown,
                                        togglePassword: true,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\b|\b\s"))
                                        ],
                                        toggleIcon:
                                            _.isLoginPasswordShown == true
                                                ? Icons.visibility_off_outlined
                                                : Icons.remove_red_eye_outlined,
                                        toggleFunction: () {
                                          _.isLoginPasswordShown =
                                              !_.isLoginPasswordShown;
                                          _.update();
                                        },
                                        hintText: AppTexts.password,
                                        validator: (value) {
                                          return PasswordValidationWidget
                                              .validatePasswordOnPressed(
                                                  value!);
                                        }),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Checkbox(
                                          activeColor: AppColors.commonColor,
                                          shape: const CircleBorder(),
                                          value: _.isRememberPassword,
                                          onChanged: (bool? value) {
                                            _.isRememberPassword = value!;
                                            _.update();
                                          },
                                        ),
                                        const Text(
                                          AppTexts.remberPassword,
                                          style: TextStyle(
                                              color: AppColors.commonColor2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(
                                    //   height: 40,
                                    // ),
                                    // InkWell(
                                    //     onTap: () {
                                    //       Get.to(const ForgotPassword());
                                    //     },
                                    //     child: const Text(
                                    //       "Forget Password?",
                                    //       style: TextStyle(
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.w600,
                                    //           color: AppColors.commonColor),
                                    //     ).marginSymmetric(vertical: 10)),
                                    CircularButtons(
                                      onPressed: () async {
                                        if (_.validateAndSaveUser()) {
                                          await _.loginFunction();
                                          _.loginEmail.clear();
                                          _.loginPassword.clear();
                                          _.isRememberPassword = false;
                                          _.update();
                                        } else {
                                          CommonToast.showToast(
                                              title: AppTexts.requiredField,
                                              isWarning: true);
                                        }
                                      },
                                      text: AppTexts.login,
                                    ).marginOnly(
                                        top: Get.height / 20.0,
                                        bottom: Get.height / 20.0),
                                    // const Text(
                                    //   AppTexts.continuewith,
                                    //   style: TextStyle(
                                    //       color: AppColors.greyColor,
                                    //       fontSize: 15,
                                    //       fontFamily: "Oswald",
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                    // SizedBox(
                                    //   height: Get.height / 30.0,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     AppIcons.facebook,
                                    //     const SizedBox(width: 40),
                                    //     Image.asset(AppImage.google)
                                    //   ],
                                    // )
                                  ],
                                ).marginOnly(top: 30)
                        ],
                      ).marginSymmetric(horizontal: Get.width / 7.0),
                    ),
                  ),
                );
        });
  }

  Future<void> termsCOnditionsDialog(
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "TÉRMINOS Y CONDICIONES",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                BulletedList(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: [
                    "Descargo de responsabilidad\nProporcionamos información de inversión solo para uso educativo. Al utilizar nuestros servicios, usted acepta usar esta información solo para uso educativo. Cada persona es responsable de sus propias decisiones financieras.\nLa información proporcionada en los seminarios virtuales de y el material que la acompaña es solo para fines informativos y educativos.\n Investement Mindset no ofrece ninguna garantía u otra promesa en cuanto los resultados que se puedan obtener del uso de nuestro contenido. Investement Mindset renuncia a toda responsabilidad en el caso de que cualquier información, comentario, análisis, opiniones, consejos y/o recomendaciones resulten inexactos, incompletos o poco confiables, o que resulten en pérdidas.\nEl contenido disponible a través del sitio web no pretende ser un consejo de inversión, es educación. El uso de la información en el sitio web o los materiales vinculados desde la web es bajo su propio riesgo.\nNosotros (Investement Mindset), no ofrecemos total y absolutamente ninguna garantía de que ganará dinero o logrará una meta financiera utilizando estos métodos a corto, mediano ni a largo plazo, con la información y las sugerencias en el contenido proporcionado. Cualquier ejemplo o demostración proporcionada, no es de ninguna manera una garantía o promesa de que un individuo genere ganancias financieras de cualquier clase. El potencial de ganancias es totalmente independiente a la empresa, y totalmente dependiente de la persona que utiliza nuestra página web, servicios, métodos e ideas. Esta página web no proporciona ni recomienda un “Programa de hacerse rico rápidamente” o un “Esquema de ganancias de dinero ilimitado” o cualquier equivalente.\nTodas las declaraciones de futuro utilizadas en nuestra página web, o en cualquiera de nuestros servicios, son solamente para expresar nuestra opinión del potencial de ingreso alcanzable. Un sinnúmero de factores podría afectar sus ganancias financieras y los resultados reales. Investement Mindset no ofrece ninguna garantía de que usted obtenga resultados como los nuestros o cualquier otro. De hecho, no se ofrecen garantías de que usted obtenga ningún resultado de nuestra aplicación Investment Mindset, métodos, sugerencias o con cualquier otro contenido. Cualquier resultado o desempeño financiero que pueda ver en nuestra página web, o en cualquiera de nuestros contenidos y/o miembros afiliados a nuestra empresa, no es típico y sus resultados varían de persona a persona.\nTodo miembro, posible miembro, miembro de prueba gratuita, cliente interesado o suscriptor de cualquier tipo, debe leer esta advertencia legal, comprender y aceptar los términos legales estipulados.\nDerechos de autor, propiedad intelectual y marca"
                  ],
                  listOrder: ListOrder.ordered,
                ),
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: [
                    "El Aprendiz no tendrá ningún derecho de propiedad sobre el trabajo creativo realizado por Investement Mindset y sus afiliadas \n El Aprendiz no tendrá ningún derecho de atribución para ningún trabajo creado con/por Investement Mindset , ni con sus afiliadas;\nEl Aprendiz reconoce como datos propietarios toda copia, duplicado y reproducción de los datos de propiedad de Investement Mindset, ya sea que dichas copias, duplicados o reproducciones sean producidas por cualquiera de las Partes y si son producidas de manera mecánica, electrónica o manual. También, los datos propietarios incluirán cualquier documento, memorando, nota u otra información creada por el Aprendiz que incorpore, en todo o en parte, los datos de propiedad a los que Investement Mindset le brinda acceso. Todas las copias, duplicados y reproducciones de datos propietarios y dichos memorandos, notas u otra información que contengan datos de propiedad, se marcarán con la misma leyenda restrictiva que figura en los datos propietarios originales;\nEl Aprendiz no deberá crear, poseer, copiar, resguardar ni distribuir copias de seguridad, en forma personal o privada, de los datos propietarios a que Investement Mindset le brinda acceso. Almacenamiento de cualquier software, trabajo, material, diseño, planos, códigos, imágenes, medios, vídeos o cualquier otro tipo de información física o digital que pertenezca a la empresa Investement Mindset y/o a sus afiliadas, pudiera resultar ser procesable ante las autoridades y/o agencias del orden público y, en su consecuencia, en la imposición de una multa de hasta \u0024500,000.00 (quinientos mil dólares) y/o pena de cárcel de diez años de prisión; y\nCualquier otra marca que no sea propiedad de Investement Mindset o sus afiliadas, que aparezcan en cualquier parte o contenido suministrado por, es propiedad de sus respectivos dueños, quienes pudieran estar afiliados o no a Investement Mindset"
                  ],
                  listOrder: ListOrder.ordered,
                ),
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: [
                    "Investement Mindset se reserva el derecho de adoptar y enmendar reglamentación, políticas de uso, términos de servicio, políticas de confidencialidad, reglamento o cualquier otra normativa en cualquier momento sin previa notificación.\nEstas entran en vigor una vez aprobadas por Investement Mindset Una vez adoptadas, estas aplicaran en toda su extension y vigor.\nInvestement Mindset utiliza varios medios para la divulgacion de sus politicas, reglamentos, avisos, advertencias; entre otras publicaciones. Es responsabilidad exclusiva del Aprendiz accederlas y familiarizarse con las mismas.",
                  ],
                  listOrder: ListOrder.ordered,
                ),
                BulletedList(
                  bulletColor: AppColors.commonColor,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  listItems: [
                    "Toda la información que se comparte en Investement Mindset de parte de los mentores y miembros del equipo es con fines y propósitos educativos. Es responsabilidad de cada suscriptor el hacer investigación profunda sobre cada tema, instrumento de inversión, crypto, stock, divisa u otro material que se comparta en la comunidad de Investement Mindset",
                    "2-Cada suscriptor asume la responsabilidad total de sus decisiones de seguir o adoptar cualquier sugerencia que se brinde en Investement Mindset por parte de los mentores o miembros del equipo. Investement Mindset, sus miembros y los mentores de Investement Mindset no se hacen responsables de ningún daño ni de la pérdida parcial o total de los fondos que invierta un suscriptor en cualquiera de los instrumentos de inversión que se comparten en Investement Mindset ya sea por escrito o a través de videos, webinars o cualquier otro medio.",
                    "3- Cada suscriptor debe aceptar que los mercados en los que se educa en Investement Mindset son mercados de alto riesgo y gran volatilidad. La única garantía es que las inversiones pierdan su valor total, no importan cuán buenas sean las proyecciones que compartan los mentores en cuanto a algún instrumento de inversión se refiera, el suscriptor debe aceptar la responsabilidad de invertir únicamente fondos que esté dispuesto a perder en su totalidad y asume las consecuencias de su decisión personal.",
                    "4-El propósito principal del material, consejos, sugerencias de instrumentos de inversión, que se comparten en Investement Mindset es educar y trabajar la mentalidad de inversionistas a largo plazo. Es la decisión personal de cada suscriptor el aplicar o seguir estos consejos y sugerencias y debe asumir la responsabilidad de su toma de decisión personal y las consecuencias de la misma.",
                    "5-Investement Mindset y sus miembros no actúan en calidad de “Financial Advisors”, los mentores comparten sus ideas y pensamientos personales y sus opiniones en cuanto a lo que cada uno cree que tiene potencial para sí mismo. Es decisión del suscriptor el seguir o adoptar la visión personal de cada mentor y es responsabilidad del suscriptor el hacer investigación profunda y cuestionamiento antes de adoptar el punto de vista de alguno de los mentores en cuanto a consejos, sugerencias de instrumentos de inversión, proyecciones, hábitos, entre otros. Investement Mindset y sus miembros o mentores no se responsabilizan por los daños que pueda provocar el que un suscriptor adopte el punto de vista o sugerencia brindada.",
                    "6-Al suscribirse a Investement Mindset el suscriptor está aceptando los términos y condiciones anteriormente establecidos. Estos términos y condiciones pueden ser modificados sin previo aviso. Es responsabilidad del suscriptor mantenerse al día con los términos y condiciones más recientes."
                  ],
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
