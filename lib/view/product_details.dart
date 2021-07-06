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
  TextEditingController qtyController = TextEditingController(text: '1');
  FocusNode qtyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    cltrProduct.slideIndex(0);
    cltrProduct.quantity(1);
    cltrCart.quantity(1);
    cltrProduct.size('Small');
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
            widget.product?.get('imageFileName')?.isEmpty ?? true
                ? SizedBox.shrink()
                : Row(
                    children: [
                      Icon(CupertinoIcons.back),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: PageView.builder(
                            // loop: false,
                            // autoplay: false,
                            // layout: SwiperLayout.TINDER,
                            // itemWidth: MediaQuery.of(context).size.width * 0.95,
                            // itemHeight: MediaQuery.of(context).size.height * 0.55,
                            itemCount:
                                widget.product.get('imageFileName')?.length ??
                                    0,
                            physics: PageScrollPhysics(),
                            //ctrl.introScreenSlides.length,
                            onPageChanged: (indexCount) {
                              cltrProduct.slideIndex.value = indexCount;
                            },
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.all(10),
                                elevation: 5,
                                shadowColor: Colors.black45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://api.ppmstore.in/file/product/${widget.product.get('imageFileName')[index]}',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
            Obx(
              () => widget.product?.get('imageFileName').isEmpty
                  ? SizedBox.shrink()
                  : DotsIndicator(
                      dotsCount:
                          widget.product?.get('imageFileName')?.length ?? 1,
                      position: cltrProduct.slideIndex().toDouble(),
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
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Text(
                '${widget.product.get('productName')}',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            /*Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Text(
                S.of(context).desc,
                style: GoogleFonts.merriweather(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),*/
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade100,
              ),
              //height: 300,
              child: Text(
                widget.product.get('productDesc'),
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 20 / 100,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            color: Colors.green.shade50,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '₹ ${widget.product.get('productPrice')} / ${widget.product.get('unit')}',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: cltrProduct.quantity() <= 1
                                ? Colors.grey
                                : Color(0xff000000),
                          ),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.remove_circle,
                              color: cltrProduct.quantity() <= 1
                                  ? Colors.grey
                                  : Color(0xff000000),
                            ),
                            onPressed: () {
                              if (cltrProduct.quantity() > 1) {
                                setState(() {
                                  cltrProduct.quantity.value--;
                                  cltrCart.quantity.value--;
                                });
                              } else {
                                Get.rawSnackbar(
                                  message: 'Minimum order quantity is 1',
                                  icon: Icon(Icons.warning),
                                  backgroundColor: Colors.orangeAccent,
                                  snackPosition: SnackPosition.BOTTOM,
                                  overlayBlur: 1,
                                  borderRadius: 10,
                                  snackStyle: SnackStyle.FLOATING,
                                  margin: EdgeInsets.all(10),
                                );
                              }
                            }),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${cltrProduct.quantity()}',
                            ),
                            TextSpan(
                              text: ' ${widget.product.get('unit')}',
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                          style: GoogleFonts.sourceSansPro(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      /*Expanded(
                        child: EditableText(
                          controller: qtyController,
                          focusNode: qtyFocusNode,
                          style: GoogleFonts.sourceSansPro(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          cursorColor: Colors.green,
                          backgroundCursorColor: Colors.transparent,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              cltrCart.quantity(int.tryParse(value));
                            }
                          },
                        ),
                      ),*/
                      Container(
                        height: 50.0,
                        width: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Color(0xff000000),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Color(0xff000000),
                          ),
                          onPressed: () {
                            setState(() {
                              cltrProduct.quantity++;
                              cltrCart.quantity++;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  /*child: Form(
                    key: cltrProduct.key,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 2,
                      child: DropdownButtonFormField(
                        elevation: 10,
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.green,
                        ),
                        value: selectedType,
                        onChanged: (value) {
                          setState(() {
                            value == 0
                                ? cltrProduct.size.value = 'Small'
                                : value == 1
                                    ? cltrProduct.size.value = 'Medium'
                                    : cltrProduct.size.value = 'Large';
                            selectedType = value;
                          });
                        },
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.green,
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 25 / 100,
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            color: Colors.blueGrey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Size\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: cltrProduct.sizeDimList.first.toString(),
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox.expand(
                    child: TextButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.of(context).cartAdd + '\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '₹ ${double.parse(widget.product.get('productPrice')) * cltrCart.quantity()}',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.double_arrow_rounded,
                            color: Colors.green.shade50,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        // cltrProduct.cartProducts.add(widget.product);
                        var prefs = await SharedPreferences.getInstance();
                        await login.checkUserExist(repo.number);
                        if (cltrProduct.key.currentState.validate()) {
                          login.userNotExist.value
                              ? print('Trying to add but user doesnt exist')
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        enableFeedback: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
