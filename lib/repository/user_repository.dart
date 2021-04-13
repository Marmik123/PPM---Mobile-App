import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoController extends GetxController {
  String kUserData = 'role';
  ParseUser currentUser;
  RxString objectId = "".obs;

  Future<void> setUserData(String user) async {
    //GetStorage storage = GetStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserData, user);
    objectId.value = user;
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print(objectId);
  }

  void deleteUserData() async {
    //GetStorage storage = GetStorage();
    //currentUser = storage.read(kUserData);
    // GetStorage().erase();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserData);
    print("@@@@@@ ${prefs.getString(kUserData)}");
    objectId.value = null;
    print(objectId);
  }
}
