import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/home/home_screen_client.dart';
import 'package:pcm/view/home/home_screen_delivery.dart';
import 'package:pcm/view/home/home_screen_marketing.dart';

import '../view/home/homes_screen_sales.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  String mobileNum;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RepoController rCtrl = Get.put(RepoController());
  final userController = TextEditingController();
  final passController = TextEditingController();
  SignInController phoneCtrl = Get.put(SignInController());
  OrderAssignController orderCtrl = Get.put(OrderAssignController());
  QueryBuilder<ParseObject> clientInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'Client');

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
          "Error Occured",
          "Some Internal Error,Please try again.",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          colorText: Colors.teal,
        );
        print("error occured ");
      }
    } catch (e) {
      Get.snackbar(
        "Error Occured",
        "Some Internal Error,Please try again.",
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
      print(e);
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
        "Some Internal Error,Please try again.",
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
