import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/home/home_screen_client.dart';
import 'package:pcm/view/home/home_screen_delivery.dart';
import 'package:pcm/view/register/client.dart';
import 'file:///D:/flutter/pcm/lib/view/common/feedback.dart';
import 'file:///D:/flutter/pcm/lib/view/common/support.dart';
import 'package:pcm/widgets/dashbord_card.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  ClientController clientCon = Get.put(ClientController());
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
          style:
              GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                  onTap: () {
                    // bottomNavigationIndex.value = 0;
                  },
                  leading: Icon(Icons.handyman),
                  title: Text('Clients Registered' /*S.of(context).jobs*/),
                  trailing: GestureDetector(
                    child: Chip(
                      label: Text('Add'),
                      // Text(S.of(context).add),
                      avatar: CircleAvatar(
                        child: Text(clientCon.clientCount.value.toString()),
                      ),
                    ),
                    onTap: () {
                      clientCon.role.value = false;

                      Get.to(ClientRegister());
                      // Navigator.of(context)
                      //     .pushNamed(CreateReception.routeName);
                    },
                  )),
            ),
            Card(
              child: ListTile(
                  onTap: () {
                    // bottomNavigationIndex.value = 0;
                  },
                  leading: Icon(Icons.handyman),
                  title: Text('Distributors Registered' /*S.of(context).jobs*/),
                  trailing: GestureDetector(
                    child: Chip(
                      label: Text('Add'),
                      // Text(S.of(context).add),
                      avatar: CircleAvatar(
                        child:
                            Text(clientCon.distributorCount.value.toString()),
                      ),
                    ),
                    onTap: () {
                      clientCon.role.value = true;

                      Get.to(ClientRegister());
                      // Navigator.of(context)
                      //     .pushNamed(CreateReception.routeName);
                    },
                  )),
            ),
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
                  dashboardContainer(
                    name: 'Client',
                    onTap: () => Get.to(HomeScreenClient()),
                  ),
                  // dashboardContainer(
                  //   name: 'Delivery Boy',
                  //   onTap: () => Get.to(HomeScreenDelivery()),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
