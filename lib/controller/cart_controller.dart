import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/model/cart_item.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/view/purchase_receipt.dart';

class CartController extends GetxController {
  RxDouble delivery = 20.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxList orderDetails = [].obs;

  int get itemCount {
    return cartItems == null ? 0 : cartItems.length;
  }

  double get totalA {
    var total = 0.0;
    cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    String title,
    double price,
    int quantity,
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
              ));
    }
    print('product added to the cart');
  }

  void removeItem(String productId) {
    cartItems.remove(productId);
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
              price: i.price));
    } else {
      cartItems.remove(prodId);
    }
  }

  // void clear() {
  //   cartItems = {};
  // }

  Future<void> orderPlaced({
    price,
  }) async {
    var details = [];
    for (var i = 0; i < cartItems.length; i++) {
      details.add({
        'name': cartItems.values.toList()[i].title,
        'price': cartItems.values.toList()[i].price,
        'quantity': cartItems.values.toList()[i].quantity,
        'id': cartItems.values.toList()[i].id,
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
      ..set('payment_option', 'COD')
      ..set('total_price', price)
      ..set('delivery_fees', '');

    ParseResponse response = await orderData.create();
    var objectId;
    if (response.success) {
      print(response.result.get('objectId'));
      objectId = response.result.get('objectId');
      print('successful!!!!!!!!!!');

      // ParseResponse result=await order.query();
      Get.to(() => PurchaseReceipt(orderData));
    }
    try {} catch (e) {
      print('error in orderPlaced $e');
    }
  }
}
