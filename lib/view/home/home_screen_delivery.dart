import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/user_repository.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/ongoing_order_delivery.dart';
import 'package:pcm/view/order/order_history_delivery.dart';
import 'package:pcm/widgets/bottom_widget.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../common/feedback.dart';
import '../common/support.dart';

class HomeScreenDelivery extends StatefulWidget {
  @override
  _HomeScreenDeliveryState createState() => _HomeScreenDeliveryState();
}

class _HomeScreenDeliveryState extends State<HomeScreenDelivery> {
  RoundedLoadingButtonController ctrl = RoundedLoadingButtonController();
  SupportController sCtrl = Get.put(SupportController());
  OrderAssignController assignCtrl = Get.put(OrderAssignController());
  SignInController phoneCtrl = Get.put(SignInController());

  RepoController rCtrl = Get.put(RepoController());

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignCtrl.showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString());
  }*/

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 1,
            titleSpacing: 0,
            leading: Icon(Icons.home_outlined),
            title: Text(
              S.of(context).HomeScreen,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh_sharp),
                onPressed: () {
                  updateOrder();
                },
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'Settings') {
                    Get.to(() => SettingsPage());
                  } else if (value == 'Feedback') {
                    Get.to(() => FeedbackPage());
                  } else if (value == 'Support') {
                    sCtrl.loadData();
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
          body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              assignCtrl.noOrderLeft.value
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 150),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.cyan,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  S.of(context).complete,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            S.of(context).info,
                            style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : assignCtrl.isLoading.value
                      ? buildLoader()
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: assignCtrl.orderList?.length,
                          itemBuilder: (context, index) {
                            print(assignCtrl.orderList.length);
                            return (assignCtrl.orderList == null ||
                                    assignCtrl.orderList.length == 0)
                                ? buildLoader()
                                : OngoingOrderDelivery(
                                    index: index,
                                    updateFunc: updateOrder,
                                    listObject: assignCtrl.orderList[index],
                                  );
                          },
                        ),

              /* dashboardContainer(
            name: 'Distributor',
            icon: Icons.domain,
            onTap: () => Get.to(HomeScreenDistributor()),
          ),*/
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
            onTap: () {
              /* assignCtrl.showDeliveredOrder(
                  phoneCtrl.mobileNo.text.trim().toString());*/
              return Get.to(() => OrderHistoryDelivery(
                    listObject: assignCtrl.deliveredOrders,
                  ));
            },
          ),
        ));
  }

  void updateOrder() async {
    await assignCtrl
        .showAssignedOrder(phoneCtrl.mobileNo.text.trim().toString() ?? "-");
  }
}
