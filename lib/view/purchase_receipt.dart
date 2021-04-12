import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/view/home/home_screen_client.dart';

import '../controller/cart_controller.dart';

class PurchaseReceipt extends StatefulWidget {
  final ParseObject order;
  PurchaseReceipt(this.order);

  @override
  _PurchaseReceiptState createState() => _PurchaseReceiptState();
}

// QueryBuilder<ParseObject> order =
// QueryBuilder<ParseObject>(ParseObject('Orders')).whereMat(column, value);
class _PurchaseReceiptState extends State<PurchaseReceipt> {
  List products;
  CartController cltrCart = Get.put(CartController());
  ProductsController cltrProduct = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    print(widget.order);
    cltrCart.orderDetails(widget.order['order_details']);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            /* cltrCart.subTotal.value = 0;
            cartItems.clear();*/
            cartItems.clear();
            cltrCart.quantity.value = 0;
            Get.off(HomeScreenClient());
            //Get.back();
          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          S.of(context).Receipt,
          style:
              GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 100, 244, 1),
                ),
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 17, right: 17, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(90, 177, 255, 0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).PurchaseReceipt,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        S.of(context).ReceiptMessage,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              children: [
                                TextSpan(text: S.of(context).OrderId),
                                TextSpan(
                                  text: '${widget.order.objectId}',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            DateFormat('d MMMM y')
                                .format(widget.order.get('date_time')),
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).TotalOrder,
                            style: TextStyle(fontSize: 20),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: TextStyle(
                                // color: AppColors.k5e5e5e,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                    text: '₹ ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                TextSpan(
                                  text: '${widget.order.get('total_price')}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: cltrCart.orderDetails.length,
                  itemBuilder: (BuildContext context, index) {
                    cltrCart.subTotal.value = widget.order.get('total_price') -
                        cltrCart.delivery.value;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${cltrCart.orderDetails[index]['quantity'] ?? "-"} x ',
                          style: TextStyle(color: Colors.black),
                        ),
                        radius: 20,
                        backgroundColor: Color.fromRGBO(90, 177, 255, 0.1),
                      ),
                      subtitle: Text(S.of(context).Size +
                              " ${cltrCart.orderDetails[index]['size']}" ??
                          "size"),
                      title:
                          Text(cltrCart.orderDetails[index]['name'] ?? "name"),
                      trailing: Text(
                          '₹ ${cltrCart.orderDetails[index]['quantity'] * cltrCart.orderDetails[index]['price']}'),
                    );
                  },
                ),
                Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).subT,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '₹ ${cltrCart.totalA}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).fees,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '₹ ${cltrCart.delivery}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).orderTotal,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                          Text(
                            '₹ ${cltrCart.totalA + cltrCart.delivery.value}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
