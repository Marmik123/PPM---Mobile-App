import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/home/home_screen_client.dart';
import 'package:pcm/view/home/home_screen_delivery.dart';
import 'package:pcm/view/home/home_screen_marketing.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../view/home/homes_screen_sales.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool oldDataReceived = false.obs;
  RxBool userNotExist = false.obs;
  String mobileNum;
  RxList oldData = [].obs;
  RxList loggedUserData = [].obs;
  RxString initialMob = ''.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  SignInController ctrl = Get.put(SignInController());
  RepoController rCtrl = Get.put(RepoController());
  final userController = TextEditingController();
  final passController = TextEditingController();
  SignInController phoneCtrl = Get.put(SignInController());
  OrderAssignController orderCtrl = Get.put(OrderAssignController());
  QueryBuilder<ParseObject> clientInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'Client');
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  QueryBuilder<ParseObject> salesInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'SalesPerson');

  QueryBuilder<ParseObject> delInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'DeliveryBoy');

  Future<void> userMobileLogin(String mobile) async {
    try {
      print('load User try executed');
      QueryBuilder<ParseObject> data =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..whereEqualTo('number', mobile);
      ParseResponse response = await data.query();
      print("client query");
      if (response.success) {
        print(response);
        print('#####');
        loggedUserData.removeRange(0, loggedUserData?.length);
        loggedUserData(response.results);
        print(loggedUserData);
        print("@#%");
        initialMob.value = loggedUserData[0]['number'].toString();
        print(response.results);
        print('#####');
        await rCtrl.setUserData(response.results[0]['role'],
            phoneCtrl.mobileNo.text.trim().toString());
        mobileNum = phoneCtrl.mobileNo.text.trim().toString();
        rCtrl.loadUserData();
        if (response.results == null) {
          Get.offAll(() => HomeScreen());
        } else if (response.results[0]['role'] == "Client") {
          Get.offAll(() => HomeScreenClient());
        } else if (response.results[0]['role'] == "Marketing") {
          Get.offAll(() => HomeScreenM());
        } else if (response.results[0]['role'] == "DeliveryBoy") {
          Get.offAll(() => HomeScreenDelivery(
                mobileNum: rCtrl.kMobile,
              ));
          await orderCtrl
              .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
        } else if (response.results[0]['role'] == "SalesPerson") {
          Get.offAll(() => HomeScreen());
        }
      } else {
        Get.snackbar(
          S.of(Get.context).errorOcu,
          S.of(Get.context).errorOc,
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          colorText: Colors.teal,
        );
        print("error occured ");
      }
    } catch (e) {
      Get.snackbar(
        S.of(Get.context).errorOcu,
        S.of(Get.context).errorOc,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
      print(e);
    }
  }

  Future<void> checkUserExist(number) async {
    try {
      oldDataReceived.value = false;
      userNotExist.value = false;
      QueryBuilder doc = QueryBuilder(ParseObject('UserMetadata'))
        ..whereEqualTo('number', number);
      ParseResponse result = await doc.query();
      if (result.success) {
        if (result.result != null) {
          print("#####USer Exist");
          userNotExist.value = false;
        }
        if (result.result == null) {
          print("User Does not exist");
          btnController.error();
          userNotExist.value = true;
          Get.snackbar(
            '',
            '',
            messageText: Text(
              S.of(Get.context).userNot,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            titleText: Text(
              S.of(Get.context).signUpSnack,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            icon: Icon(Icons.cancel),
            backgroundColor: Colors.cyan,
            backgroundGradient:
                LinearGradient(colors: [Colors.white, Colors.cyan]),
            snackStyle: SnackStyle.FLOATING,
          );
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkMobileExist(number) async {
    try {
      oldDataReceived.value = false;
      userNotExist.value = false;
      QueryBuilder doc = QueryBuilder(ParseObject('UserMetadata'))
        ..whereEqualTo('number', number);
      ParseResponse result = await doc.query();
      if (result.success) {
        if (result.result != null) {
          oldData.removeRange(0, oldData?.length);
          oldData.add(result.result);
          print("get user data success");
          print("####${oldData()}");
          Get.snackbar(
            '',
            '',
            messageText: Text(
              S.of(Get.context).request,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            titleText: Text(
              S.of(Get.context).alreadyExist,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            icon: Icon(Icons.cancel),
            backgroundColor: Colors.cyan,
            backgroundGradient:
                LinearGradient(colors: [Colors.white, Colors.cyan]),
            snackStyle: SnackStyle.FLOATING,
          );
        }
        if (result.result == null) {
          print("User Does not exist");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserData() async {
    var number = phoneCtrl.mobileNo.text.trim().toString();
    try {
      oldDataReceived.value = false;
      userNotExist.value = false;
      QueryBuilder doc = QueryBuilder(ParseObject('UserMetadata'))
        ..whereEqualTo('number', number);
      ParseResponse result = await doc.query();
      if (result.success) {
        if (result.result != null) {
          oldData.removeRange(0, oldData?.length);
          oldData.add(result.result);
          print("get user data success");
          print("####${oldData()}");
          oldDataReceived.value = true;
        }
        if (result.result == null) {
          userNotExist.value = true;
          ctrl.buttonCtrl.reset();

          Get.snackbar(
            '',
            '',
            messageText: Text(
              S.of(Get.context).signUpSnack,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            titleText: Text(
              S.of(Get.context).userNot,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
            icon: Icon(Icons.supervised_user_circle_sharp),
            backgroundColor: Colors.cyan,
            backgroundGradient:
                LinearGradient(colors: [Colors.white, Colors.cyan]),
            snackStyle: SnackStyle.FLOATING,
          );
        }
      }
    } catch (e) {
      print(e);
      ctrl.buttonCtrl.reset();
    }
  }

/*
  Future<ParseUser> login(
    String username,
    String pass,
  ) async {
    var user = ParseUser(username, pass, null);
    if (!key.currentState.validate()) {
      return null;
    }
    key.currentState.save();
    isLoading.value = true;
    var result = await user.login();
    if (result.success) {
      print(user.objectId);
      userParse = user;
      Get.to(HomeScreen());
    } else {
      print(result.error.message);
      Get.snackbar(
        "Error Occured",
        S.of(Get.context).errorOc,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text(S.of(context).invalidUser),
      //     content: Text(S.of(context).falseEntry),
      //     actions: [
      //       FlatButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('Okay'))
      //     ],
      //   ),
      // );
    }

    isLoading.value = false;

    return user;
  }
*/

// Future<ParseUser> signUP(username, pass) async {
//   var user = ParseUser(username, pass, '')..set('role', 'admin');
//   var result = await user.create();
//   if (result.success) {
//     print(user.objectId);
//     // Navigator.of(context).pushReplacementNamed(Tabs.routeName);
//   } else {
//     print(result.error.message);
//   }
//   return user;
// }
}
