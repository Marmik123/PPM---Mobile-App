import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/model/cart_item.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/view/purchase_receipt.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CartController extends GetxController {
  RxDouble delivery = 20.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxBool isLoading = false.obs;
  RxList orderDetails = [].obs;
  RxList orderHistory = [].obs;
  RxInt quantity = 0.obs;
  RxString payment_option = "".obs;
  RoundedLoadingButtonController buttonCtrl = RoundedLoadingButtonController();
  QueryBuilder<ParseObject> orderData =
      QueryBuilder<ParseObject>(ParseObject('Orders'));
  SignInController ctrl = Get.put(SignInController());

  QueryBuilder showOrderHistory(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile);
      return loadOrderHistory;
    } catch (e) {
      print(e);
    }
  }

  QueryBuilder showReceivedOrder(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderReceived =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile)
            ..whereEqualTo('deliveryStatus', 'yes');
      return loadOrderReceived;
    } catch (e) {
      print(e);
    }
  }

  int get itemCount {
    return cartItems == null ? 0 : cartItems.length;
  }

  double get totalA {
    var total = 0.0.obs;
    cartItems.forEach((key, cartItem) {
      total.value += cartItem.price * cartItem.quantity;
    });
    return total.value;
  }

  void addItem(
    String productId,
    String title,
    double price,
    int quantity,
    String size,
  ) {
    print('process of add to cart');
    if (cartItems.containsKey(productId)) {
      print('product already there, updating');
      cartItems.update(
        productId,
        (existingcardItem) => CartItem(
          id: existingcardItem.id,
          title: existingcardItem.title,
          quantity: existingcardItem.quantity + quantity,
          price: existingcardItem.price,
          size: existingcardItem.size,
        ),
      );
    } else {
      print('new to the cart');
      cartItems.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: quantity,
                size: size,
              ));
    }
    print('product added to the cart');
    Get.snackbar(
      "Cart Updated Successfully",
      "Item Added to Cart",
      backgroundColor: Colors.black.withOpacity(0.8),
      maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
      colorText: Colors.white,
    );
  }

  void removeItem(String productId) {
    cartItems.remove(productId);
    quantity--;
    print("remove item from cart");
  }

  void singleItem(String prodId) {
    if (!cartItems.containsKey(prodId)) {
      return;
    }
    if (cartItems[prodId].quantity > 1) {
      cartItems.update(
          prodId,
          (i) => CartItem(
                id: i.id,
                title: i.title,
                quantity: i.quantity - 1,
                price: i.price,
                size: i.size,
              ));
    } else {
      cartItems.remove(prodId);
    }
  }

  // void clear() {
  //   cartItems = {};
  // }

  Future<void> orderPlaced(
      {price,
      String customerName,
      String size,
      String customerAddress,
      String customerMobile}) async {
    var details = [];
    try {
      isLoading.value = true;
      for (var i = 0; i < cartItems.length; i++) {
        details.add({
          'name': cartItems.values.toList()[i].title,
          'price': cartItems.values.toList()[i].price,
          'quantity': cartItems.values.toList()[i].quantity,
          'id': cartItems.values.toList()[i].id,
          'size': cartItems.values.toList()[i].size,
        });
      }
      // List<CartItem> details = List.generate(
      //   cartItems.length,
      //   (index) => CartItem(
      //     id: cartItems.values.toList()[index].id,
      //     title: cartItems.values.toList()[index].title,
      //     quantity: cartItems.values.toList()[index].quantity,
      //     price: cartItems.values.toList()[index].price,
      //   ),
      // );
      print('length ${details.length}');
      print('this is details of ordered products $details');

      ParseObject orderData = ParseObject('Orders')
        ..setAddAll('order_details', details)
        ..set('address', '')
        ..set('date_time', DateTime.now())
        ..set('payment_option', payment_option)
        ..set('total_price', price)
        ..set('delivery_fees', '')
        ..set('customerName', customerName)
        ..set('customerAddress', customerAddress)
        ..set('customerContactNo', customerMobile)
        ..set('size', size);
      ParseResponse response = await orderData.create();
      var objectId;
      if (response.success) {
        buttonCtrl.success();
        print("order data is $orderData");
        orderHistory.add(orderData);
        isLoading.value = false;
        print(response.result.get('objectId'));
        objectId = response.result.get('objectId');
        print('successful!!!!!!!!!!');
        Get.snackbar(
          "Order Placed Successfully",
          "",
          backgroundColor: Colors.black.withOpacity(0.8),
          maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
          colorText: Colors.white,
        );
        Future.delayed(Duration(milliseconds: 800), () {
          Get.off(() => PurchaseReceipt(orderData));
        });
        // ParseResponse result=await order.query();

      }
    } catch (e) {
      print('error in orderPlaced $e');
      buttonCtrl.error();
      Get.snackbar(
        "Error",
        "",
        backgroundColor: Colors.black.withOpacity(0.8),
        maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
        colorText: Colors.white,
      );
    } finally {
      print('orderPlaced finally');
    }
  }
}
