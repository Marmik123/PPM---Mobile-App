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
import 'package:pcm/controller/sales_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlacedClient extends StatefulWidget {
  String mobile;

  PlacedClient({Key key, this.mobile}) : super(key: key);
  @override
  _PlacedClientState createState() => _PlacedClientState();
}

class _PlacedClientState extends State<PlacedClient> {
  CartController cltrCart = Get.put(CartController());
  SignInController phoneCtrl = Get.put(SignInController());
  SalesController sCtrl = Get.put(SalesController());
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreferenceF();
  }

  void sharedPreferenceF() async {
    prefs = await SharedPreferences.getInstance();
    //widget.number = mobile.getString(rCtrl.kMobile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          query: sCtrl.displayOrderHistory(widget.mobile),
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
            print(snapshot.hasData);
            if (snapshot.failed) {
              return Text(S.of(context).error);
            } else if (snapshot.hasData) {
              return Card(
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).OrderId),
                      Text(
                          snapshot.loadedData.get('objectId').toString() ?? "-")
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
                  childrenPadding:
                      EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      shrinkWrap: true,
                      itemCount:
                          snapshot.loadedData.get('order_details').length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.loadedData
                                      .get('order_details')[index]['name'] ??
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
            } else {
              return ProfileShimmer();
            }
          },
        ),
      ],
    );
  }
}
