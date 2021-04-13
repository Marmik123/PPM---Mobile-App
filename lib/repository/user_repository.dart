import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoController extends GetxController {
  String kUserData;
  ParseUser currentUser;
  RxString objectId = "".obs;

  Future<void> setUserData(String user) async {
    //GetStorage storage = GetStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserData, user);
    objectId.value = user;
    print("@@@@@@ $kUserData");
    print(objectId);
  }

  void deleteUserData() async {
    //GetStorage storage = GetStorage();
    //currentUser = storage.read(kUserData);
    // GetStorage().erase();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(kUserData);
    print("@@@@@@ $kUserData");
    objectId.value = null;
    print(objectId);
  }
}
