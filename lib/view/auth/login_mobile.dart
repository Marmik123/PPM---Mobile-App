import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/register/otp_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences_utils.dart';
import 'package:pcm/view/auth/otp_verification.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInController ctrl = Get.put(SignInController());

  OtpController otpCtx = Get.put(OtpController());
  String langCode = savedLocale.languageCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 100, left: 40.0, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).signIn,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      S.of(context).home,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.cyan,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                      /* style: kStyle.copyWith(
                              fontSize: 25,
                              color: Colors.teal,
                              fontWeight: FontWeight.w400),*/
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 20),
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
                  child: Form(
                    key: ctrl.formKey,
                    child: Column(
                      children: [
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
                                  } else if (value.length != 10) {
                                    return S.of(context).valid;
                                  } else
                                    return null;
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
                                  prefixText: "+91  ",
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
                                      color: Colors.cyan,
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
                          color: Colors.cyan,
                          onPressed: () async {
                            await otpCtx.registerUser();
                            Get.to(() => OtpVerification());
/*
                            if (otpCtx.formKey.currentState.validate()) {

                              */
/* Get.to(UserType(),
                                    curve: Curves.elasticInOut,
                                    duration: Duration(seconds: 1));
                           */ /*

                            }
*/
                          },
                          child: Text(
                            S.of(context).Continue,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          borderRadius: 12,
                          height: 40,
                          width: 120,
                          // controller: con.btnController,
                          // onPressed: () async {
                          //   await con.sendFeedback();
                          // },
                        )

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
                        ,
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
}
