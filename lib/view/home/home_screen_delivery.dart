import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/register/login_mobile_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
// import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/order/order_history_delivery.dart';
import 'package:pcm/widgets/bottom_widget.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';

import '../common/feedback.dart';
import '../common/support.dart';

class HomeScreenDelivery extends StatefulWidget {
  String mobileNum;

  HomeScreenDelivery({Key key, this.mobileNum}) : super(key: key);
  @override
  _HomeScreenDeliveryState createState() => _HomeScreenDeliveryState();
}

class _HomeScreenDeliveryState extends State<HomeScreenDelivery>
    with TickerProviderStateMixin {
  SharedPreferences mobile;
  RoundedLoadingButtonController ctrl = RoundedLoadingButtonController();
  SupportController sCtrl = Get.put(SupportController());
  OrderAssignController assignCtrl = Get.put(OrderAssignController());
  SignInController phoneCtrl = Get.put(SignInController());
  RepoController rCtrl = Get.put(RepoController());
  LoginController lCtrl = Get.put(LoginController());
  String mobileN;
  Animation rotateAnimation;
  Animation animation;

  AnimationController controller;
  bool mobileNAssigned = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateOrder();
    sCtrl.loadData();
    controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
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
                IconButton(
                  icon: Icon(Icons.refresh_sharp),
                  onPressed: () {
                    Phoenix.rebirth(context);
                  },
                ),
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
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
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
                assignCtrl.noOrderLeft()
                    ? buildNoMoreOrders(context)
                    : /*assignCtrl.isLoading.value
                        ? buildLoader()
                        :*/
                    mobileNAssigned
                        ? ParseLiveListWidget(
                            shrinkWrap: true,
                            lazyLoading: true,
                            listenOnAllSubItems: true,
                            scrollPhysics: ClampingScrollPhysics(),
                            query: assignCtrl.showOrder(mobileN),
                            childBuilder: (context, snapshot) {
                              if (snapshot.failed) {
                                return Text(S.of(context).warning);
                              } else if (snapshot.hasData) {
                                return buildOrderItem(snapshot, context);
                              } else if (snapshot.isBlank) {
                                return buildNoMoreOrders(context);
                              } else {
                                return ListTileShimmer();
                              }
                            },
                          )
                        : buildLoader(),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                var mobile = await SharedPreferences.getInstance();
                assignCtrl.showDeliveredOrder(mobile.getString(rCtrl.kMobile));
                return Get.to(() => OrderHistoryDelivery(
                      listObject: assignCtrl.deliveredOrders,
                    ));
              },
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.receipt_long_outlined,
                color: Colors.white,
              ),
              label: Text('Orders'),
            ),
          ),
        ));
  }

  Container buildOrderItem(
      ParseLiveListElementSnapshot<dynamic> snapshot, BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child:
            /*assignCtrl.isLoading.value
                                      ? buildLoader()
                                      :*/
            Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yy hh:mm')
                            .format(snapshot.loadedData.get('date_time')) ??
                        '-',
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    S.of(context).Ongoing,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).delId,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(94, 94, 94, 1),
                          )),
                      Text(
                        snapshot.loadedData.get('objectId') ?? '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).price,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(94, 94, 94, 1),
                          )),
                      Text(
                        snapshot.loadedData.get('total_price').toString() ??
                            '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).payment,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(94, 94, 94, 1),
                          )),
                      Text(
                        snapshot.loadedData.get('payment_option') ?? '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).customerN,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(94, 94, 94, 1),
                          )),
                      Text(
                        snapshot.loadedData.get('customerName') ?? '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).customerAdd,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(94, 94, 94, 1),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.topRight,
                        child: Text(
                          snapshot.loadedData.get('customerAddress') ?? '-',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).contact,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(94, 94, 94, 1),
                        ),
                      ),
                      Text(
                        snapshot.loadedData.get('customerContactNo') ?? '-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //assignCtrl.isLoadingButton == widget.index + 1
            /* ? buildLoader()
                                          :*/
            ElevatedButton(
              child: Text(
                S.of(context).Delivered,
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                shadowColor: MaterialStateProperty.all(Colors.green.shade100),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
              ),
              onPressed: () {
                setState(() {
                  final _controller = SignatureController(
                    penStrokeWidth: 3,
                    penColor: Colors.green,
                    exportBackgroundColor: Colors.black,
                  );
                  /*var _signatureCanvas =*/
                  Get.dialog(
                    Column(
                      children: [
                        Stack(
                          children: [
                            Signature(
                              controller: _controller,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.5,
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                child: Text(
                                  S.of(context).signatureNote,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2, 3))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green,
                                  ),
                                  onTap: () async {
                                    if (_controller.isNotEmpty) {
                                      assignCtrl.setDeliveryStatus(
                                        snapshot.loadedData,
                                        'yes',
                                      );
                                      await assignCtrl.uploadImg('img.jpg',
                                          await _controller.toPngBytes());
                                      assignCtrl.chooseFile(
                                          assignCtrl.nameList()[0],
                                          snapshot.loadedData);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    _controller.clear();
                                  },
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    barrierDismissible: false,
                  );

                  //assignCtrl.isLoadingButton = widget.index + 1;
                });
                updateOrder();
                // assignCtrl.pressedButtonIndex.value =
                //  widget.index + 1;
              },
            )
          ],
        ));
  }

  Padding buildNoMoreOrders(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 150),
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
                color: Colors.green,
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
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void updateOrder() async {
    var mobile = await SharedPreferences.getInstance();
    //await assignCtrl.showAssignedOrder(mobile.getString(rCtrl.kMobile) ?? "-");
    await assignCtrl.showOrder(mobile.getString(rCtrl.kMobile) ?? '-');
    mobileN = mobile.getString(rCtrl.kMobile);
    setState(() {
      mobileNAssigned = true;
    });
    print('!!!!!!!!!!!${mobileN}');
  }

  Future<String> create() async {
    var pref = await SharedPreferences.getInstance();
    var number = await pref.getString(rCtrl.kMobile);
    return number;
  }
}

/*ListView.builder(
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
                        ),*/
