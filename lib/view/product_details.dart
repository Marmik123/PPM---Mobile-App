import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/controller/products_controller.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  final ParseObject product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductsController cltrProduct = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ProductDetail',
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
                    '₹ 100',
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Card(
                        child: Row(
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
                                      cltrProduct.quantity--;
                                    });
                                  }
                                }),

                            Text(
                              '${cltrProduct.quantity.value}',
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
                                  cltrProduct.quantity++;
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
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          cltrProduct.cartProducts.add(widget.product);
                          print(cltrProduct.cartProducts);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                        ),
                        child: Text(
                          'Add Cart',
                          style: GoogleFonts.merriweather(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                'Description:',
                style: GoogleFonts.merriweather(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
