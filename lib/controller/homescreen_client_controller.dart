import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:get/get.dart';
class HomeScreenClientController extends GetxController{
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
}