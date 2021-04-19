import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OrderAssignController extends GetxController {
  SignInController mobileCtrl = Get.put(SignInController());
  //OtpController otpCtrl = Get.put(OtpController());
  RepoController rCtrl = Get.put(RepoController());
  RxBool isLoading = false.obs;
  RxInt pressedButtonIndex = 0.obs;
  RxBool noOrderLeft = false.obs;
  RxBool showDelivered = false.obs;
  var isLoadingButton = -1.obs;
  RxBool noOrderDelivered = false.obs;
  RxList<ParseObject> orderList = <ParseObject>[].obs;
  RxList<ParseObject> completeOrderData = <ParseObject>[].obs;
  RxList<ParseObject> deliveredOrders = <ParseObject>[].obs;
  final RoundedLoadingButtonController ctrl = RoundedLoadingButtonController();

  QueryBuilder showOrder(String mobile) {
    QueryBuilder<ParseObject> orders =
        QueryBuilder<ParseObject>(ParseObject('Orders'))
          ..orderByDescending('updatedAt')
          ..whereEqualTo('deliveryBoyNum', "9825569974")
          ..whereNotEqualTo('deliveryStatus', "yes");
    return orders;
  }

  Future<void> showAssignedOrder(String mobile) async {
    isLoading.value = true;
    print("called load assign order data");
    try {
      print('load User try executed');
      QueryBuilder<ParseObject> orders =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('deliveryBoyNum', mobile)
            ..whereNotEqualTo('deliveryStatus', "yes");

      ParseResponse response = await orders.query();
      //showDeliveredOrder(mobile);
      print("client query");
      if (response.success) {
        print(response);
        orderList.removeRange(0, orderList.length);
        orderList(response.results);
        noOrderLeft.value = false;
        isLoading.value = false;
        if (orderList.isEmpty) {
          noOrderLeft.value = true;
        }
        isLoading.value = false;

        print("this is new order list to be delivered ${orderList}");
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Error Occured",
          "Error in Showing Assigned Orders",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          colorText: Colors.teal,
        );
        print("error occured ");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error Occured",
        "Error in Showing Assigned Order",
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        colorText: Colors.teal,
      );
      print(e);
    }
  }

  Future<void> loadData() async {
    QueryBuilder<ParseObject> orderData =
        QueryBuilder<ParseObject>(ParseObject('Orders'))
          ..orderByDescending('createdAt');
    isLoading.value = true;
    print("called load order data");
    try {
      print("execute try");
      ParseResponse result = await orderData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        completeOrderData(result.results);
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Error ! Please try again.",
          "Order Data Not Loaded",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          colorText: Colors.teal,
        );
      }
    } catch (e) {
      isLoading.value = false;
      //print("default error---" + e.toString());
      Get.snackbar(
        "Error ! Please try again.",
        "Order Data Not Loaded",
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
        colorText: Colors.teal,
      );
    } finally {
      print("Finally executed");
    }
  }

  Future<void> setDeliveryStatus(
      ParseObject orderObject, String deliveryStatus) async {
    //isLoading.value = true;

    try {
      //orderObject..setAdd('deliveryBoy', object);
      orderObject..set('deliveryStatus', deliveryStatus);
      ParseResponse adResult = await orderObject.save();
      if (adResult.success) {
        print("updated delivery status successfully");
        //showAssignedOrder(rCtrl.number);
        //isLoadingButton = -1;
        //showDeliveredOrder(rCtrl.number);
        //isLoading.value = false;
        final snackBar = SnackBar(
          width: MediaQuery.of(Get.context).size.width / 2,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Order Delivered Successfully",
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
          elevation: 10.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      } else {
        isLoading.value = false;
        isLoadingButton = -1;
        Get.snackbar(
          "Error ! Please try again.",
          "Order Delivery Status Not updated",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          colorText: Colors.teal,
        );
      }
    } catch (e) {
      isLoadingButton = -1;
      isLoading.value = false;
      print(" error---" + e.toString());
      Get.snackbar(
        "Error ! Please try again.",
        "Order Delivery Status Not updated",
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
        colorText: Colors.teal,
      );
    } finally {
      print("Finally executed");
    }
  }

  Future<void> showDeliveredOrder(String mobile) async {
    showDelivered.value = true;

    try {
      //orderObject..setAdd('deliveryBoy', object);
      QueryBuilder<ParseObject> orderData =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('deliveryBoyNum', mobile)
            ..whereEqualTo('deliveryStatus', 'yes');

      ParseResponse adResult = await orderData.query();
      if (adResult.success) {
        print("assigned Delivery boy success");
        print("11111");
        deliveredOrders.removeRange(0, deliveredOrders.length);
        print("11111");
        deliveredOrders(adResult.results);
        print("11111");
        print(deliveredOrders);
        if (deliveredOrders.isEmpty) {
          noOrderDelivered.value = true;
        }
        showDelivered.value = false;
        final snackBar = SnackBar(
          width: MediaQuery.of(Get.context).size.width / 2,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Delivery History Updated",
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
          elevation: 10.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      } else {
        showDelivered.value = false;

        Get.snackbar(
          "Error ! Please try again.",
          "Delivery History Not Updated",
          backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          colorText: Colors.teal,
        );
      }
    } catch (e) {
      showDelivered.value = false;
      print("default error---" + e.toString());
      Get.snackbar(
        "Catch Error ! Please try again.",
        "Delivery History Not Updated",
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
        colorText: Colors.teal,
      );
    } finally {
      print("Finally executed");
    }
  }

  Future<void> chooseFile(Uint8List pickedFile) async {
    isLoading.value = true;
    print('called choose file');
    try {
      //var image = Image.network(pickedFile.path);
      //var image = MemoryImage(pickedFile);
      /* ParseFile img =
          ParseFile(File.fromRawPath(pickedFile), name: "signature");*/
      ParseWebFile pic = ParseWebFile(pickedFile, name: "Signature");
      ParseObject proData = ParseObject('Orders')
        ..set<ParseWebFile>("custSignature", pic);
      ParseResponse adResult = await proData.create();
      if (adResult.success) {
        print("signature added");
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
      Get.back();
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      return e;
    }
  }
}
