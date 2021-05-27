import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';

class SupportController extends GetxController {
  RxList<ParseObject> sData = <ParseObject>[].obs;
  RxBool supportLoading = false.obs;

  Future<void> loadData() async {
    supportLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> supportData =
          QueryBuilder<ParseObject>(ParseObject('Support'))
            ..orderByDescending('createdAt');
      print("execute try");
      ParseResponse result = await supportData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        sData(result.results);
        print("this is the list $sData");
        supportLoading.value = false;
      } else {
        supportLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            S.of(Get.context).errorOc,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.cyan,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      supportLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          S.of(Get.context).errorOcu,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.cyan, fontSize: 55, fontWeight: FontWeight.w500),
          ),
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }
}
