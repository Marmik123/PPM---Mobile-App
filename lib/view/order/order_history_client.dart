import 'package:flutter/material.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/view/order/order_placed.dart';
import 'package:pcm/view/order/order_received.dart';
import 'package:pcm/widgets/circular_loader.dart';

import 'order_received.dart';
// import 'package:pcm/widgets/orders.dart';

// ignore: must_be_immutable
class OrderHistoryClient extends StatefulWidget {
  String number;

  OrderHistoryClient({Key key, this.number}) : super(key: key);
  @override
  _OrderHistoryClientState createState() => _OrderHistoryClientState();
}

class _OrderHistoryClientState extends State<OrderHistoryClient> {
  CartController cltrCart = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          S.of(context).hist,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: Obx(
            () => cltrCart.orderH.value
                ? buildLoader()
                : Column(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => OrderReceived(
                                  mobileNo: widget.number,
                                ));
                            // return showModal<void>(
                            //   context: context,
                            //   builder: (context) {
                            //     return OrderPlaced();
                            //   },
                            // );
                            // bottomNavigationIndex.value = 0;
                          },
                          leading: Icon(Icons.receipt_long_outlined),
                          title:
                              Text(S.of(context).oRec /*S.of(context).jobs*/),
                          trailing: GestureDetector(
                            child: CircleAvatar(
                              radius: 15,
                              child: Text(cltrCart.rOrders.value.toString()),
                            ),
                            // onTap: () {
                            //   clientCon.role.value = false;
                            //
                            //   Get.to(ClientRegister());
                            //   // Navigator.of(context)
                            //   //     .pushNamed(CreateReception.routeName);
                            // },
                          ),
                        ),
                      ),
                      // Card(
                      //   child: ListTile(
                      //       onTap: () {
                      //         print('on tap listTile');
                      //         Get.to(() => OrderPlaced(
                      //               mobile: widget.number,
                      //             ));
                      //         // return showModal<void>(
                      //         //   context: context,
                      //         //   builder: (context) {
                      //         //     return OrderPlaced();
                      //         //   },
                      //         // );
                      //       },
                      //       leading: Icon(Icons.receipt_long_outlined),
                      //       title: Text(S.of(context).placed),
                      //       trailing: GestureDetector(
                      //           child: CircleAvatar(
                      //         radius: 15,
                      //         child: Text(cltrCart.pOrders.value.toString()),
                      //       ))),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      OrderPlaced(
                        mobile: widget.number,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
