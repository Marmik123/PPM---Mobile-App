import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    print(widget.order);
    products = widget.order.get('order_details');
    print(products.toString());
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          'Receipt',
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
                            'Purchase Receipt',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        'Receipt Message',
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
                                TextSpan(text: 'OrderId: '),
                                TextSpan(
                                  text: '${widget.order.objectId}',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy')
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
                            'Total Order',
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
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.black),
                      ),
                      radius: 15,
                      backgroundColor: Color.fromRGBO(90, 177, 255, 0.1),
                    ),
                    title: Text('Product Name'),
                    trailing: Text('₹ 20.0'),
                  ),
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
                            'Sub Total',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '₹ 40.0',
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
                            'Delivery Fees',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '₹ 9.0',
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
                          Text('Order Total',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                          Text(
                            '₹ 49.0',
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
          )
        ],
      ),
    );
  }
}
