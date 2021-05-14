import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInController extends GetxController {
  TextEditingController mobileNo = TextEditingController();
  TextEditingController password = TextEditingController();
  RoundedLoadingButtonController buttonCtrl = RoundedLoadingButtonController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String verificationId;
  RxString countryCode = "".obs;
  String phoneCode;
  RxBool isLoading = false.obs;
  RxBool hidePassword = true.obs;
}
