import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/model/cart_item.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/utils/shared_preferences.dart';
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
  RxInt purchaseCount = 0.obs;
  RxBool orderH = false.obs;
  RxInt rOrders = 0.obs;
  RxInt pOrders = 0.obs;
  RxString payment_option = 'COD'.obs;
  RoundedLoadingButtonController buttonCtrl = RoundedLoadingButtonController();
  QueryBuilder<ParseObject> orderData =
      QueryBuilder<ParseObject>(ParseObject('Orders'));
  SignInController ctrl = Get.put(SignInController());
  RepoController rCtrl = Get.put(RepoController());

  Future<String> getMobile() async {
    var mobile = await SharedPreferences.getInstance();

    return mobile.getString(rCtrl.kMobile);
  }

  QueryBuilder showOrderHistory(String mobile) {
    try {
      var loadOrderHistory = QueryBuilder<ParseObject>(ParseObject('Orders'))
        ..whereEqualTo('customerContactNo', rCtrl.number);

      return loadOrderHistory;
    } catch (e) {
      print(e);
    }
  }

  Future clientReport(
      String name, String mobile, int purchaseCount, String shopName) async {
    print('called client report');
    try {
      var userData = QueryBuilder<ParseObject>(ParseObject('OrdersMetadata'))
        //ParseObject userData = ParseObject('UserMetadata')
        ..whereEqualTo('clientName', name)
        ..whereEqualTo('number', mobile);

      var response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print('no user exist creating new one');
          var newClient = ParseObject('OrdersMetadata')
            ..set<String>('clientName', name)
            ..set('number', mobile)
            ..set('shopName', shopName)
            ..set<int>('productsPurchased', purchaseCount);

          var reportResult = await newClient.create();
          if (reportResult.success) {
            await rCtrl
                .setOrdersMetadataObjectId(reportResult.result['objectId']);
            print(reportResult.result['objectId']);
            await rCtrl.loadObjId();
            var preference = await SharedPreferences.getInstance();
            print('@@@${preference.getString(rCtrl.kOrderObjectId)}');
          }
        } else {
          print('user already there updating purchaseCount');
          ParseObject client = response.result[0]
            ..set('clientName', name)
            ..set('number', mobile)
            ..set('shopName', shopName)
            ..set('productsPurchased',
                response.result[0]['productsPurchased'] + purchaseCount);

          var reportResult = await client.save();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> showROrderHistoryData(String mobile) async {
    orderH.value = true;
    try {
      print('showROrderDatahistory called');
      var loadROrderHistory = QueryBuilder<ParseObject>(ParseObject('Orders'))
        ..whereEqualTo('customerContactNo', mobile)
        ..whereEqualTo('deliveryStatus', 'yes');

      var rOrderData = await loadROrderHistory.query();
      if (rOrderData.success) {
        orderRHistory.removeRange(0, orderRHistory.length);
        orderRHistory(rOrderData.results);
        rOrders.value = orderRHistory().length;
        orderH.value = false;
      } else {
        print('error');
      }
    } catch (e) {
      orderH.value = false;
      print(e);
    }
  }

  Future<void> showOrderHistoryData(String mobile) async {
    try {
      orderH.value = true;
      print('showOrderDatahistory called');
      var loadOrderHistory = QueryBuilder<ParseObject>(ParseObject('Orders'))
        ..whereEqualTo('customerContactNo', mobile);

      var orderData = await loadOrderHistory.query();
      if (orderData.success) {
        orderHistory(orderData.results);
        pOrders.value = orderHistory().length;
        orderH.value = false;
      } else {
        print('error');
      }
    } catch (e) {
      orderH.value = false;
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
    String unit,
    String imageName,
  ) {
    print('@@ ${cartList.length}');
    print("#### $cartList");
    print('process of add to cart');
    try {
      if (cartList.isEmpty) {
        print("cart empty added new");
        print(imageName);
        cartList.add(CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: quantity,
          size: size,
          unit: unit,
          imageName: imageName,
        ));
        Get.snackbar(
          '',
          '',
          messageText: Text(
            S.of(Get.context).itemAdded,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ),
          titleText: Text(
            S.of(Get.context).cartUpdated,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ),
          icon: Icon(Icons.add_shopping_cart_outlined),
          backgroundColor: Colors.cyan,
          backgroundGradient:
              LinearGradient(colors: [Colors.white, Colors.cyan]),
          snackStyle: SnackStyle.FLOATING,
        );
        /*Get.snackbar(
          "Cart Updated Successfully",
          "Item Added to Cart",
          backgroundColor: Colors.black.withOpacity(0.8),
          maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
          colorText: Colors.white,
        );*/
        print(cartList.length);
      } else {
        if (checkProductContains(productId, size, unit)) {
          List<CartItem>.from(cartList).forEach((element) {
            print("called for each");
            if (element.id == productId && element.size == size) {
              if (element.unit == unit) {
                print("quantity ++");
                element.quantity += quantity;
                Get.snackbar(
                  '',
                  '',
                  messageText: Text(
                    S.of(Get.context).itemAdded,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  titleText: Text(
                    S.of(Get.context).cartUpdated,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  icon: Icon(Icons.add_shopping_cart_outlined),
                  backgroundColor: Colors.cyan,
                  backgroundGradient:
                      LinearGradient(colors: [Colors.white, Colors.cyan]),
                  snackStyle: SnackStyle.FLOATING,
                );
              }
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
            unit: unit,
            imageName: imageName,
          ));
          Get.snackbar(
            '',
            '',
            messageText: Text(
              S.of(Get.context).itemAdded,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
              ),
            ),
            titleText: Text(
              S.of(Get.context).cartUpdated,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
              ),
            ),
            icon: Icon(Icons.add_shopping_cart_outlined),
            backgroundColor: Colors.cyan,
            backgroundGradient:
                LinearGradient(colors: [Colors.white, Colors.cyan]),
            snackStyle: SnackStyle.FLOATING,
          );
          print("AAAAAA ${cartList.length}");
        }
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        S.of(Get.context).errorOcu,
        "",
        backgroundColor: Colors.black.withOpacity(0.8),
        maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
        colorText: Colors.white,
      );
    }
  }

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

  Future<void> orderPlaced({
    price,
    String customerName,
    String size,
    String unit,
    String pincode,
    String customerAddress,
    String customerMobile,
    String customerShopName,
    String customerShopType,
  }) async {
    var details = [];
    try {
      isLoading.value = true;
      for (var i = 0; i < cartList.length; i++) {
        purchaseCount.value += cartList[i].quantity;
        prodReport(cartList[i].title, 1);
        details.add({
          'name': cartList[i].title,
          'price': cartList[i].price,
          'quantity': cartList[i].quantity,
          'id': cartList[i].id,
          'size': cartList[i].size,
          'unit': cartList[i].unit,
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
        ..set('pincode', pincode)
        ..set('customerName', customerName)
        ..set('customerAddress', customerAddress)
        ..set('customerContactNo', customerMobile)
        ..set('customerShopName', customerShopName)
        ..set('customerShopType', customerShopType)
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
          S.of(Get.context).orderSuccess,
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
        S.of(Get.context).errorOcu,
        "",
        backgroundColor: Colors.black.withOpacity(0.8),
        maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
        colorText: Colors.white,
      );
    } finally {
      print('orderPlaced finally');
    }
  }

  Future<void> prodReport(String name, int prodCount) async {
    print("called ad report");
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('ProductsMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('prodName', name);

      ParseResponse response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print("no pro exist creating new one");
          ParseObject newClient = ParseObject('ProductsMetadata')
            ..set<String>('prodName', name)
            ..set('prodPurchaseCount', prodCount);

          ParseResponse reportResult = await newClient.create();
          if (reportResult.success) {
            print('new prod created');
            //prodCount = 0;
            //rCtrl.setOrdersMetadataObjectId(reportResult.result['objectId']);
            //print(reportResult.result['objectId']);
            //rCtrl.loadObjId();
            //SharedPreferences preference =
            //  await SharedPreferences.getInstance();
            // print("@@@${preference.getString(rCtrl.kOrderObjectId)}");
          }
        } else {
          print("prod already there updating purchaseCount");
          ParseObject client = response.result[0]
            ..set('prodName', name)
            ..set('prodPurchaseCount',
                response.result[0]['prodPurchaseCount'] + 1);

          ParseResponse reportResult = await client.save();
          if (reportResult.success) {
            // adsCount = 0;
            print("prod Count updated and report made");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool checkProductContains(String productId, String size, String unit) {
    var indexOfProduct = cartList.indexWhere((element) =>
        element.id == productId &&
        element.size == size &&
        element.unit == unit);

    return indexOfProduct != -1;
  }
}
