import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/controller/sales_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/view/order/salesperson_client_history.dart';

class DisplayClient extends StatefulWidget {
  @override
  _DisplayClientState createState() => _DisplayClientState();
}

class _DisplayClientState extends State<DisplayClient> {
  @override
  ClientController cCtrl = Get.put(ClientController());

  SupportController ctrl = Get.put(SupportController());

  SalesController sCtrl = Get.put(SalesController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          S.of(context).clientReg,
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ParseLiveListWidget(
            query: cCtrl.showClients(),
            lazyLoading: true,
            scrollPhysics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: 8,
              bottom: 10,
            ),
            childBuilder: (context, snapshot) {
              if (snapshot.failed) {
                return Text(S.of(context).warning);
              } else if (snapshot.hasData) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black54,
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).clientNo}  ${snapshot.loadedData.get('number')}' ??
                              '-',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${S.of(context).clientShopN}  ${snapshot.loadedData.get('shopName')}' ??
                              '-',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      '${S.of(context).clientN}  ${snapshot.loadedData.get('name')}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: ElevatedButton(
                      child: Text(
                        S.of(context).hist,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      onPressed: () {
                        sCtrl.displayROrderHistoryData(
                            snapshot.loadedData.get('number'));
                        Get.to(SalespersonClient(
                          number: snapshot.loadedData.get('number'),
                        ));
                      },
                    ),
                  ),
                );
              } else {
                return ListTileShimmer();
              }
            }),
      ),
    );
  }
}
