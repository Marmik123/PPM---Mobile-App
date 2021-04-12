import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomeScreenClientController extends GetxController {
  RxList products = [].obs;
  RxBool isLoading = false.obs;
  RxList<ParseObject> loggedInClient = <ParseObject>[].obs;
  QueryBuilder<ParseObject> productData =
      QueryBuilder<ParseObject>(ParseObject('Products'));

  Future<void> showLoggedInUserData(String mobile) async {
    print("called showloggedinUser");
    try {
      QueryBuilder<ParseObject> loggedInClientData =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..whereEqualTo('number', mobile);

      ParseResponse result = await loggedInClientData.query();
      if (result.success) {
        print("logged in data success");
        print(result);
        loggedInClient(result.results);

        print('########$loggedInClient');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> productsData() async {
    isLoading.value = true;

    ParseResponse productResponse = await productData.query();
    products.assignAll(productResponse.results);
    print(products);
    isLoading.value = false;
  }
}
