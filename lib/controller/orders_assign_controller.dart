import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderAssignController extends GetxController {
  SignInController mobileCtrl = Get.put(SignInController());
  //OtpController otpCtrl = Get.put(OtpController());
  RepoController rCtrl = Get.put(RepoController());
  RxBool isLoading = false.obs;
  RxInt ordersDelCount = 0.obs;
  RxInt pressedButtonIndex = 0.obs;
  RxBool noOrderLeft = false.obs;
  RxBool showDelivered = false.obs;
  var isLoadingButton = -1.obs;
  RxBool noOrderDelivered = false.obs;
  RxList<ParseObject> orderList = <ParseObject>[].obs;
  RxList<ParseObject> completeOrderData = <ParseObject>[].obs;
  RxList<ParseObject> deliveredOrders = <ParseObject>[].obs;
  final RoundedLoadingButtonController ctrl = RoundedLoadingButtonController();
  TextEditingController sizeC = TextEditingController();
  TextEditingController unitC = TextEditingController();
  Future<String> returnMobile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var number = await pref.getString(rCtrl.kMobile);
    return number;
  }

  QueryBuilder showOrder(String mobile) {
    QueryBuilder<ParseObject> orders =
        QueryBuilder<ParseObject>(ParseObject('Orders'))
          ..orderByDescending('updatedAt')
          ..whereEqualTo('deliveryBoyNum', mobile)
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

  Future<void> deliveryReport(
      String name, String mobile, int ordersCount) async {
    print("called del report");
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('DeliveryMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('delName', name)
            ..whereEqualTo('number', mobile);

      ParseResponse response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print("no user exist creating new one");
          ParseObject newClient = ParseObject('DeliveryMetadata')
            ..set<String>('delName', name)
            ..set('number', mobile)
            ..set<int>('ordersDelivered', ordersCount);

          ParseResponse reportResult = await newClient.create();
          if (reportResult.success) {
            //rCtrl.setOrdersMetadataObjectId(reportResult.result['objectId']);
            //print(reportResult.result['objectId']);
            //rCtrl.loadObjId();
            //SharedPreferences preference =
            //  await SharedPreferences.getInstance();
            // print("@@@${preference.getString(rCtrl.kOrderObjectId)}");
          }
        } else {
          print("user already there updating purchaseCount");
          ParseObject client = response.result[0]
            ..set('delName', name)
            ..set('number', mobile)
            ..set('ordersDelivered', ordersCount);

          ParseResponse reportResult = await client.save();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setDeliveryStatus(
      ParseObject orderObject, String deliveryStatus) async {
    //isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      //orderObject..setAdd('deliveryBoy', object);
      orderObject..set('deliveryStatus', deliveryStatus);
      ParseResponse adResult = await orderObject.save();
      if (adResult.success) {
        print("updated delivery status successfully");
        await showDeliveredOrder(pref.getString(rCtrl.kMobileNum));
        deliveryReport(pref.getString(rCtrl.kname),
            pref.getString(rCtrl.kMobileNum), deliveredOrders.length);
        Get.back();
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
            ..orderByDescending('updatedAt')
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

  Future<void> chooseFile(Uint8List pickedFile, ParseObject orderObject) async {
    isLoading.value = true;
    print('called choose file');
    //var name
    try {
      //var image = Image.network(pickedFile.path);
      //var image = MemoryImage(pickedFile);
      /* ParseFile img =
          ParseFile(File.fromRawPath(pickedFile), name: "signature");*/
      ParseWebFile pic = ParseWebFile(pickedFile, name: "sig");
      orderObject..set<ParseWebFile>("custSignature", pic);
      ParseResponse adResult = await orderObject.save();
      if (adResult.success) {
        print("signature added");
        isLoading.value = false;
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
