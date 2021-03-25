import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
// import 'package:pcm/widgets/dashbord_card.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/homescreen_client_controller.dart';
import 'package:pcm/view/cart.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/order_history_distributor.dart';
import 'package:pcm/view/place_order.dart';
// import 'package:pcm/view/home/home_screen_delivery.dart';
// import 'file:///D:/flutter/pcm/lib/view/order/order_history_client.dart';
// import 'package:pcm/view/products.dart';
import 'package:pcm/widgets/bottom_widget.dart';

import '../common/feedback.dart';
import '../common/support.dart';
import '../product_details.dart';

class HomeScreenDistributor extends StatelessWidget {
  HomeScreenClientController cltrClient = Get.put(HomeScreenClientController());

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
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () => Get.to(() => Cart())),

          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'PC') {
                Get.to(() => PlaceOrder());
              } else if (value == 'Settings') {
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
                    Icon(Icons.article_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Place Order'),
                  ],
                ),
                value: 'PC',
              ),
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
          // IconButton(
          //   icon: Icon(Icons.article_outlined),
          //   onPressed: () => Get.to(() => PlaceOrder()),
          // ),
        ],
      ),
      body: ParseLiveListWidget<ParseObject>(
        shrinkWrap: true,
        query: cltrClient.productData,
        lazyLoading: true,
        preloadedColumns: ['productName', 'fileImage'],
        listLoadingElement: Center(child: CircularProgressIndicator()),
        childBuilder: (context, snapshot) {
          if (snapshot.failed) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.hasPreLoadedData) {
            if (snapshot.hasData) {
              return Card(
                child: ListTile(
                  onTap: () => Get.to(() => ProductDetails(
                        product: snapshot.loadedData,
                      )),
                  subtitle: Text('Price : 100'),
                  title: Text(
                    snapshot.loadedData.get('productName'),
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage('https://picsum.photos/id/1/200/300'),
                      ),
                    ),
                  ),
                ),
              );
              // GridView.builder(
              // shrinkWrap: true,
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2),
              // itemBuilder: (context, index) {
              //   return
              //     Container(
              //   height: 300,
              //   child: Card(
              //     child: Stack(
              //       fit: StackFit.loose,
              //       children: [
              //         Container(
              //           margin: EdgeInsets.all(5),
              //           height: MediaQuery.of(context).size.height,
              //           width: MediaQuery.of(context).size.width,
              //           color: Colors.cyan,
              //         ),
              //         Align(
              //           alignment: Alignment.bottomCenter,
              //           child: Container(
              //             padding: EdgeInsets.only(left: 5),
              //             margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              //             height: 35,
              //             color: Colors.red.withOpacity(0.3),
              //             alignment: Alignment.bottomCenter,
              //             child: Row(
              //               mainAxisSize: MainAxisSize.max,
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(snapshot.loadedData.get('productName')),
              //                 IconButton(
              //                     icon: Icon(Icons.shopping_cart_outlined),
              //                     onPressed: () {})
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   //   );
              //   // },
              // );
            } else {
              return ListTileShimmer();
            }
          } else {
            return SizedBox.shrink();
          }
        },
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
      //               name: 'Products',
      //               icon: Icons.inventory,
      //               onTap: () => Get.to(Products()),
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
      //             // dashboardContainer(
      //             //   name: 'Delivery',
      //             //   onTap: () => Get.to(HomeScreenDelivery()),
      //             // ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BottomWidget(
        onTap: () => Get.to(OrderHistoryDistributor()),
      ),
    );
  }
}
