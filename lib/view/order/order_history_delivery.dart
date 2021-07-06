import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OrderHistoryDelivery extends StatefulWidget {
  // int index;
  var listObject;
  OrderHistoryDelivery({Key key, this.listObject}) : super(key: key);

  @override
  _OrderHistoryDeliveryState createState() => _OrderHistoryDeliveryState();
}

class _OrderHistoryDeliveryState extends State<OrderHistoryDelivery> {
  OrderAssignController assignCtrl = Get.put(OrderAssignController());
  SignInController ctrl = Get.put(SignInController());
  RepoController rCtrl = Get.put(RepoController());
  @override
  @override
  _OrderHistoryDeliveryState createState() => _OrderHistoryDeliveryState();

  @override
  Widget build(BuildContext context) {
    //ClientController clientCon = Get.put(ClientController());

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            S.of(context).hist,
          ),
        ),
        body: Obx(
          () => assignCtrl.showDelivered.value
              ? buildLoader()
              : ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Card(
                      elevation: 5,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                          onTap: () {
                            // bottomNavigationIndex.value = 0;
                          },
                          leading: Icon(Icons.done),
                          title: Text(S.of(context).del),
                          trailing: GestureDetector(
                              child: CircleAvatar(
                            radius: 15,
                            child:
                                Text(widget.listObject.length.toString() ?? 10),
                          )
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
                      S.of(context).hist,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    /*assignCtrl.noOrderDelivered.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 150),
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
                                        S.of(context).message,
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
                              ],
                            ),
                          )
                        :*/
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(4),
                      itemCount: widget.listObject.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade200,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yy hh:mm').format(
                                              widget.listObject[index]
                                                  ['date_time']) ??
                                          '-',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).OrderId,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                          widget.listObject[index]['objectId']
                                                  .toUpperCase() ??
                                              '-',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).price,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                          widget.listObject[index]
                                                      ['total_price']
                                                  .toString() ??
                                              '-',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).payment,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                          widget.listObject[index]
                                                  ['payment_option'] ??
                                              '-',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
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
                                    //
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
                                    //
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).customerN,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                          widget.listObject[index]
                                                  ['customerName'] ??
                                              '-',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).customerAdd,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            widget.listObject[index]
                                                    ['customerAddress'] ??
                                                '-',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            textAlign: TextAlign.end,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S.of(context).contact,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            )),
                                        Text(
                                          widget.listObject[index]
                                                  ['customerContactNo'] ??
                                              ' -',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
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
