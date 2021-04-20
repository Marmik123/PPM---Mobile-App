import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/controller/sales_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:pcm/view/common/feedback.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/common/support.dart';
import 'package:pcm/view/order/salesperson_client_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayClient extends StatelessWidget {
  @override
  ClientController cCtrl = Get.put(ClientController());
  RepoController rCtrl = Get.put(RepoController());
  SupportController ctrl = Get.put(SupportController());
  SalesController sCtrl = Get.put(SalesController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: Icon(Icons.home_outlined),
        title: Text(
          "Clients Registered",
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Settings') {
                Get.to(() => SettingsPage());
              } else if (value == 'Feedback') {
                Get.to(() => FeedbackPage());
              } else if (value == 'Support') {
                ctrl.loadData();
                Get.to(() => Support());
              } else if (value == 'Logout') {
                rCtrl.deleteUserData();
                Phoenix.rebirth(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 5,
                    ),
                    Text(S.of(context).Settings),
                  ],
                ),
                value: 'Settings',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.feedback_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(S.of(context).feedback),
                  ],
                ),
                value: 'Feedback',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.support_agent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(S.of(context).Support),
                  ],
                ),
                value: 'Support',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 5,
                    ),
                    Text(S.of(context).Logout),
                  ],
                ),
                value: 'Logout',
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ParseLiveListWidget(
            query: cCtrl.showClients(),
            lazyLoading: true,
            scrollPhysics: ClampingScrollPhysics(),
            shrinkWrap: true,
            childBuilder: (context, snapshot) {
              if (snapshot.failed) {
                return Text(S.of(context).warning);
              } else if (snapshot.hasData) {
                return Card(
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client Number :  ${snapshot.loadedData.get('number')}' ??
                              "-",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Clinet Shop Name :  ${snapshot.loadedData.get('shopName')}' ??
                              "-",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      ' Client Name :  ${snapshot.loadedData.get('name')}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: ElevatedButton(
                      child: Text(
                        "Order History" /*S.of(context).Delivered*/,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(20),
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                      ),
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
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
