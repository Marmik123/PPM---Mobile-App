import 'package:flutter/material.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/sales_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/view/order/salesperson_client_phistory.dart';
import 'package:pcm/view/order/salesperson_client_rohistory.dart';
import 'package:pcm/widgets/circular_loader.dart';
// import 'package:pcm/widgets/orders.dart';

// ignore: must_be_immutable
class SalespersonClient extends StatefulWidget {
  String number;

  SalespersonClient({Key key, this.number}) : super(key: key);
  @override
  _SalespersonClientState createState() => _SalespersonClientState();
}

class _SalespersonClientState extends State<SalespersonClient> {
  CartController cltrCart = Get.put(CartController());
  SalesController sCtrl = Get.put(SalesController());
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
                              Get.to(() => ReceivedClient(
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
                              child: Text(sCtrl.rOrders.value.toString()),
                            ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PlacedClient(
                        mobile: widget.number,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //sCtrl.displayROrderHistoryData(widget.number);
  }
}
