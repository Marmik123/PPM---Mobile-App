import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/register/otp_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/auth/otp_verification.dart';
import 'package:pcm/view/register/client.dart';
import 'package:pcm/view/register/document_veri_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  SignInController ctrl = Get.put(SignInController());
  LoginController loginCtrl = Get.put(LoginController());
  OrderAssignController assignCtrl = Get.put(OrderAssignController());
  ClientController client = Get.put(ClientController());
  String langCode;
  String selectedLang = S.of(Get.context).English;
  AnimationController controller;
  AnimationController aniCtrl;
  Animation animation;
  Animation rowAnimation;
  RepoController repoController = Get.put(RepoController());
  OtpController otpCtx = Get.put(OtpController());
  // String langCode = savedLocale.languageCode;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    super.initState();
    loginCtrl.oldDataReceived.value = false;
    controller = AnimationController(
      upperBound: 1.0,
      lowerBound: 0.9,
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    rowAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: controller,
    );
    controller.forward();

    controller.addListener(() {
      print(animation.value);
      setState(() {
        controller.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 15),
                child: Transform.translate(
                  offset: Offset(0, animation.value * 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 240.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(10, 35)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(10),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ))),
                      onPressed: () {
                        Get.defaultDialog(
                            title: S.of(context).change,
                            titleStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text(S.of(context).change),
                                ListTile(
                                  onTap: () async {
                                    /* SharedPreferences language =
                      await SharedPreferences.getInstance();
                repoCtrl.setLanguage('en');
                Navigator.of(context)
                      .pop(language.getString(repoCtrl.kLangCode));*/
                                    Navigator.of(context).pop('en');
                                  },
                                  title: Text(
                                    S.of(context).English,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    /* SharedPreferences language =
                      await SharedPreferences.getInstance();
                repoCtrl.setLanguage('gu');
                Navigator.of(context)
                      .pop(language.getString(repoCtrl.kLangCode));*/
                                    Navigator.of(context).pop('gu');
                                  },
                                  title: Text(
                                    S.of(context).Gujarati,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    /* SharedPreferences language =
                      await SharedPreferences.getInstance();
                repoCtrl.setLanguage('hi');
                Navigator.of(context)
                      .pop(language.getString(repoCtrl.kLangCode));*/
                                    Navigator.of(context).pop('hi');
                                  },
                                  title: Text(
                                    S.of(context).Hindi,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                )
                              ],
                            )).then((value) async {
                          if (value != null) {
                            print('this is the value $value');
                            setState(() {
                              langCode = value;
                            });
                            print(langCode);
                            await repoController.setLanguage(Locale(langCode));
                            setState(() {});
                            switch (langCode) {
                              case 'en':
                                {
                                  setState(() {
                                    selectedLang = S.of(context).English;
                                  });
                                }
                                break;

                              case 'gu':
                                {
                                  setState(() {
                                    selectedLang = S.of(context).Gujarati;
                                  });
                                }
                                break;

                              case 'hi':
                                {
                                  setState(() {
                                    selectedLang = S.of(context).Hindi;
                                  });
                                }
                                break;
                            }
                          }
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            selectedLang,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.language_outlined,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              /* Padding(
                padding:
                    const EdgeInsets.only(top: 100, left: 40.0, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Transform.scale(
                      scale: animation.value * 1.2,
                      child: Text(
                        S.of(context).signIn,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ), */
                    /* Transform.scale(
                      scale: animation.value * 1,
                      child: Text(
                        S.of(context).home,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.green,
                              fontSize: animation.value * 40,
                              fontWeight: FontWeight.w500),
                        ),
                        /* style: kStyle.copyWith(
                                fontSize: 25,
                                color: Colors.teal,
                                fontWeight: FontWeight.w400),*/
                        maxLines: 1,
                      ),
                    ), */
                    
                  ],
                ),
              ), */
              SizedBox(
                height: 50,
              ),
              Transform.scale(
                scale: animation.value,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 20),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
                    child: Form(
                      key: ctrl.loginFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Transform.scale(
                            scale: animation.value,
                            child: Hero(
                              tag: 'ppm_logo',
                              child: Image.asset(
                                'images/LOGO-02.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: ctrl.mobileNo,
                                  validator: (value) {
                                    if (!GetUtils.isPhoneNumber(value)) {
                                      return S.of(context).valid;
                                    }
                                    if (value.length != 10) {
                                      return S.of(context).valid;
                                    } else {
                                      return null;
                                    }
/*                                  showCountryPicker(
                                      context: context,
                                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                      exclude: <String>['KN', 'MF'],
                                      //Optional. Shows phone code before the country name.
                                      showPhoneCode: true,
                                      onSelect: (Country country) {
                                        ctrl.phoneCode = country.phoneCode;
                                        //ctrl.phoneCode.value = country.phoneCode;
                                        print(
                                            'Select country: ${country.displayName}');
                                      },
                                    );*/
                                  },
                                  decoration: InputDecoration(
                                    /*prefixIcon: IconButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                      },
                                    ),*/
                                    prefixText: '+91  ',
                                    /*prefixStyle: kStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),*/
                                    hintText: S.of(context).hint,
                                    /*hintStyle: kStyle.copyWith(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),*/
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
/*                            Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: TextFormField(
                                  */ /*style: kStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),*/ /*
                                  controller: ctrl.password,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter a password";
                                    } else
                                      return null;
                                  },
                                  obscureText: ctrl.hidePassword.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintText: " Enter Your password",
                                    */ /*hintStyle: kStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.4),
                                      fontWeight: FontWeight.w600,
                                    ),*/ /*
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        ctrl.hidePassword.value =
                                            !ctrl.hidePassword.value;
                                      },
                                      child: ctrl.hidePassword.value
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: Colors.teal,
                                            )
                                          : Icon(
                                              Icons.remove_red_eye_sharp,
                                              color: Colors.teal,
                                            ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),

                                    */ /* enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),*/ /*
                                  ),
                                ),
                              ),*/
                          SizedBox(
                            height: 80,
                          ),
                          RoundedLoadingButton(
                            controller: ctrl.buttonCtrl,
                            elevation: 10,
                            color: Colors.green,
                            onPressed: () async {
                              if (ctrl.loginFormKey.currentState.validate()) {
                                print('get user data about to call');
                                await loginCtrl.getUserData();
                              }
                              print('out of if loop');
                              print(loginCtrl.oldDataReceived.value);
                              if (loginCtrl.oldDataReceived()) {
                                await checkVerificationStatus();
                              }
                              ctrl.buttonCtrl.reset();
                            },
                            child: Text(
                              S.of(context).Continue,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            borderRadius: 12,
                            height: 40,
                            width: 120,
                            // controller: con.btnController,
                            // onPressed: () async {
                            //   await con.sendFeedback();
                            // },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    S.of(context).newUser,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                TextButton(
                                  onLongPress: () {
                                    Get.snackbar(
                                      '',
                                      '',
                                      messageText: Text(
                                        S.of(Get.context).signUp,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      titleText: Text(
                                        S.of(Get.context).fillS,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      icon: Icon(Icons.app_registration),
                                      backgroundColor: Colors.green,
                                      backgroundGradient: LinearGradient(
                                          colors: [Colors.white, Colors.green]),
                                      snackStyle: SnackStyle.FLOATING,
                                    );
                                  },
                                  onPressed: () {
                                    Get.to(() => ClientRegister());
                                  },
                                  child: Text(
                                    S.of(context).signup,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.green,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

/*                            button(
                                context: context,
                                bTextStyle: kStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                                buttonText: "Sign In",
                                onPressed: () {
                                  if (ctrl.formKey.currentState.validate()) {
                                    ctrl.isLoading.value = true;
                                    otpCtx.registerUser();
                                    Get.back();
                                    Get.to(OtpVerification(),
                                        curve: Curves.elasticInOut,
                                        duration: Duration(seconds: 1));
                                  }
                                },
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        left: 90,
                                        right: 90,
                                        top: 20,
                                        bottom: 20)),
                                buttonColor: MaterialStateProperty.all(Colors.teal),
                              )*/

                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
/*                  Padding(
                    padding: const EdgeInsets.only(top: 85.0, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          */ /* style: kStyle.copyWith(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w200),*/ /*
                          maxLines: 1,
                        ),
*/ /*                        GestureDetector(
                          onTap: () {
                            Get.to(SignUp(),
                                curve: Curves.elasticInOut,
                                duration: Duration(seconds: 1));
                          },
                          child: Text(
                            "  Sign Up",
                            style: kStyle.copyWith(
                                fontSize: 15,
                                color: Colors.teal,
                                fontWeight: FontWeight.w200),
                            maxLines: 1,
                          ),
                        )*/ /*
                      ],
                    ),
                  )*/
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkVerificationStatus() async {
    if (loginCtrl.oldData[0][0]['isVerified'] == 'Yes' ||
        loginCtrl.oldData[0][0]['role'] != 'Client') {
      print('is verified if loop');
      await otpCtx.registerUser();
      Get.to(() => OtpVerification());
    } else {
      ctrl.buttonCtrl.reset();
      Get.to(() => SignInDocVeri());
    }
  }
}
