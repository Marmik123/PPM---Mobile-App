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
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/order_history_client.dart';
import 'package:pcm/view/product_details.dart';
import 'package:pcm/widgets/bottom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/feedback.dart';
import '../common/support.dart';

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
  // RepoController rCtrl = Get.put(RepoController());
  SignInController phoneCtrl = Get.put(SignInController());
  String number;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
    print('init state called;');
    var support = Get.put(SupportController());
    support.loadData();
    var cartC = Get.put(CartController());
    cartC.showOrderHistoryData(number);
    cartC.showROrderHistoryData(number);

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
    await S.load(storedLocale);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.home,
          ),
          title: Text(
            'PPM Store',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () async {
                // Add Your Code here.
                return Get.to(() => Cart());
              },
            ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  deleteUserData();
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
        body: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
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
              height: 15,
            ),
            ParseLiveListWidget<ParseObject>(
              shrinkWrap: true,
              scrollPhysics: const ClampingScrollPhysics(),
              query: cltrClient.productData,
              lazyLoading: true,
              preloadedColumns: ['productName', 'fileImage', 'productPrice'],
              // listLoadingElement: LinearProgressIndicator(),
              padding: EdgeInsets.only(top: 10),
              listenOnAllSubItems: true,
              childBuilder: (context, snapshot) {
                if (snapshot.failed) {
                  return Text(S.of(context).warning);
                } else if (snapshot.hasData || snapshot.hasPreLoadedData) {
                  if (snapshot.hasData) {
                    /*print(
                        "####@@@${snapshot.loadedData.get('imageFileName')[0]}");*/
                    var images = snapshot.loadedData.get('imageFileName')
                        as List<dynamic>;
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        onTap: () => Get.to(() => ProductDetails(
                              product: snapshot.loadedData,
                            )),
                        subtitle: Text(
                          '₹ ${snapshot.loadedData.get('productPrice')} / ${snapshot.loadedData.get('unit')}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          snapshot.loadedData.get('productName'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: FittedBox(
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 5,
                            shadowColor: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(images.isNotEmpty
                                      ? 'https://api.ppmstore.in/file/product/${images.first}'
                                      : 'https://picsum.photos/id/1/200/300'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.double_arrow_sharp,
                          color: Colors.green,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var mobile = await SharedPreferences.getInstance();
            cartC.showOrderHistoryData(number);
            cartC.showROrderHistoryData(number);
            setState(() {});
            number = mobile.getString(kMobile);
            return Get.to(
              () => OrderHistoryClient(
                number: number,
              ),
            );
          },
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.receipt_long_outlined,
            color: Colors.white,
          ),
          label: Text('Orders'),
        ),
      ),
    );
  }
}
