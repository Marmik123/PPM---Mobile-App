import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/ongoing_order_delivery.dart';
import 'package:pcm/view/order/order_history_delivery.dart';
import 'package:pcm/widgets/bottom_widget.dart';
// import 'package:pcm/view/register/client.dart';
import 'file:///D:/flutter/pcm/lib/view/common/feedback.dart';
import 'file:///D:/flutter/pcm/lib/view/common/support.dart';
import 'package:pcm/widgets/dashbord_card.dart';
import 'package:get/get.dart';

import 'home_screen_distributor.dart';

class HomeScreenDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: Icon(Icons.home_outlined),
        title: Text(
          'HomeScreen',
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
                Get.to(() => Support());
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
                    Text('Settings'),
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
                    Text('Feedback'),
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
                    Text('Support'),
                  ],
                ),
                value: 'Support',
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        // shrinkWrap: true,
        children: [
          ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return OngoingOrderDelivery();
            },
          ),
          dashboardContainer(
            name: 'Distributor',
            icon: Icons.domain,
            onTap: () => Get.to(HomeScreenDistributor()),
          ),
        ],
      ),
      // Container(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Expanded(
      //         child: GridView(
      //           primary: false,
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2),
      //           children: [
      //             // dashboardContainer(name: 'Register'),
      //             dashboardContainer(
      //               name: 'Ongoing Order',
      //               icon: Icons.receipt_long_outlined,
      //               onTap: () => Get.to(OngoingOrderDelivery()),
      //             ),
      //             // dashboardContainer(
      //             //   name: 'Order History',
      //             //   icon: Icons.history,
      //             //
      //             // ),
      //             // dashboardContainer(
      //             //   name: 'Settings',
      //             //   onTap: () => Get.to(SettingsPage()),
      //             // ),
      //             // dashboardContainer(
      //             //   name: 'FeedBack',
      //             //   onTap: () => Get.to(FeedbackPage()),
      //             // ),
      //             // dashboardContainer(
      //             //   name: 'Support',
      //             //   onTap: () => Get.to(Support()),
      //             // ),
      //             dashboardContainer(
      //               name: 'Distributor',
      //               icon: Icons.domain,
      //               onTap: () => Get.to(HomeScreenDistributor()),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BottomWidget(
        onTap: () => Get.to(OrderHistoryDelivery()),
      ),
    );
  }
}
