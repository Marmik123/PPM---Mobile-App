import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/homescreen_client_controller.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/cart.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/order_history_client.dart';
import 'package:pcm/view/product_details.dart';
// import 'package:pcm/view/products.dart';
// import 'package:pcm/view/register/client.dart';
import 'package:pcm/widgets/bottom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/feedback.dart';
import '../common/support.dart';
// import '../product_details.dart';

class HomeScreenClient extends StatefulWidget {
  @override
  _HomeScreenClientState createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient>
    with TickerProviderStateMixin {
  HomeScreenClientController cltrClient = Get.put(HomeScreenClientController());
  ProductsController proCtrl = Get.put(ProductsController());
  SupportController sCtrl = Get.put(SupportController());
  CartController cartC = Get.put(CartController());
  Animation rotateAnimation;

  AnimationController controller;
  AnimationController aniCtrl;
  AnimationController ctrl;
  Animation animation;
  Animation rowAnimation;
  RepoController rCtrl = Get.put(RepoController());
  SignInController phoneCtrl = Get.put(SignInController());
  String number;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RepoController rCtrl = Get.put(RepoController());
    rCtrl.loadUserData();
    print("init state called;");
    SupportController support = Get.put(SupportController());
    support.loadData();
    CartController cartC = Get.put(CartController());
    cartC.showOrderHistoryData(rCtrl.number);
    cartC.showROrderHistoryData(rCtrl.number);

    controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    ctrl = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    rowAnimation = Tween<Offset>(
      begin: Offset.fromDirection(0, 0),
      end: const Offset(4.8, 0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutExpo,
    ));

    rotateAnimation = Tween<Offset>(
      begin: Offset.fromDirection(0, 0),
      end: const Offset(0.2, 0.0),
    ).animate(controller);

    controller.forward();
    controller.addListener(() {
      print(animation.value);
      setState(() {
        controller.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  Future<Locale> loadLang() async {
    await S.load(rCtrl.storedLocale);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Scaffold(
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
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () async {
                  // Add Your Code here.
                  return Get.to(() => Cart());
                }),
/*          IconButton(
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: QrImage(
                          data: "9874653210",
                          version: QrVersions.auto,
                          size: 300.0,
                        ),
                      );
                    },
                  );
                })*/
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'Settings') {
                  Get.to(() => SettingsPage()).then((value) {
                    setState(() {});
                  });
                } else if (value == 'Feedback') {
                  Get.to(() => FeedbackPage());
                } else if (value == 'Support') {
                  //sCtrl.loadData();
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
                      Icon(Icons.settings_outlined),
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
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 20,
            ),
            ParseLiveListWidget<ParseObject>(
              shrinkWrap: true,
              scrollPhysics: ClampingScrollPhysics(),
              query: cltrClient.productData,
              lazyLoading: true,
              preloadedColumns: ['productName', 'fileImage', 'productPrice'],
              // listLoadingElement: LinearProgressIndicator(),
              childBuilder: (context, snapshot) {
                if (snapshot.failed) {
                  return Text(S.of(context).warning);
                } else if (snapshot.hasData || snapshot.hasPreLoadedData) {
                  if (snapshot.hasData) {
                    print(
                        "####@@@${snapshot.loadedData.get('imageFileName')[0]}");
                    return Card(
                      child: ListTile(
                        onTap: () => Get.to(() => ProductDetails(
                              product: snapshot.loadedData,
                            )),
                        subtitle: Text(
                            'Price: ${snapshot.loadedData.get('productPrice')}'),
                        title: Text(
                          snapshot.loadedData.get('productName'),
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: FittedBox(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://cup.marketing.dharmatech.in/file/product/${snapshot.loadedData.get('imageFileName')[0]}' ??
                                      'https://picsum.photos/id/1/200/300'),
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
                    //   Container(
                    // height: 300,
                    // child: Card(
                    //   child: Stack(
                    //     fit: StackFit.loose,
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.all(5),
                    //         height: MediaQuery.of(context).size.height,
                    //         width: MediaQuery.of(context).size.width,
                    //         color: Colors.cyan,
                    //       ),
                    //       Align(
                    //         alignment: Alignment.bottomCenter,
                    //         child: Container(
                    //           padding: EdgeInsets.only(left: 5),
                    //           margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    //           height: 35,
                    //           color: Colors.red.withOpacity(0.3),
                    //           alignment: Alignment.bottomCenter,
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.max,
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(snapshot.loadedData.get('productName')),
                    //               IconButton(
                    //                   icon: Icon(Icons.shopping_cart_outlined),
                    //                   onPressed: () {})
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
            // Expanded(
            //   child: GridView(
            //     primary: false,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     children: [
            //       // dashboardContainer(name: 'Register'),
            //       dashboardContainer(
            //         name: 'Products',
            //         icon: Icons.inventory,
            //         onTap: () => Get.to(Products()),
            //       ),
            //       // dashboardContainer(
            //       //   name: 'Order History',
            //       //   icon: Icons.history,
            //       //   onTap: () => Get.to(OrderHistoryClient()),
            //       // ),
            //       // dashboardContainer(
            //       //   name: 'Settings',
            //       //   onTap: () => Get.to(SettingsPage()),
            //       // ),
            //       // dashboardContainer(
            //       //   name: 'FeedBack',
            //       //   onTap: () => Get.to(FeedbackPage()),
            //       // ),
            //       // dashboardContainer(
            //       //   name: 'Support',
            //       //   onTap: () => Get.to(Support()),
            //       // ),
            //       dashboardContainer(
            //         name: 'Delivery',
            //         icon: Icons.delivery_dining,
            //         onTap: () => Get.to(HomeScreenDelivery()),
            //       ),
            //     ],
            //   ),
            // )
/*          dashboardContainer(
              name: 'Delivery',
              icon: Icons.delivery_dining,
              onTap: () => Get.to(HomeScreenDelivery()),
            ),*/
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: BottomWidget(
          rotation: animation.value,
          onTap: () async {
            SharedPreferences mobile = await SharedPreferences.getInstance();
            cartC.showOrderHistoryData(rCtrl.number);
            cartC.showROrderHistoryData(rCtrl.number);
            setState(() {});
            number = mobile.getString(rCtrl.kMobile);
            return Get.to(
              () => OrderHistoryClient(
                number: number,
              ),
            );
          },
        ),
      ),
    );
  }
}
