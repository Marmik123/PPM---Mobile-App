import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/controller/cart_controller.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/products_repository.dart';

class ProductDetails extends StatefulWidget {
  final ParseObject product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CartController cltrCart = CartController();
  int selectedType = 0;

  ProductsController cltrProduct = Get.put(ProductsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cltrProduct.quantity.value = 1;
    cltrCart.quantity.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).detail,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
            ),
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
                                  '${cltrCart.quantity.value}',
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
                      TextButton(
                        onPressed: () {
                          // cltrProduct.cartProducts.add(widget.product);
                          cltrCart.addItem(
                            widget.product.objectId,
                            widget.product.get('productName'),
                            double.parse(widget.product.get('productPrice')),
                            cltrCart.quantity.value,
                            cltrProduct.size.value,
                          );
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
                    height: MediaQuery.of(context).size.height / 10,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorS;
                          }
                          return null;
                        },
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelText: S.of(context).type,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                        items: [
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
                        ]),
                  )
                ],
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
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              //height: 300,
              child: Text(widget.product.get('productDesc')),
            ),
          ],
        ),
      ),
    );
  }
}
