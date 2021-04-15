import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/model/cart_item.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:pcm/view/purchase_receipt.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxDouble delivery = 20.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxBool isLoading = false.obs;
  RxList orderDetails = [].obs;
  RxList orderHistory = [].obs;
  RxList orderRHistory = [].obs;
  RxInt quantity = 0.obs;
  RxString payment_option = "".obs;
  RoundedLoadingButtonController buttonCtrl = RoundedLoadingButtonController();
  QueryBuilder<ParseObject> orderData =
      QueryBuilder<ParseObject>(ParseObject('Orders'));
  SignInController ctrl = Get.put(SignInController());
  RepoController rCtrl = Get.put(RepoController());

  Future<String> getMobile() async {
    SharedPreferences mobile = await SharedPreferences.getInstance();

    return mobile.getString(rCtrl.kMobile);
  }

  QueryBuilder showOrderHistory(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', rCtrl.number);

      return loadOrderHistory;
    } catch (e) {
      print(e);
    }
  }

  Future<void> showROrderHistoryData(String mobile) async {
    try {
      print("showROrderDatahistory called");
      QueryBuilder<ParseObject> loadROrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile)
            ..whereEqualTo('deliveryStatus', 'yes');

      ParseResponse rOrderData = await loadROrderHistory.query();
      if (rOrderData.success) {
        orderRHistory.removeRange(0, orderRHistory.length);
        orderRHistory(rOrderData.results);
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> showOrderHistoryData(String mobile) async {
    try {
      print("showOrderDatahistory called");
      QueryBuilder<ParseObject> loadOrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile);

      ParseResponse orderData = await loadOrderHistory.query();
      if (orderData.success) {
        orderHistory(orderData.results);
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  QueryBuilder showReceivedOrder(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderReceived =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', rCtrl.number)
            ..whereEqualTo('deliveryStatus', 'yes');

      return loadOrderReceived;
    } catch (e) {
      print(e);
    }
  }

  int get itemCount {
    return cartList == null ? 0 : cartList.length;
  }

  double get totalA {
    var total = 0.0.obs;
    cartList.forEach((cartItem) {
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
    print("@@ ${cartList.length}");
    print("#### $cartList");
    print('process of add to cart');
    try {
      if (cartList.isEmpty) {
        print("cart empty added new");
        cartList.add(CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: quantity,
          size: size,
        ));
        Get.snackbar(
          "Cart Updated Successfully",
          "Item Added to Cart",
          backgroundColor: Colors.black.withOpacity(0.8),
          maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
          colorText: Colors.white,
        );
        print(cartList.length);
      } else {
        if (checkProductContains(productId, size)) {
          List<CartItem>.from(cartList).forEach((element) {
            print("called for each");
            if (element.id == productId && element.size == size) {
              print("quantity ++");
              element.quantity += quantity;
              Get.snackbar(
                "Cart Updated Successfully",
                "Item Added to Cart",
                backgroundColor: Colors.black.withOpacity(0.8),
                maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
                colorText: Colors.white,
              );
            }
          });
        } else {
          print("else");
          cartList.add(CartItem(
            id: productId,
            title: title,
            price: price,
            quantity: quantity,
            size: size,
          ));
          Get.snackbar(
            "Cart Updated Successfully",
            "Item Added to Cart",
            backgroundColor: Colors.black.withOpacity(0.8),
            maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
            colorText: Colors.white,
          );
          print("AAAAAA ${cartList.length}");
        }
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Some Internal Error",
        "Please logout and try again",
        backgroundColor: Colors.black.withOpacity(0.8),
        maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
        colorText: Colors.white,
      );
    }

    /*if (cartItems.containsKey(productId)) {
      print('product already there, updating');
      cartItems.update(productId, (existingcardItem) {
        print(existingcardItem.size);
        print(size);
        if (existingcardItem.size == size) {
          return CartItem(
            id: existingcardItem.id,
            title: existingcardItem.title,
            quantity: existingcardItem.quantity + quantity,
            price: existingcardItem.price,
            size: existingcardItem.size,
          );
          */ /*cartItems.putIfAbsent(
              size,
              () => CartItem(
                    id: existingcardItem.id,
                    title: existingcardItem.title,
                    price: existingcardItem.price,
                    quantity: quantity,
                    size: size,
                  ));*/ /*
        }
      });
    } else {
      print('new to the cart');
      var firstSize = size;
      print("####$firstSize");
      cartItems.putIfAbsent(
          productId,
          () => CartItem(
                id: productId,
                title: title,
                price: price,
                quantity: quantity,
                size: firstSize,
              ));*/

    /*else if (cartItems.containsKey(productId) &&
          !cartItems.containsValue(size)) {
        cartItems.putIfAbsent(
            size,
            () => CartItem(
                  id: DateTime.now().toString(),
                  title: title,
                  price: price,
                  quantity: quantity,
                  size: size,
                ));
      } else {
        print("null");
      }*/
    /*else {
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
      }*/
    /*   if (cartItems.containsKey(productId)) {
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
      } */
  }
  /*print('product added to the cart');
    print(cartItems);*/

  void removeItem(String productId) {
    //cartItems.remove(productId);
    cartList.remove(productId);
    quantity--;
    print(productId);
    print("remove item from cart");
  }

  /*void singleItem(String prodId) {
    if (!cartList.containsKey(prodId)) {
      return;
    }
    if (cartList[prodId].quantity > 1) {
      cartList.update(
          prodId,
          (i) => CartItem(
                id: i.id,
                title: i.title,
                quantity: i.quantity - 1,
                price: i.price,
                size: i.size,
              ));
    } else {
      cartList.remove(prodId);
    }
  }*/

  // void clear() {
  //   cartList = {};
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
      for (var i = 0; i < cartList.length; i++) {
        details.add({
          'name': cartList[i].title,
          'price': cartList[i].price,
          'quantity': cartList[i].quantity,
          'id': cartList[i].id,
          'size': cartList[i].size,
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
        "Please logout and try again",
        backgroundColor: Colors.black.withOpacity(0.8),
        maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
        colorText: Colors.white,
      );
    } finally {
      print('orderPlaced finally');
    }
  }

  bool checkProductContains(String productId, String size) {
    var indexOfProduct = cartList.indexWhere(
        (element) => element.id == productId && element.size == size);

    return indexOfProduct != -1;
  }
}
