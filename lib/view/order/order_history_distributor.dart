import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:pcm/widgets/orders.dart';

// ignore: must_be_immutable
class OrderHistoryDistributor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          'Order History',
          style:
              GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: ListTile(
                    onTap: () {
                      // bottomNavigationIndex.value = 0;
                    },
                    leading: Icon(Icons.handyman),
                    title: Text('Order Received' /*S.of(context).jobs*/),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text('Add'),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text('1'),
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
              Card(
                child: ListTile(
                    onTap: () {
                      print('on tap listTile');
                      OpenContainer(
                        transitionType: ContainerTransitionType.fadeThrough,
                        closedBuilder: (context, action) {
                          return Text('main');
                        },
                        openBuilder: (context, action) {
                          print('on taped order placed');
                          return Orders();
                        },
                      );
                    },
                    leading: Icon(Icons.handyman),
                    title: Text('Order Placed' /*S.of(context).jobs*/),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text('Add'),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text('1'),
                        ),
                      ),
                      onTap: () {},
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Text(
                      'Order History',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('Product Name'),
                            subtitle: Text('quantity * price'),
                            trailing: Container(
                              height: 50,
                              width: 50,
                              color: Colors.blueGrey,
                            ),
                          ),
                        );
                      },
                    ),
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
        ),
      ),
    );
  }
}
