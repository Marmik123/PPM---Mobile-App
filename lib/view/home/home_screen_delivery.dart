import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/ongoing_order_delivery.dart';
import 'package:pcm/view/order/order_history_delivery.dart';
import 'package:pcm/view/register/client.dart';
import 'file:///D:/flutter/pcm/lib/view/common/feedback.dart';
import 'file:///D:/flutter/pcm/lib/view/common/support.dart';
import 'package:pcm/widgets/dashbord_card.dart';
import 'package:get/get.dart';

class HomeScreenDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: Container(
          height: 35,
          width: 35,
        ),
        title: Text(
          'HomeScreen',
          style:
              GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  // dashboardContainer(name: 'Register'),
                  dashboardContainer(
                    name: 'Ongoing Order',
                    onTap: () => Get.to(OngoingOrderDelivery()),
                  ),
                  dashboardContainer(
                    name: 'Order History',
                    onTap: () => Get.to(OrderHistoryDelivery()),
                  ),
                  dashboardContainer(
                    name: 'Settings',
                    onTap: () => Get.to(SettingsPage()),
                  ),
                  dashboardContainer(
                    name: 'FeedBack',
                    onTap: () => Get.to(FeedbackPage()),
                  ),
                  dashboardContainer(
                    name: 'Support',
                    onTap: () => Get.to(Support()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
