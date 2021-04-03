import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OtpController extends GetxController {
  String verificationId;
  FocusNode otpFocus = FocusNode();
  OrderAssignController assignCtrl = Get.put(OrderAssignController());

  RoundedLoadingButtonController butCtrl = RoundedLoadingButtonController();

  String otpValue = "";
  RxBool isLoading = false.obs;
  String token;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  SignInController phoneCtrl = Get.put(SignInController());
  LoginController loginCtrl = Get.put(LoginController());
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
    print("Register user called");
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+${phoneCtrl.phoneCode}" + phoneCtrl.mobileNo.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          isLoading.value = false;
          print("Verification Successful");
          phoneCtrl.buttonCtrl.success();
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user;
          print("this is user");
          print(user);
          if (user != null) {
            print("User is  registered");
            loginCtrl
                .userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());
            assignCtrl
                .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification Failed Auth Exception");
          butCtrl.reset();
          phoneCtrl.buttonCtrl.reset();
          Get.snackbar(
            "Firebase Exception",
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
          print("code sent $verificationId $code");
          this.verificationId = verificationId;
          print("Code is sent");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
          butCtrl.reset();
          phoneCtrl.buttonCtrl.reset();
          Get.snackbar(
            "Enter Otp Manually",
            "Automatic Otp verification failed",
            backgroundColor: Colors.white,
            duration: Duration(seconds: 2),
            colorText: Colors.teal,
          );
          print("Timeout");
          print(verificationId);
        },
      );
    } catch (e) {
      phoneCtrl.buttonCtrl.reset();
      butCtrl.reset();
      print("Verfication Failed");
    }
  }

//Function to verify manually and verify added otp if not automatically verified
  verifyPhoneManually() {
    phoneCtrl.isLoading.value = false;
    print("verify phone manually");
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );

    _auth.signInWithCredential(credential).then((value) {
      print("Result is $value");
      if (value != null /*&& token == 'registered'*/) {
        butCtrl.success();
        print("User already registered");
        loginCtrl.userMobileLogin(phoneCtrl.mobileNo.text.trim().toString());
        // Get.offAll(HomeScreen());
        print("login successful");
        assignCtrl.showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
      } /* else if (value != null*/ /* && token == 'newuser'*/ /*) {
        print("New user");
        Get.to(HomeScreen());
      }*/
      else {
        butCtrl.reset();
        Get.snackbar(
          "Error Occured",
          "Otp verification failed,Please try again",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          colorText: Colors.teal,
        );
        otpController.clear();
        //errorController.add(ErrorAnimationType.shake);
      }
    });
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
