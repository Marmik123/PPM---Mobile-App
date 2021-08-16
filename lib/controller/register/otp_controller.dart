import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm/api.dart';
import 'package:pcm/controller/homescreen_client_controller.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OtpController extends GetxController {
  String verificationId;
  FocusNode otpFocus = FocusNode();
  OrderAssignController assignCtrl = Get.put(OrderAssignController());
  HomeScreenClientController clientCtrl = Get.put(HomeScreenClientController());
  RoundedLoadingButtonController butCtrl = RoundedLoadingButtonController();

  String otpValue = '';
  RxString mobile = ''.obs;
  RxBool isLoading = false.obs;
  String token;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  SignInController phoneCtrl = Get.put(SignInController());
  LoginController loginCtrl = Get.put(LoginController());

  String sentOtp = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    //registerUser();
    isLoading.value = true;
    //token = await phoneCtrl.checkUserAvailability();
  }

  // Firebase function for registeration and user login
  Future registerUser() async {
    print('Register user called');
    try {
      /*await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneCtrl.mobileNo.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          isLoading.value = false;
          print('Verification Successful');
          phoneCtrl.buttonCtrl.success();
          var result = await _auth.signInWithCredential(credential);
          var user = result.user;
          print('this is user');
          print(user);
          if (user != null) {
            print('User is  registered');
            //TODO: START
            mobile.value = phoneCtrl.mobileNo.text.trim().toString();
            loginCtrl
                .userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());
            await assignCtrl
                .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
            clientCtrl.showLoggedInUserData(
                phoneCtrl.mobileNo.text.trim().toString());
            //TODO: END
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed Auth Exception');
          butCtrl.reset();
          phoneCtrl.buttonCtrl.reset();
          Get.snackbar(
            S.of(Get.context).errorOc,
            e.message,
            backgroundColor: Colors.white,
            duration: Duration(seconds: 4),
            colorText: Colors.teal,
          );
          phoneCtrl.isLoading.value = false;

          print(e.message);
        },
        codeSent: (String verificationId, int code) async {
          isLoading.value = false;
          print('code sent $verificationId $code');
          this.verificationId = verificationId;
          print('Code is sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
          butCtrl.reset();
          phoneCtrl.buttonCtrl.reset();
          print('Timeout');
          print(verificationId);
        },
      );*/
      await sendOtp(phoneCtrl.mobileNo.text.trim());
    } catch (e) {
      phoneCtrl.buttonCtrl.reset();
      butCtrl.reset();
      Get.snackbar(
        S.of(Get.context).errorOc,
        '',
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
    }
  }

  Future<void> sendOtp(String mobileNumber) async {
    sentOtp = randomNumber.toString();
    print(sentOtp);
    var apiKey = 'NTY2YTY0NDgzNjcwNzM2MzM4MzQ1NDQxNmYzNjQ4MzI=';
    var message = '$sentOtp is your PPM Store verification code.';
    mobile.value = phoneCtrl.mobileNo.text.trim().toString();
    loginCtrl.userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());
    await assignCtrl
        .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
    clientCtrl.showLoggedInUserData(phoneCtrl.mobileNo.text.trim().toString());
    if (kReleaseMode) {
      await getUrl(
          'https://api.textlocal.in/send/?apiKey=$apiKey&sender=PPMStr&numbers=91$mobileNumber&message=$message');
    }
    isLoading.value = false;
  }

  Future<void> verifyOtp() async {
    phoneCtrl.isLoading.value = false;
    if (sentOtp == otpController.text) {
      isLoading.value = false;
      phoneCtrl.buttonCtrl.success();
      butCtrl.success();

      mobile.value = phoneCtrl.mobileNo.text.trim().toString();

      await loginCtrl
          .userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());

      await clientCtrl
          .showLoggedInUserData(phoneCtrl.mobileNo.text.trim().toString());

      await assignCtrl
          .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
    } else {
      phoneCtrl.buttonCtrl.reset();

      butCtrl.reset();

      Get.snackbar(
        S.of(Get.context).errorOc,
        '',
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );

      phoneCtrl.isLoading.value = false;
    }
  }

//Function to verify manually and verify added otp if not automatically verified
  verifyPhoneManually() {
    phoneCtrl.isLoading.value = false;
    print('verify phone manually');

    print('try');
    var credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );
    print('line 1');
    try {
      _auth.signInWithCredential(credential).then((value) {
        print('Result is $value');

        if (value != null) {
          butCtrl.success();
          print('User already registered');
          mobile.value = phoneCtrl.mobileNo.text.trim().toString();
          loginCtrl.userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());
          // Get.offAll(HomeScreen());
          print('login successful');
          clientCtrl
              .showLoggedInUserData(phoneCtrl.mobileNo.text.trim().toString());
        } else {
          phoneCtrl.buttonCtrl.reset();
          butCtrl.reset();
          Get.snackbar(
            S.of(Get.context).errorOc,
            '',
            backgroundColor: Colors.white,
            duration: Duration(seconds: 2),
            colorText: Colors.teal,
          );
        }
      }).catchError((e) {
        print('INNER CATCH CALLED');
        phoneCtrl.buttonCtrl.reset();
        butCtrl.error();
        Get.snackbar(
          S.of(Get.context).errorOc,
          '',
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          colorText: Colors.teal,
        );
        otpController.clear();
        butCtrl.reset();
        phoneCtrl.buttonCtrl.reset();
      });
    } on Exception catch (e) {
      print('CATCH CALLED');
      phoneCtrl.buttonCtrl.reset();
      butCtrl.error();
      Get.snackbar(
        S.of(Get.context).errorOc,
        '',
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
      otpController.clear();
    } finally {
      butCtrl.reset();
      phoneCtrl.buttonCtrl.reset();
    }
    /* else if (value != null*/ /* && token == 'newuser'*/ /*) {
        print("New user");
        Get.to(HomeScreen());
      }*/

    //errorController.add(ErrorAnimationType.shake);
  }

/*displaySnackBar(FirebaseAuthException exception) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.kffffff,
      content: Text(exception.message,
          style: kInterText.copyWith(
            color: AppColors.kff4165,
            fontSize: 15,
          )),

      elevation: 2,
      behavior: SnackBarBehavior.floating,
    );

    return snackBar;
  }
*/

}
