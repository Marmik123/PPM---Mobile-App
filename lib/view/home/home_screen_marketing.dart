import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/register/ad_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/register/ads_registeration.dart';
import 'package:pcm/view/register/display_ads.dart';

import '../common/feedback.dart';
import '../common/support.dart';

// ignore: must_be_immutable
class HomeScreenM extends StatefulWidget {
  @override
  _HomeScreenMState createState() => _HomeScreenMState();
}

class _HomeScreenMState extends State<HomeScreenM>
    with AutomaticKeepAliveClientMixin<HomeScreenM> {
  AdController adCtrl = Get.put(AdController());
  SupportController ctrl = Get.put(SupportController());
  RepoController rCtrl = Get.put(RepoController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: Icon(Icons.home_outlined),
          title: Text(
            S.of(context).HomeScreen,
          ),
          actions: [
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'Settings') {
                  Get.to(() => SettingsPage()).then((value) {
                    setState(() {});
                  });
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
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                      ),
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
                      Icon(
                        Icons.feedback_outlined,
                        color: Colors.black,
                      ),
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
                      Icon(
                        Icons.support_agent,
                        color: Colors.black,
                      ),
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
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
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
        body: Obx(
          () => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Hero(
                  tag: 'ppm_logo',
                  child: Image.asset(
                    'images/LOGO-02.png',
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Card(
                  elevation: 5,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Get.to(DisplayAd());
                    },
                    leading: Icon(
                      Icons.add_to_photos_sharp,
                      color: Colors.green,
                    ),
                    title: Text(S.of(context).adsRegistered),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text(S.of(context).Add),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text(adCtrl.adCount.value.toString()),
                        ),
                      ),
                      onTap: () {
                        //clientCon.role.value = false;
                        var adCtrl = Get.put(AdController());
                        adCtrl.pickedFile = null;
                        Get.to(AdRegister());
                        // Navigator.of(context)
                        //     .pushNamed(CreateReception.routeName);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // bottomNavigationBar: BottomWidget(
        //   showHistory: false,
        // ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
