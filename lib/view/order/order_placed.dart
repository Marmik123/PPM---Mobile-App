import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  CartController cltrCart = Get.put(CartController());
  SignInController ctrl = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).History,
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            //padding: EdgeInsets.all(15),
            //shrinkWrap: true,
            //physics: ClampingScrollPhysics(),
            children: [
              Text(
                S.of(context).hist,
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ParseLiveListWidget<ParseObject>(
                shrinkWrap: true,
                query: cltrCart
                    .showOrderHistory(ctrl.mobileNo.text.trim().toString()),
                scrollPhysics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                lazyLoading: true,
                /*preloadedColumns: [
                  'objectId',
                  'total_price',
                  'order_details',
                  'date_time'
                ],*/
                listLoadingElement: Center(child: CircularProgressIndicator()),
                childBuilder: (context, snapshot) {
                  if (snapshot.failed) {
                    return Text(S.of(context).error);
                  } else if (snapshot.hasData || snapshot.hasPreLoadedData) {
                    if (snapshot.hasData) {
                      return Card(
                        child: ExpansionTile(
                          expandedAlignment: Alignment.centerRight,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).OrderId),
                              Text(snapshot.loadedData
                                      .get('objectId')
                                      .toString() ??
                                  "-")
                            ],
                          ),
                          subtitle: Text(
                              "${DateFormat('dd/MM/yy').format(snapshot.loadedData.get('date_time'))}"),
                          // trailing: Container(
                          //   height: 50,
                          //   width: 50,
                          //   color: Colors.blueGrey,
                          // ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          childrenPadding: EdgeInsets.only(
                              top: 5, left: 15, right: 15, bottom: 10),
                          children: [
                            ListView.builder(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              shrinkWrap: true,
                              itemCount: snapshot.loadedData
                                  .get('order_details')
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.loadedData
                                                  .get('order_details')[index]
                                              ['name'] ??
                                          "-"),
                                      Text(
                                        '${snapshot.loadedData.get('order_details')[index]['quantity'] ?? "-"} X ${snapshot.loadedData.get('order_details')[index]['price'] ?? "-"}',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(S.of(context).Total +
                                      snapshot.loadedData
                                          .get('total_price')
                                          .toString() ??
                                  "-"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                      // GridView.builder(
                      // shrinkWrap: true,
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2),
                      // itemBuilder: (context, index) {
                      //   return
                      //     Container(
                      //   height: 300,
                      //   child: Card(
                      //     child: Stack(
                      //       fit: StackFit.loose,
                      //       children: [
                      //         Container(
                      //           margin: EdgeInsets.all(5),
                      //           height: MediaQuery.of(context).size.height,
                      //           width: MediaQuery.of(context).size.width,
                      //           color: Colors.cyan,
                      //         ),
                      //         Align(
                      //           alignment: Alignment.bottomCenter,
                      //           child: Container(
                      //             padding: EdgeInsets.only(left: 5),
                      //             margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      //             height: 35,
                      //             color: Colors.red.withOpacity(0.3),
                      //             alignment: Alignment.bottomCenter,
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.max,
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(snapshot.loadedData.get('productName')),
                      //                 IconButton(
                      //                     icon: Icon(Icons.shopping_cart_outlined),
                      //                     onPressed: () {})
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   //   );
                      //   // },
                      // );
                    } else {
                      return ProfileShimmer();
                    }
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
/*          ListView.builder(
                shrinkWrap: true,
                itemCount: cltrCart.orderHistory.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return;
                },
              )*/
              // Container(
              //   child: Column(mainAxisSize: MainAxisSize.min, children: [
              //     Container(
              //       padding: EdgeInsets.only(
              //           top: 10, bottom: 10, left: 20, right: 20),
              //       decoration: BoxDecoration(
              //         color: Color.fromRGBO(90, 177, 255, 0.1),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             DateTime.now().toString(),
              //             style: GoogleFonts.montserrat(
              //                 fontSize: 12, fontWeight: FontWeight.w500),
              //           ),
              //           // Text(
              //           //   '28 Mins',
              //           //   style: GoogleFonts.montserrat(
              //           //       fontSize: 12, fontWeight: FontWeight.w500),
              //           // ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       padding: EdgeInsets.only(
              //         left: 20,
              //         right: 20,
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text('DeliveryId',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w300,
              //                     color: Color.fromRGBO(
              //                       94,
              //                       94,
              //                       94,
              //                       1,
              //                     ),
              //                   )),
              //               Text(
              //                 '0000023',
              //                 style: GoogleFonts.montserrat(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w300,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text('customerName',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w300,
              //                     color: Color.fromRGBO(
              //                       94,
              //                       94,
              //                       94,
              //                       1,
              //                     ),
              //                   )),
              //               Text(
              //                 'Seth Caldwell',
              //                 style: GoogleFonts.montserrat(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text('CustomerNumber',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w300,
              //                     color: Color.fromRGBO(
              //                       94,
              //                       94,
              //                       94,
              //                       1,
              //                     ),
              //                   )),
              //               Text(
              //                 '9874563210',
              //                 style: GoogleFonts.montserrat(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //   children: [
              //           //     Text('tranlator',
              //           //         style: GoogleFonts.montserrat(
              //           //           fontSize: 14,
              //           //           fontWeight: FontWeight.w300,
              //           //           color: Color.fromRGBO(
              //           //             94,
              //           //             94,
              //           //             94,
              //           //             1,
              //           //           ),
              //           //         )),
              //           //     Text(
              //           //       'Seth Caldwell',
              //           //       style: GoogleFonts.montserrat(
              //           //         fontSize: 14,
              //           //         fontWeight: FontWeight.w500,
              //           //         color: Colors.black,
              //           //       ),
              //           //     ),
              //           //   ],
              //           // ),
              //           // SizedBox(
              //           //   height: 10,
              //           // ),
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //   children: [
              //           //     Text('doctor',
              //           //         style: GoogleFonts.montserrat(
              //           //           fontSize: 14,
              //           //           fontWeight: FontWeight.w300,
              //           //           color: Color.fromRGBO(
              //           //             94,
              //           //             94,
              //           //             94,
              //           //             1,
              //           //           ),
              //           //         )),
              //           //     Text(
              //           //       'Chad Murray',
              //           //       style: GoogleFonts.montserrat(
              //           //         fontSize: 14,
              //           //         fontWeight: FontWeight.w500,
              //           //         color: Colors.black,
              //           //       ),
              //           //     ),
              //           //   ],
              //           // ),
              //           // SizedBox(
              //           //   height: 10,
              //           // ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text('location',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w300,
              //                     color: Color.fromRGBO(
              //                       94,
              //                       94,
              //                       94,
              //                       1,
              //                     ),
              //                   )),
              //               Text(
              //                 'Melbourne',
              //                 style: GoogleFonts.montserrat(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
