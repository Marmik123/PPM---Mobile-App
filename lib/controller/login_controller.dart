import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/repository/user_repository.dart';

import '../view/home/homes_screen_sales.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  GlobalKey<FormState> key = GlobalKey();

  final userController = TextEditingController();
  final passController = TextEditingController();
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
