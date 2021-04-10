import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/register/otp_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OtpVerification extends StatelessWidget {
  OtpController otpCtrl = Get.put(OtpController());
  SignInController phoneCtrl = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Form(
          key: otpCtrl.formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 80, right: 30),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Text(
                  S.of(context).otp,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.cyan,
                        fontSize: 55,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                PinCodeTextField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).otpError;
                    } else if (value.length < 6) {
                      return S.of(context).otpValid;
                    } else
                      return null;
                  },
                  controller: otpCtrl.otpController,
                  autoFocus: true,
                  showCursor: true,
                  backgroundColor: Colors.transparent,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Color(0xFF0CBCC5),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    borderWidth: 2,
                    disabledColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    inactiveColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: Colors.cyan,
                    activeFillColor: Colors.cyan,
                    selectedColor: Colors.cyan,
                    selectedFillColor: otpCtrl.otpFocus.hasFocus ?? false
                        ? Colors.black
                        : Colors.white,
                  ),
                  cursorColor: Colors.black,
                  boxShadows: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(5, 5),
                    )
                  ],
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  focusNode: otpCtrl.otpFocus,
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onTap: () {
                    print("Pressed");
                  },
                  onChanged: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 200,
                ),
                SizedBox(
                    child:
                        /* otpCtrl.isLoading.value
                          ? Center(
                              child: buildLoader(),
                            )
                          :*/
                        RoundedLoadingButton(
                  color: Colors.cyan,
                  controller: otpCtrl.butCtrl,
                  onPressed: () {
                    if (otpCtrl.formKey.currentState.validate()) {
                      otpCtrl.verifyPhoneManually();
                      /* Get.to(UserType(),
                                    curve: Curves.elasticInOut,
                                    duration: Duration(seconds: 1));
                           */
                    }
                  },
                  child: Text(S.of(context).Continue),
                  borderRadius: 12,
                  height: 40,
                  width: 120,
                  // controller: con.btnController,
                  // onPressed: () async {
                  //   await con.sendFeedback();
                  // },
                )
                    // controller: con.btnController,
                    // onPressed: () async {
                    //   await con.sendFeedback();
                    // },
                    ) /*button(
                            buttonText: "Continue",
                            bTextStyle: kStyle.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (otpCtrl.formKey.currentState.validate()) {
                                otpCtrl.verifyPhoneManually();
                                */ /* Get.to(UserType(),
                                    curve: Curves.elasticInOut,
                                    duration: Duration(seconds: 1));
                              */ /*
                              }
                            },
                            buttonColor: MaterialStateProperty.all(Colors.teal),
                            context: context,
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20)),
                          )*/
                ,
                SizedBox(
                  height: 40,
                ),
/*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Terms of Service",
                      */
/*style: kStyle.copyWith(
                          color: Colors.white24,
                          fontSize: 14,
                        ),*/ /*

                    ),
                    Text(
                      "Privacy Policy",
                      */
/*style: kStyle.copyWith(
                          color: Colors.white24,
                          fontSize: 14,
                        ),*/ /*

                    ),
                  ],
                )
*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
