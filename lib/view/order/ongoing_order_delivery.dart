import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OngoingOrderDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
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
                  DateTime.now().toString(),
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
                      '0000023',
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
                    Text('customerName',
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
                      'Seth Caldwell',
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
                    Text('CustomerNumber',
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
                      '9874563210',
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
                    Text('location',
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
                      'Melbourne',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedLoadingButton(
                color: Colors.cyan,
                child: Text(
                  'Delivered',
                  style: TextStyle(color: Colors.white),
                ),
                borderRadius: 10,
                height: 40,
                width: 100,
                // controller: _btnSubmit,
                onPressed: () {},
                // () => _passKey.currentState.validate()
                // ? _submit()
                // : Scaffold.of(context).showSnackBar(
                // SnackBar(content: Text(S.of(context).passFail))),
              ),
              RoundedLoadingButton(
                color: Colors.cyan,
                child: Text(
                  'Cash Collected',
                  style: TextStyle(color: Colors.white),
                ),
                borderRadius: 10,
                height: 40,
                width: 100,
                // controller: _btnSubmit,
                onPressed: () {},
                // () => _passKey.currentState.validate()
                // ? _submit()
                // : Scaffold.of(context).showSnackBar(
                // SnackBar(content: Text(S.of(context).passFail))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
