import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/orders_assign_controller.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/products_repository.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final ParseObject product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  CartController cltrCart = CartController();
  OrderAssignController oCtrl = Get.put(OrderAssignController());
  int selectedType = 0;
  AnimationController controller;
  AnimationController aniCtrl;
  AnimationController ctrl;
  Animation animation;
  Animation rowAnimation;
  Animation rotateAnimation;
  int unit = 0;
  RepoController repo = Get.put(RepoController());
  LoginController login = Get.put(LoginController());
  ProductsController cltrProduct = Get.put(ProductsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cltrProduct.slideIndex.value = 0;
    cltrProduct.quantity.value = 1;
    cltrCart.quantity.value = 1;
    cltrProduct.size.value = "Small";
    getSizes();
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
      begin: Offset.fromDirection(-150, -150),
      end: const Offset(0, 0.005),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).detail,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.back),
                Expanded(
                  child: Swiper(
                    loop: false,
                    autoplay: false,
                    layout: SwiperLayout.TINDER,
                    itemWidth: MediaQuery.of(context).size.width * 0.95,
                    itemHeight: MediaQuery.of(context).size.height * 0.55,
                    itemCount: widget.product.get('imageFileName')?.length ?? 0,
                    //ctrl.introScreenSlides.length,
                    onIndexChanged: (indexCount) {
                      cltrProduct.slideIndex.value = indexCount;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://cup.marketing.dharmatech.in/file/product/${widget.product.get('imageFileName')[index]}'),
                        ),
                      );
                    },
                  ),
                ),
                Icon(CupertinoIcons.forward)
              ],
            )

            /*Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),*/
/*            Container(
              margin: EdgeInsets.all(10),
              height: 300,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: ClipRRect(
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://picsum.photos/id/1/200/300'),
                ),
              ),
            ),*/
            ,
            Obx(() => DotsIndicator(
                  dotsCount: widget.product.get('imageFileName')?.length ?? 0,
                  position: cltrProduct.slideIndex.value.toDouble(),
                  decorator: DotsDecorator(
                    size: Size(10, 10),
                    activeSize: Size(10, 10),
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )),
                    color: Colors.white,
                    activeColor: Colors.grey,
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Text(
                '${widget.product.get('productName')}',
                style: GoogleFonts.merriweather(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ ${widget.product.get('productPrice')}',
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Card(
                        child: Obx(() => Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       if (quentity > 1) {
                                //         quentity--;
                                //       }
                                //     });
                                //   },
                                //   child: buttonContainer(
                                //     Image.asset(quentity <= 1
                                //         ? "assets/images/btn_medicine_quantity_minus_disabled.png"
                                //         : 'assets/images/btn_medicine_quantity_minus.png'),
                                //   ),
                                // ),
                                IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 12,
                                    ),
                                    onPressed: () {
                                      if (cltrProduct.quantity.value != 0) {
                                        setState(() {
                                          cltrProduct.quantity.value--;
                                          cltrCart.quantity.value--;
                                        });
                                      }
                                    }),

                                Text(
                                  '${cltrCart.quantity.value} ${widget.product.get('unit') ?? '-'}',
                                  style: TextStyle(
                                    color: Color(0xff010101),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      cltrProduct.quantity.value++;
                                      cltrCart.quantity.value++;
                                    });
                                  },
                                  iconSize: 12,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       quentity++;
                                //     });
                                //   },
                                //   child: buttonContainer(
                                //     Image.asset(
                                //         "assets/images/btn_medicine_quantity_add.png"),
                                //   ),
                                // ),
                              ],
                            )),
                      ),
                      SlideTransition(
                        position: rowAnimation,
                        child: TextButton(
                          onPressed: () async {
                            // cltrProduct.cartProducts.add(widget.product);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await login.checkUserExist(repo.number);
                            if (cltrProduct.key.currentState.validate()) {
                              login.userNotExist.value
                                  ? print("Trying to add but user doesnt exist")
                                  : cltrCart.addItem(
                                      widget.product.objectId,
                                      widget.product.get('productName'),
                                      double.parse(
                                          widget.product.get('productPrice')),
                                      cltrCart.quantity.value,
                                      cltrProduct.size.value,
                                      widget.product.get('unit'),
                                      widget.product.get('imageFileName')[0]);
                            }

                            print('this is cart items $cartItems');

                            // print(cltrProduct.cartProducts);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                          ),
                          child: Text(
                            S.of(context).cartAdd,
                            style: GoogleFonts.merriweather(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Form(
                key: cltrProduct.key,
                child: Row(
                  children: [
/*                  Text(
                      "Choose Product Type",
                      style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )*/
                    Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 2,
                        child: DropdownButtonFormField(
                            elevation: 10,
                            value: selectedType,
                            onChanged: (value) {
                              setState(() {
                                value == 0
                                    ? cltrProduct.size.value = "Small"
                                    : value == 1
                                        ? cltrProduct.size.value = "Medium"
                                        : cltrProduct.size.value = "Large";
                                selectedType = value;
                              });
                            },
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.cyan,
                            decoration: InputDecoration(
                              labelText: S.of(context).size,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                            items: List.generate(
                                cltrProduct.sizeDimList?.length,
                                (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      cltrProduct.sizeDimList[index].toString(),
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ))))),
                    SizedBox(
                      width: 15,
                    ),
/*                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 3,
                      child:
                          */
                    /*DropdownButtonFormField(
                          elevation: 10,
                          value: unit,
                          onChanged: (value) {
                            setState(() {
                              value == 0
                                  ? cltrProduct.unit.value = "Kg"
                                  : cltrProduct.unit.value = "Pc";
                              unit = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return S.of(context).errorS;
                            }
                            return null;
                          },
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.cyan,
                          decoration: InputDecoration(
                            labelText: S.of(context).unit,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  S.of(context).kg,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  S.of(context).piece,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ])*/
                    /*
                          TextFormField(
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter the unit";
                          else if (!(value.isCaseInsensitiveContains("kg") ||
                              value.isCaseInsensitiveContains("pc"))) {
                            oCtrl.unitC.clear();
                            return "Please enter valid \nunit from Kg or Pc";
                          }
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "Enter the Unit",
                          labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          hintText: "Kg/Pc (Pieces)",
                        ),
                        controller: oCtrl.unitC,
                        keyboardType: TextInputType.text,
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Text(
                S.of(context).desc,
                style: GoogleFonts.merriweather(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              //height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product.get('productDesc')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkMobileNumber(String number) {
    login.checkUserExist(number);
  }

  getSizes() {
    var size = widget.product.get('size');
    cltrProduct.sizeDimList = size.split(';');
    print('###@@@${cltrProduct.sizeDimList}');
    return cltrProduct.sizeDimList;
  }
}
/*
[
DropdownMenuItem(
value: 0,
child: Text(
S.of(context).small,
style: GoogleFonts.montserrat(
textStyle: TextStyle(
color: Colors.black,
fontSize: 15,
fontWeight: FontWeight.w500),
),
)),
DropdownMenuItem(
value: 1,
child: Text(
S.of(context).medium,
style: GoogleFonts.montserrat(
textStyle: TextStyle(
color: Colors.black,
fontSize: 15,
fontWeight: FontWeight.w500),
),
)),
DropdownMenuItem(
value: 2,
child: Text(
S.of(context).large,
style: GoogleFonts.montserrat(
textStyle: TextStyle(
color: Colors.black,
fontSize: 15,
fontWeight: FontWeight.w500),
),
)),
]*/
