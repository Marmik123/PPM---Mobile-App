import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProductsController extends GetxController {
  QueryBuilder<ParseObject> productsData =
      QueryBuilder<ParseObject>(ParseObject('Products'));

  RxList<ParseObject> products = [].obs;
  Future<void> productData() async {
    try {
      ParseResponse response = await productsData.query();
      if (response.success) {
        products.value = response.results;
      }
    } catch (e) {
      print('product listing error $e');
    }
  }
}
