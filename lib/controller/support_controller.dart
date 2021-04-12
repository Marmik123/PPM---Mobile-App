import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SupportController extends GetxController {
  RxList<ParseObject> sData = <ParseObject>[].obs;
  RxBool isLoading = false.obs;
  QueryBuilder<ParseObject> supportData =
      QueryBuilder<ParseObject>(ParseObject('Support'))
        ..orderByDescending('createdAt');

  Future<void> loadData() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      print("execute try");
      ParseResponse result = await supportData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        sData(result.results);
        print("this is the list $sData");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
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
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
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
