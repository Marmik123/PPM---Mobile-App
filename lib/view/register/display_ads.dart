import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/ad_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/common/feedback.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/common/support.dart';

class DisplayAd extends StatelessWidget {
  @override
  AdController adCtrl = Get.put(AdController());
  RepoController rCtrl = Get.put(RepoController());
  SupportController ctrl = Get.put(SupportController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: Icon(Icons.home_outlined),
        title: Text(
          S.of(context).adsRegistered,
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
            query: adCtrl.showAds(),
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
                          '${S.of(context).adDescrip}  ${snapshot.loadedData.get('adDescription')}' ??
                              "-",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${S.of(context).paymentR}:  ${snapshot.loadedData.get('paymentReceived')}' ??
                              "-",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      ' ${S.of(context).adN} ${snapshot.loadedData.get('adName')}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/id/1/200/300'),
                        ),
                      ),
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
