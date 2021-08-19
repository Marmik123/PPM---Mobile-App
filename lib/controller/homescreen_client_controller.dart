import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm/utils/shared_preferences.dart';

class HomeScreenClientController extends GetxController {
  RxList products = [].obs;
  RxBool isLoading = false.obs;
  RxList<ParseObject> loggedInClient = <ParseObject>[].obs;
  QueryBuilder<ParseObject> productData =
      QueryBuilder<ParseObject>(ParseObject('Products'))
        ..orderByDescending('createdAt');
  // RepoController rCtrl = Get.put(RepoController());
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
        await setLoginData(
          loggedInClient[0]['name'],
          loggedInClient[0]['address1'],
          loggedInClient[0]['number'],
          loggedInClient[0]['objectId'],
          loggedInClient[0]['pincode'],
          loggedInClient[0]['shopName'],
          loggedInClient[0]['storeType'],
          loggedInClient[0]['gstType'],
          loggedInClient[0]['gstNumber'],
          loggedInClient[0]['landmark'],
          loggedInClient[0]['city'],
          loggedInClient[0]['state'],
          loggedInClient[0]['objectId'],
          loggedInClient[0]['imageFileName'],
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> productsData() async {
    isLoading.value = true;

    var productResponse = await productData.query();
    products.assignAll(productResponse.results);
    print(products);
    isLoading.value = false;
  }
}
