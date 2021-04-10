import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/view/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  RxList products = [].obs;
  RxBool isLoading = false.obs;
  QueryBuilder<ParseObject> productData =
      QueryBuilder<ParseObject>(ParseObject('Products'));
  Future<void> productsData() async {
    isLoading.value = true;

    ParseResponse productResponse = await productData.query();
    products.assignAll(productResponse.results);
    print(products);
    isLoading.value = false;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   productsData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Products,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: ParseLiveListWidget<ParseObject>(
        query: productData,
        lazyLoading: true,
        preloadedColumns: ['productName', 'fileImage'],
        listLoadingElement: LinearProgressIndicator(),
        childBuilder: (context, snapshot) {
          if (snapshot.failed) {
            return Text(S.of(context).error);
          } else if (snapshot.hasData || snapshot.hasPreLoadedData) {
            if (snapshot.hasData) {
              return Card(
                child: ListTile(
                  onTap: () => Get.to(() => ProductDetails(
                        product: snapshot.loadedData,
                      )),
                  subtitle: Text(snapshot.loadedData.get('productPrice')),
                  title: Text(
                    snapshot.loadedData.get('productName'),
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Container(
                    color: Colors.cyan,
                    height: 50,
                    width: 50,
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
              return ProfileShimmer();
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
