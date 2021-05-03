import 'package:flutter/material.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/homescreen_client_controller.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cart extends StatefulWidget {
  final ParseObject product;
  const Cart({Key key, this.product}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cltrCart = Get.put(CartController());
  ProductsController cltrProduct = Get.put(ProductsController());
  HomeScreenClientController client = Get.put(HomeScreenClientController());
  RepoController rCtrl = Get.put(RepoController());

  RxInt radio = 1.obs;
  RxInt value_1 = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: S.of(context).cart,
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              /* cltrCart.subTotal.value = 0;
            cartItems.clear();*/
              Get.defaultDialog(
                  content: Text(""),
                  radius: 5,
                  titleStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  title: S.of(context).cartM,
                  confirm: ElevatedButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan)),
                      onPressed: () {
                        setState(() {
                          cartItems.clear();
                          cartList.clear();
                          cltrCart.quantity.value = 0;

                          Get.back();
                        });
                      },
                      child: Text(S.of(context).Yes)),
                  cancel: ElevatedButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan)),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(S.of(context).No)));
            },
          )
        ],
        title: Text(
          S.of(context).my,
        ),
      ),
      body: cltrCart.isLoading.value
          ? buildLoader()
          : ListView(
              shrinkWrap: true,
              children: [
/*                Container(
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).delTo),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          S.of(context).change,
                          style: TextStyle(
                              color: Colors.blue,
                              textBaseline: TextBaseline.ideographic),
                        ),
                      ),
                    ],
                  ),
                )*/
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: cltrCart.itemCount,
                    itemBuilder: (context, index) {
                      cltrCart.quantity.value = cartList[index].quantity;

                      return cltrCart.quantity.value == 0
                          ? Container()
                          : Container(
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
                                      image: NetworkImage(
                                          'https://picsum.photos/id/1/200/300'),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  cartList[index].title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).priceT +
                                            "${cartList[index].price}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        S.of(context).Size +
                                            '${cartList[index].size}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          size: 12,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (cartList[index].quantity != 0) {
                                              cltrProduct.quantity.value--;
                                              cltrCart.quantity.value--;
                                              cartList[index].quantity--;
                                            } else if (cltrCart.quantity.value <
                                                1) {
                                              cltrCart.removeItem(
                                                  cartList[index].id);
                                            }
                                            if (cartItems.isEmpty) {
                                              setState(() {});
                                            }
                                          });

                                          // } else if (quantity.value < 1) {
                                          //   cltrCart.removeItem(cltrCart.cartItem.values
                                          //       .toList()[index]
                                          //       .id);
                                          // }
                                        }),

                                    Text(
                                      '${cartList[index].quantity} ${cartList[index].unit}',
                                      style: TextStyle(
                                        color: Color(0xff010101),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          cartList[index].quantity++;
                                          cltrProduct.quantity.value++;
                                          /*cltrCart.addItem(
                                        cartList[index.id,
                                        cartItems.values.toList()[index].title,
                                        cartItems.values.toList()[index].price,
                                        cartItems.values
                                            .toList()[index]
                                            .quantity);*/
                                          cltrCart.quantity.value++;
                                        });
                                      },
                                      iconSize: 12,
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
                            );
                    },
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
                        S.of(context).payment,
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
                            groupValue: radio.value,
                            onChanged: (value) {
                              setState(() {
                                cltrCart.payment_option.value = "COD";
                                radio.value = value;
                              });
                            },
                            activeColor: Colors.cyan,
                            toggleable: false,
                          ),
                          Text(
                            S.of(context).cod,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            autofocus: true,
                            value: 2,
                            groupValue: radio.value,
                            onChanged: (value) {
                              setState(() {
                                radio.value = value;
                              });
                            },
                            activeColor: Colors.cyan,
                            toggleable: false,
                          ),
                          Text(
                            S.of(context).onlineP,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      radio.value == 2
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 10),
                              child: Container(
                                height: 150,
                                width: 250,
                                decoration: BoxDecoration(
                                  /* boxShadow: [
                              BoxShadow(
                                  color: Colors.white70,
                                  spreadRadius: 10,
                                  blurRadius: 1)
                            ],*/
                                  gradient: LinearGradient(
                                      colors: [Colors.white70, Colors.cyan]),
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle,
                                  color: Colors.cyan.withOpacity(0.4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          autofocus: true,
                                          value: 1,
                                          groupValue: value_1.value,
                                          onChanged: (value) {
                                            setState(() {
                                              cltrCart.payment_option.value =
                                                  "Credit Card";
                                              value_1.value = value;
                                            });
                                          },
                                          activeColor: Colors.cyan,
                                          toggleable: false,
                                        ),
                                        Text(
                                          S.of(context).cardC,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          autofocus: false,
                                          value: 2,
                                          groupValue: value_1.value,
                                          onChanged: (value) {
                                            setState(() {
                                              cltrCart.payment_option.value =
                                                  "Debit Card";
                                              value_1.value = value;
                                            });
                                          },
                                          activeColor: Colors.cyan,
                                          toggleable: false,
                                        ),
                                        Text(
                                          S.of(context).cardD,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          autofocus: true,
                                          value: 3,
                                          groupValue: value_1.value,
                                          onChanged: (value) {
                                            setState(() {
                                              cltrCart.payment_option.value =
                                                  "UPI";
                                              value_1.value = value;
                                            });
                                          },
                                          activeColor: Colors.cyan,
                                          toggleable: false,
                                        ),
                                        Text(
                                          S.of(context).UPI,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
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
                        S.of(context).summary,
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
                            S.of(context).subT,
                            style: TextStyle(
                              // color: AppColors.k010101,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '₹ ${cltrCart.totalA}',
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
                      /*cltrCart.totalA == 0
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).fees,
                                  style: TextStyle(
                                    // color: AppColors.k010101,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '₹ ${cltrCart.delivery}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),*/
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
                  S.of(context).orderT,
                  style: TextStyle(
                    // color: AppColors.k010101,
                    fontSize: 12,
                  ),
                ),
                cltrCart.totalA == 0
                    ? Text('₹ 0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ))
                    : Obx(() => Text(
                          '₹ ${cltrCart.totalA}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )),
              ],
            ),
            RoundedLoadingButton(
              controller: cltrCart.buttonCtrl,
              borderRadius: 10,
              height: 40,
              width: 100,
              color: Colors.cyan,
              child: Text(
                S.of(context).placeO,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () async {
                SharedPreferences mobile =
                    await SharedPreferences.getInstance();
                setState(() {
                  cltrCart.totalA != 0
                      ? cltrCart.orderPlaced(
                          price: cltrCart.totalA,
                          customerName: mobile.getString(rCtrl.kname),
                          customerAddress: mobile.getString(rCtrl.kAddress),
                          customerMobile: mobile.getString(rCtrl.kMobileNum),
                          size: cltrProduct.size.value,
                          //unit: cltrProduct.unit.value,
                        )
                      : showerror();
                  cltrCart.clientReport(
                      mobile.getString(rCtrl.kname),
                      mobile.getString(rCtrl.kMobileNum),
                      cltrCart.purchaseCount.value);
                });

                //cltrCart.subTotal.value = 0;
              },
            ),
          ],
        ),
      ),
    );
  }

  showerror() {
    Get.snackbar(
      S.of(context).empty,
      S.of(context).addI,
      backgroundColor: Colors.black.withOpacity(0.8),
      maxWidth: MediaQuery.of(Get.context).size.width / 1.5,
      colorText: Colors.white,
    );
    cltrCart.buttonCtrl.error();
  }
}
