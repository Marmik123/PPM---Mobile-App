import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:loading_hud/loading_hud.dart';
// import 'package:loading_hud/loading_indicator.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FeedbackController extends GetxController {
  GlobalKey fkey = GlobalKey();
  final TextEditingController sController = TextEditingController();
  final TextEditingController mController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();
  RepoController rCtrl = Get.put(RepoController());
  Future<void> sendFeedback() async {
    try {
      // var loadingHud = LoadingHud(
      //   Get.context,
      //   cancelable: false,
      //   canceledOnTouchOutside: false,
      //   dimBackground: true,
      //   hudColor: Color(0x99000000),
      //   indicator: DefaultLoadingIndicator(
      //     color: Colors.white,
      //   ),
      // )..show();

      ParseObject feedbackData = ParseObject('Feedback')
        ..set('subject', sController.text)
        ..set('message', mController.text)
        ..set('userData', rCtrl.currentUser);
      ParseResponse response = await feedbackData.create();
      if (response.success) {
        // loadingHud.dismiss();
        sController.clear();
        mController.clear();
        btnController.success();
      }
    } catch (e) {
      print(e);
      btnController.error();
    } finally {
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => btnController.reset());
    }
  }
}
