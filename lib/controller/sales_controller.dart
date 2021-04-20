import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SalesController extends GetxController {
  RxList orderRHistory = [].obs;
  RxInt rOrders = 0.obs;
  QueryBuilder displayReceivedOrder(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderReceived =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile)
            ..whereEqualTo('deliveryStatus', 'yes');

      return loadOrderReceived;
    } catch (e) {
      print(e);
    }
  }

  QueryBuilder displayOrderHistory(String mobile) {
    try {
      QueryBuilder<ParseObject> loadOrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile);

      return loadOrderHistory;
    } catch (e) {
      print(e);
    }
  }

  Future<void> displayROrderHistoryData(String mobile) async {
    //orderH.value = true;
    try {
      print("showROrderDatahistory called");
      QueryBuilder<ParseObject> loadROrderHistory =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerContactNo', mobile)
            ..whereEqualTo('deliveryStatus', 'yes');

      ParseResponse rOrderData = await loadROrderHistory.query();
      if (rOrderData.success) {
        orderRHistory.removeRange(0, orderRHistory.length);
        orderRHistory(rOrderData.results);
        rOrders.value = orderRHistory().length;
        //orderH.value = false;
      } else {
        print("error");
      }
    } catch (e) {
      //orderH.value = false;
      print(e);
    }
  }
}
