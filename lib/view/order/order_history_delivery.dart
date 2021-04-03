import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';

// ignore: must_be_immutable
class OrderHistoryDelivery extends StatelessWidget {
  // int index;
  ClientController clientCon = Get.put(ClientController());
  OrderAssignController assignCtrl = Get.put(OrderAssignController());

  //OrderHistoryDelivery({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 1,
          titleSpacing: 0,
          title: Text(
            'Order History',
          ),
        ),
        body: Obx(
          () => ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Card(
                child: ListTile(
                    onTap: () {
                      // bottomNavigationIndex.value = 0;
                    },
                    // leading: Icon(Icons.done),
                    title: Text('Order Delivered' /*S.of(context).jobs*/),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text('Add'),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text(
                              assignCtrl.deliveredOrders.length.toString() ??
                                  "0"),
                        ),
                      ),
                      // onTap: () {
                      //   clientCon.role.value = false;
                      //
                      //   Get.to(ClientRegister());
                      //   // Navigator.of(context)
                      //   //     .pushNamed(CreateReception.routeName);
                      // },
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Order History',
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              assignCtrl.noOrderDelivered.value
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 150),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.cyan,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "No Order Delivered Till Now",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Get back to work",
                            style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: assignCtrl.deliveredOrders.length ?? 0,
                      itemBuilder: (context, index) {
                        return assignCtrl.deliveredOrders.length == 0
                            ? Container()
                            : Container(
                                child: Column(
                                  children: [
                                    // Card(
                                    //   child: ListTile(
                                    //       onTap: () {
                                    //         // bottomNavigationIndex.value = 0;
                                    //       },
                                    //       leading: Icon(Icons.handyman),
                                    //       title: Text('Distributors Registered' /*S.of(context).jobs*/),
                                    //       trailing: GestureDetector(
                                    //         child: Chip(
                                    //           label: Text('Add'),
                                    //           // Text(S.of(context).add),
                                    //           avatar: CircleAvatar(
                                    //             child: Text('1'),
                                    //           ),
                                    //         ),
                                    //         onTap: () {
                                    //           clientCon.role.value = true;
                                    //
                                    //           Get.to(ClientRegister());
                                    //           // Navigator.of(context)
                                    //           //     .pushNamed(CreateReception.routeName);
                                    //         },
                                    //       )),
                                    // ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 20,
                                                        right: 20),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          90, 177, 255, 0.1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          assignCtrl
                                                              .deliveredOrders[
                                                                  index]
                                                                  ['date_time']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        // Text(
                                                        //   '28 Mins',
                                                        //   style: GoogleFonts.montserrat(
                                                        //       fontSize: 12, fontWeight: FontWeight.w500),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Delivery Id',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                    94,
                                                                    94,
                                                                    94,
                                                                    1,
                                                                  ),
                                                                )),
                                                            Text(
                                                              assignCtrl.deliveredOrders[
                                                                      index]
                                                                  ['objectId'],
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Total Price',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                    94,
                                                                    94,
                                                                    94,
                                                                    1,
                                                                  ),
                                                                )),
                                                            Text(
                                                              assignCtrl
                                                                  .deliveredOrders[
                                                                      index][
                                                                      'total_price']
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Payment option',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                    94,
                                                                    94,
                                                                    94,
                                                                    1,
                                                                  ),
                                                                )),
                                                            Text(
                                                              assignCtrl.deliveredOrders[
                                                                      index][
                                                                  'payment_option'],
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //   children: [
                                                        //     Text('tranlator',
                                                        //         style: GoogleFonts.montserrat(
                                                        //           fontSize: 14,
                                                        //           fontWeight: FontWeight.w300,
                                                        //           color: Color.fromRGBO(
                                                        //             94,
                                                        //             94,
                                                        //             94,
                                                        //             1,
                                                        //           ),
                                                        //         )),
                                                        //     Text(
                                                        //       'Seth Caldwell',
                                                        //       style: GoogleFonts.montserrat(
                                                        //         fontSize: 14,
                                                        //         fontWeight: FontWeight.w500,
                                                        //         color: Colors.black,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        // Row(
                                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //   children: [
                                                        //     Text('doctor',
                                                        //         style: GoogleFonts.montserrat(
                                                        //           fontSize: 14,
                                                        //           fontWeight: FontWeight.w300,
                                                        //           color: Color.fromRGBO(
                                                        //             94,
                                                        //             94,
                                                        //             94,
                                                        //             1,
                                                        //           ),
                                                        //         )),
                                                        //     Text(
                                                        //       'Chad Murray',
                                                        //       style: GoogleFonts.montserrat(
                                                        //         fontSize: 14,
                                                        //         fontWeight: FontWeight.w500,
                                                        //         color: Colors.black,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('location',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                    94,
                                                                    94,
                                                                    94,
                                                                    1,
                                                                  ),
                                                                )),
                                                            Text(
                                                              'Melbourne',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Expanded(
                                    //   child: GridView(
                                    //     primary: false,
                                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    //         crossAxisCount: 2),
                                    //     children: [
                                    //       // dashboardContainer(name: 'Register'),
                                    //
                                    //       dashboardContainer(
                                    //         name: 'Settings',
                                    //         onTap: () => Get.to(SettingsPage()),
                                    //       ),
                                    //       dashboardContainer(
                                    //         name: 'FeedBack',
                                    //         onTap: () => Get.to(FeedbackPage()),
                                    //       ),
                                    //       dashboardContainer(
                                    //         name: 'Support',
                                    //         onTap: () => Get.to(Support()),
                                    //       ),
                                    //       dashboardContainer(
                                    //         name: 'Client',
                                    //         onTap: () => Get.to(HomeScreenClient()),
                                    //       ),
                                    //       // dashboardContainer(
                                    //       //   name: 'Delivery Boy',
                                    //       //   onTap: () => Get.to(HomeScreenDelivery()),
                                    //       // ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                              );
                      },
                    ),
              /* dashboardContainer(
            name: 'Distributor',
            icon: Icons.domain,
            onTap: () => Get.to(HomeScreenDistributor()),
          ),*/
            ],
          ),
        ));
  }
}
