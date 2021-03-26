import 'package:flutter/material.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:get/get.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/view/order/order_placed.dart';
// import 'package:pcm/widgets/orders.dart';

// ignore: must_be_immutable
class OrderHistoryDistributor extends StatelessWidget {
  CartController cltrCart = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          'Order History',
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: ListTile(
                    onTap: () {
                      Get.to(() => OrderPlaced());
                      // return showModal<void>(
                      //   context: context,
                      //   builder: (context) {
                      //     return OrderPlaced();
                      //   },
                      // );
                      // bottomNavigationIndex.value = 0;
                    },
                    leading: Icon(Icons.receipt_long_outlined),
                    title: Text('Order Received' /*S.of(context).jobs*/),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text('Add'),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text("1"),
                        ),
                      ),
                      // onTap: () {
                      //   clientCon.role.value = false;
                      //
                      //   Get.to(ClientRegister());
                      //   // Navigator.of(context)
                      //   //     .pushNamed(CreateReception.routeName);
                      // },
                    )),
              ),
              Card(
                child: ListTile(
                    onTap: () {
                      print('on tap listTile');
                      Get.to(() => OrderPlaced());
                      // return showModal<void>(
                      //   context: context,
                      //   builder: (context) {
                      //     return OrderPlaced();
                      //   },
                      // );
                    },
                    leading: Icon(Icons.receipt_long_outlined),
                    title: Text('Order Placed' /*S.of(context).jobs*/),
                    trailing: GestureDetector(
                      child: Chip(
                        label: Text('Add'),
                        // Text(S.of(context).add),
                        avatar: CircleAvatar(
                          child: Text(cltrCart.orderHistory.length.toString()),
                        ),
                      ),
                      onTap: () {},
                    )),
              ),
              SizedBox(
                height: 20,
              ),

              // Expanded(
              //   child: GridView(
              //     primary: false,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     children: [
              //       // dashboardContainer(name: 'Register'),
              //
              //       dashboardContainer(
              //         name: 'Settings',
              //         onTap: () => Get.to(SettingsPage()),
              //       ),
              //       dashboardContainer(
              //         name: 'FeedBack',
              //         onTap: () => Get.to(FeedbackPage()),
              //       ),
              //       dashboardContainer(
              //         name: 'Support',
              //         onTap: () => Get.to(Support()),
              //       ),
              //       dashboardContainer(
              //         name: 'Client',
              //         onTap: () => Get.to(HomeScreenClient()),
              //       ),
              //       // dashboardContainer(
              //       //   name: 'Delivery Boy',
              //       //   onTap: () => Get.to(HomeScreenDelivery()),
              //       // ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
