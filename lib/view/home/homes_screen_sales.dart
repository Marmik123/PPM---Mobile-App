import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
// import 'package:pcm/view/home/home_screen_delivery.dart';
import 'package:pcm/view/register/client.dart';

import '../common/feedback.dart';
import '../common/support.dart';

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
          'Home Screen',
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
      body: Obx(
        () => Container(
          child: Column(
            children: [
              Card(
                child: ListTile(
                    onTap: () {
                      // bottomNavigationIndex.value = 0;
                    },
                    leading: Icon(Icons.person_outline),
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
/*              Card(
                child: ListTile(
                    // tileColor: Colors.cyanAccent,
                    // onTap: () {
                    //   // bottomNavigationIndex.value = 0;
                    // },
                    leading: Icon(Icons.domain),
                    title:
                        Text('Distributors Registered' */ /*S.of(context).jobs*/ /*),
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
              ),*/
              SizedBox(
                height: 20,
              ),
/*
              Expanded(
                child: GridView(
                  padding: EdgeInsets.all(20),
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: [
                    // dashboardContainer(name: 'Register'),

                    // dashboardContainer(
                    //   name: 'Settings',
                    //   icon: Icons.settings,
                    //   onTap: () => Get.to(SettingsPage()),
                    // ),
                    // dashboardContainer(
                    //   name: 'FeedBack',
                    //   icon: Icons.feedback_outlined,
                    //   onTap: () => Get.to(FeedbackPage()),
                    // ),
                    // dashboardContainer(
                    //   name: 'Support',
                    //   icon: Icons.contact_support_outlined,
                    //   onTap: () => Get.to(Support()),
                    // ),
                    dashboardContainer(
                      name: 'Client',
                      icon: Icons.person_outline,
                      onTap: () => Get.to(HomeScreenClient()),
                    ),
                    // dashboardContainer(
                    //   name: 'Delivery Boy',
                    //   onTap: () => Get.to(HomeScreenDelivery()),
                    // ),
                  ],
                ),
              )
*/
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomWidget(
      //   showHistory: false,
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
