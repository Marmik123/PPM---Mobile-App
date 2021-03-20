import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',

        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
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
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Order Id:'), Text('00000013')],
                  ),
                  subtitle: Text('Date: 16/03/2021'),
                  // trailing: Container(
                  //   height: 50,
                  //   width: 50,
                  //   color: Colors.blueGrey,
                  // ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.end,
                  childrenPadding:
                      EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Product Name'),
                              Text(
                                'quantity X price',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Text('Total : 1000'),
                    SizedBox(
                      height: 5,
                    )
                  ],
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
    );
  }
}
