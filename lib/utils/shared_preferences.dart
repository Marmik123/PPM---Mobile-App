import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoController extends GetxController {
  String kUserData = 'role';
  String kMobile = "mobile";
  String kname = "name";
  String kAddress = "add";
  String kMobileNum = "mobileNo";
  String kObjectId = "objectId";
  String kOrderObjectId = "orderObId";
  String kLangCode = "languageCode";
  ParseUser currentUser;
  SharedPreferences language;
  String number;
  String name;
  String objectId;
  String username;
  String orderObjectId;

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

  Future<void> setLanguage(Locale locale) async {
    language = await SharedPreferences.getInstance();
    print('@@@@${locale.languageCode}');
    await language.setString(kLangCode, locale.languageCode ?? 'en');
    print('@@@@${language?.getString(kLangCode)}');
    await S.load(locale);
  }

  Future<Locale> savedLocale() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    print(sharedPref?.getString(kLangCode));
    //await S.load(locale);
    //await S.load(Locale(sharedPref?.getString(kLangCode)));
    print(Locale(sharedPref?.getString(kLangCode)));
    return Locale(sharedPref?.getString(kLangCode));
  }

  Locale get storedLocale => Locale(language?.getString(kLangCode) ?? 'hi');

  Future<void> setOrdersMetadataObjectId(String objectId) async {
    SharedPreferences objectPref = await SharedPreferences.getInstance();
    await objectPref.setString(kOrderObjectId, objectId);
  }

  Future<String> loadObjId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    orderObjectId = await prefs.getString(kOrderObjectId);
    print(orderObjectId);
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
    await prefs.remove(kOrderObjectId);
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print("@@@@@@2 ${prefs.getString(kMobile)}");
    //objectId.value = null;
    print(objectId);
  }
}
