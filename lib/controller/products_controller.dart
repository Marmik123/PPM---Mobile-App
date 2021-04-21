import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProductsController extends GetxController {
  QueryBuilder<ParseObject> productsData =
      QueryBuilder<ParseObject>(ParseObject('Products'));

  RxString unit = "Kg".obs;
  RxList products = [].obs;
  RxList cartProducts = [].obs;
  RxString size = "Small".obs;
  RxList sizeList = [].obs;
  RxInt quantity = 1.obs;
  Future<void> productData() async {
    try {
      ParseResponse response = await productsData.query();
      if (response.success) {
        products.assignAll(response.results);
      }
    } catch (e) {
      print('product listing error $e');
    }
  }
}
