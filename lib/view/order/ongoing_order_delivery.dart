import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/widgets/circular_loader.dart';

class OngoingOrderDelivery extends StatelessWidget {
  OrderAssignController assignCtrl = Get.put(OrderAssignController());

  int index;

  OngoingOrderDelivery({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: /*Obx(
          () =>*/
          Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(90, 177, 255, 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  assignCtrl.orderList[index]['date_time'].toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Ongoing',
                  style: GoogleFonts.montserrat(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DeliveryId',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['objectId'],
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['total_price'].toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment option',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['payment_option'],
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Customer Name' ?? '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['customerName'] ?? '-',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Customer Address',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['customerAddress'] ?? '-',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Customer Contact No.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(
                            94,
                            94,
                            94,
                            1,
                          ),
                        )),
                    Text(
                      assignCtrl.orderList[index]['customerContactNo'] ?? "-",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => assignCtrl.pressedButtonIndex.value != 0
                  ? buildLoader()
                  : ElevatedButton(
                      child: Text(
                        'Delivered',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(25),
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                      ),
                      onPressed: () {
                        assignCtrl.pressedButtonIndex.value = index + 1;
                        assignCtrl.setDeliveryStatus(
                          assignCtrl.orderList[index],
                          "yes",
                        );
                      },
                    )
/*
          RoundedLoadingButton(
            color: Colors.cyan,
            child: Text(
              'Delivered',
              style: TextStyle(color: Colors.white),
            ),
            borderRadius: 10,
            height: 40,
            width: 100,
            controller: assignCtrl.ctrl,

            // () => _passKey.currentState.validate()
            // ? _submit()
            // : Scaffold.of(context).showSnackBar(
            // SnackBar(content: Text(S.of(context).passFail))),
          )
*/
              ),
        ],
      ),
    );
  }
}
