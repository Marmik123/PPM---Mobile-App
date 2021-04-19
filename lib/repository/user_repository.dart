import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoController extends GetxController {
  String kUserData = 'role';
  String kMobile = "mobile";
  String kname = "name";
  String kAddress = "add";
  String kMobileNum = "mobileNo";
  String kObjectId = "objectId";
  ParseUser currentUser;
  String number;
  String name;
  String objectId;
  String username;

  Future<void> setUserData(String user, String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserData, user);
    await prefs.setString(kMobile, mobile);
    // objectId.value = user;
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print("@@@@@@2 ${prefs.getString(kMobile)}");
    print(objectId);
    number = await prefs.getString(kMobile);
    name = await prefs.getString(kname);
  }

  Future<void> setLoginData(
      String name, String address, String number, String objectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kMobileNum, number);
    await prefs.setString(kname, name);
    await prefs.setString(kAddress, address);
    await prefs.setString(kObjectId, objectId);
    username = await prefs.getString(kname);
    print(username);
  }

  Future<String> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    number = await prefs.getString(kMobile);
    objectId = await prefs.getString(kObjectId);
    name = await prefs.getString(kname);
    print(name);
  }

  void deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserData);
    await prefs.remove(kMobile);
    await prefs.remove(kname);
    await prefs.remove(kAddress);
    await prefs.remove(kMobileNum);
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print("@@@@@@2 ${prefs.getString(kMobile)}");
    //objectId.value = null;
    print(objectId);
  }
}
