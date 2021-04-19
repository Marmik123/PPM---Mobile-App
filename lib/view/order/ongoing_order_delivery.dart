import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/widgets/circular_loader.dart';

class OngoingOrderDelivery extends StatefulWidget {
  int index;
  var updateFunc;
  var listObject;
  OngoingOrderDelivery({Key key, this.index, this.listObject, this.updateFunc})
      : super(key: key);

  @override
  _OngoingOrderDeliveryState createState() => _OngoingOrderDeliveryState();
}

class _OngoingOrderDeliveryState extends State<OngoingOrderDelivery> {
  @override
  Widget build(BuildContext context) {
    print(widget.listObject);
    OrderAssignController assignCtrl = Get.put(OrderAssignController());
    SignInController phoneCtrl = Get.put(SignInController());
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Obx(() => assignCtrl.isLoading.value
            ? buildLoader()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(90, 177, 255, 0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.listObject.get('date_time').toString() ?? "-",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          S.of(context).Ongoing,
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
                            Text(S.of(context).delId,
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
                              widget.listObject.get('objectId') ?? "-",
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
                            Text(S.of(context).price,
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
                              widget.listObject.get('total_price').toString() ??
                                  "-",
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
                            Text(S.of(context).payment,
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
                              widget.listObject.get('payment_option') ?? "-",
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
                            Text(S.of(context).customerN,
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
                              widget.listObject.get('customerName') ?? '-',
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
                            Text(S.of(context).customerAdd,
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
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.topRight,
                              child: Text(
                                widget.listObject.get('customerAddress') ?? '-',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).contact,
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
                              widget.listObject.get('customerContactNo') ?? "-",
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
                  assignCtrl.isLoadingButton == widget.index + 1
                      ? buildLoader()
                      : ElevatedButton(
                          child: Text(
                            S.of(context).Delivered,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(25),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                          ),
                          onPressed: () {
                            setState(() {
                              assignCtrl.isLoadingButton = widget.index + 1;
                            });
                            widget.updateFunc;
                            assignCtrl.pressedButtonIndex.value =
                                widget.index + 1;
                            assignCtrl.setDeliveryStatus(
                              widget.listObject,
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
                ],
              )));
  }
}
