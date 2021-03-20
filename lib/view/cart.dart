import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/view/purchase_receipt.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  RxInt value_1 = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'My Cart',
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Deliver to ------------------'),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Change',
                    style: TextStyle(
                        color: Colors.blue,
                        textBaseline: TextBaseline.ideographic),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                // padding: EdgeInsets.fromLTRB(12, 12, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        0,
                        4,
                      ),
                      blurRadius: 15,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage('https://picsum.photos/id/1/200/300'),
                      ),
                    ),
                  ),
                  title: Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       if (quentity > 1) {
                      //         quentity--;
                      //       }
                      //     });
                      //   },
                      //   child: buttonContainer(
                      //     Image.asset(quentity <= 1
                      //         ? "assets/images/btn_medicine_quantity_minus_disabled.png"
                      //         : 'assets/images/btn_medicine_quantity_minus.png'),
                      //   ),
                      // ),
                      IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 14,
                          ),
                          onPressed: () {}),

                      Text(
                        '1',
                        style: TextStyle(
                          color: Color(0xff010101),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                        iconSize: 14,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       quentity++;
                      //     });
                      //   },
                      //   child: buttonContainer(
                      //     Image.asset(
                      //         "assets/images/btn_medicine_quantity_add.png"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         top: 8,
                //       ),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.max,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // Image(
                //           //   height: 70,
                //           //   width: 70,
                //           //   image: AssetImage('assets/images/panadol.png'),
                //           // ),
                //           Container(
                //             height: 70,
                //             width: 70,
                //             child: ClipRRect(
                //               child: Image(
                //                 fit: BoxFit.cover,
                //                 image: NetworkImage(
                //                     'https://picsum.photos/id/1/200/300'),
                //               ),
                //             ),
                //           ),
                //           Expanded(
                //             child: Padding(
                //               padding: const EdgeInsets.only(
                //                 left: 15,
                //                 right: 16,
                //               ),
                //               child: Column(
                //                 mainAxisSize: MainAxisSize.max,
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                       bottom: 14,
                //                     ),
                //                     child: Text('Product Name',
                //                         style: TextStyle(
                //                           fontSize: 14,
                //                           fontWeight: FontWeight.w500,
                //                         )),
                //                   ),
                //                   /*SizedBox(
                //                             height: 18,
                //                           ),*/
                //                   Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Container(
                //                         decoration: BoxDecoration(
                //                           borderRadius:
                //                               BorderRadius.circular(4),
                //                         ),
                //                         child: Padding(
                //                           padding: const EdgeInsets.only(
                //                             left: 7,
                //                             right: 7,
                //                             top: 3,
                //                             bottom: 2,
                //                           ),
                //                           child: Row(
                //                             mainAxisSize: MainAxisSize.min,
                //                             children: [
                //                               Text(
                //                                 'Price',
                //                                 style: TextStyle(
                //                                   fontSize: 16,
                //                                 ),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                       ),

                //                     ],
                //                   )
                //                 ],
                //               ),
                //             ),
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Payment Option',
                  style: TextStyle(
                    // color: AppColors.k010101,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      autofocus: true,
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {
                        // setState(() {
                        // value_1.value = value;
                        // });
                      },
                      activeColor: Colors.cyan,
                      toggleable: true,
                    ),
                    Text(
                      'Cash on Delivery',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(12, 12, 16, 16),
            child: Column(
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(
                    // color: AppColors.k010101,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: TextStyle(
                        // color: AppColors.k010101,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "₹ 20.0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Fees',
                      style: TextStyle(
                        // color: AppColors.k010101,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "₹ 20.0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Image(
                //       image: AssetImage(
                //           "assets/images/ic_cart_checkbox_normal.png"),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         left: 1,
                //       ),
                //       child: RichText(
                //         textAlign: TextAlign.center,
                //         text: TextSpan(
                //           style: TextStyle(
                //             color: AppColors.k5e5e5e,
                //             fontSize: 12,
                //           ),
                //           children: [
                //             TextSpan(text: S.of(context).bySubmit),
                //             TextSpan(
                //               text: S.of(context).tandc,
                //               recognizer: TapGestureRecognizer()
                //                 ..onTap = () {
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) => TermsConditions(),
                //                     ),
                //                   );
                //                 },
                //               style: TextStyle(
                //                 // color: AppColors.k0cbcc5,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(12, 12, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'OrderTotal',
                  style: TextStyle(
                    // color: AppColors.k010101,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "  ₹ 20.0",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan)),
              child: Text(
                'Place Order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Get.to(() => PurchaseReceipt());
              },
            ),
          ],
        ),
      ),
    );
  }
}
