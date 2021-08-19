import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

String kUserData = 'role';
String kMobile = "mobile";
String kname = "name";
String kpincode = "pincode";
String kShopName = "shop";
String kStoreType = "store";
String kGstType = "gstType";
String kGstNo = "gstNo";
String kLandmark = "landmark";
String kImageFile = "imageFile";
String kCity = "city";
String kState = "state";
String kAddress = "add";
String kMobileNum = "mobileNo";
String kObjectId = "objectId";
String kOrderObjectId = "orderObId";
String kLangCode = "languageCode";
ParseUser currentUser;
SharedPreferences language;
String number;
String name;
String pincode;
String objectId;
String username;
String role;
String orderObjectId;

Future<void> setUserData(String user, String mobile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(kUserData, user);
  await prefs.setString(kMobile, mobile);
  // objectId.value = user;
  print("@@@@@@ ${prefs.getString(kUserData)}");
  print("@@@@@@2 ${prefs.getString(kMobile)}");
  print(objectId);
  role = prefs.getString(kUserData);
  print(role);
  number = await prefs.getString(kMobile);
  name = await prefs.getString(kname);
}

Future<void> setLanguage(Locale locale) async {
  language = await SharedPreferences.getInstance();
  print('@@@@${locale.languageCode}');
  await language.setString(kLangCode, locale?.languageCode ?? 'en');
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

Locale get storedLocale => Locale(language?.getString(kLangCode) ?? 'en');

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
    String name,
    String address,
    String number,
    String objectId,
    String pincode,
    String shop,
    String storeT,
    String gstT,
    String gstNo,
    String landmark,
    String city,
    String state,
    var imageFile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(kMobileNum, number);
  await prefs.setString(kname, name);
  await prefs.setString(kpincode, pincode);
  await prefs.setString(kShopName, shop);
  await prefs.setString(kStoreType, storeT);
  await prefs.setString(kGstType, gstT);
  await prefs.setString(kGstNo, gstNo);
  await prefs.setString(kLandmark, landmark);
  await prefs.setString(kCity, city);
  await prefs.setString(kState, state);
  await prefs.setString(kAddress, address);
  await prefs.setString(kObjectId, objectId);
  await prefs.setString(kImageFile, imageFile);
  pincode = await prefs.getString(kpincode);
  print(pincode);
}

Future<String> loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  number = await prefs.getString(kMobile);
  objectId = await prefs.getString(kObjectId);
  name = await prefs.getString(kname);
  pincode = await prefs.getString(kpincode);
  print(name);
}

void deleteUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(kUserData);
  await prefs.remove(kMobile);
  await prefs.remove(kname);
  await prefs.remove(kAddress);
  await prefs.remove(kMobileNum);
  await prefs.remove(kpincode);
  await prefs.remove(kOrderObjectId);
  print("@@@@@@ ${prefs.getString(kUserData)}");
  print("@@@@@@2 ${prefs.getString(kMobile)}");
  //objectId.value = null;
  name = null;
  print(objectId);
}

/*class RepoController extends GetxController {
  String kUserData = 'role';
  String kMobile = "mobile";
  String kname = "name";
  String kpincode = "pincode";
  String kShopName = "shop";
  String kStoreType = "store";
  String kGstType = "gstType";
  String kGstNo = "gstNo";
  String kLandmark = "landmark";
  var kImageFile = "imageFile";
  String kCity = "city";
  String kState = "state";
  String kAddress = "add";
  String kMobileNum = "mobileNo";
  String kObjectId = "objectId";
  String kOrderObjectId = "orderObId";
  String kLangCode = "languageCode";
  ParseUser currentUser;
  SharedPreferences language;
  String number;
  String name;
  String pincode;
  String objectId;
  String username;
  String role;
  String orderObjectId;

  Future<void> setUserData(String user, String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserData, user);
    await prefs.setString(kMobile, mobile);
    // objectId.value = user;
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print("@@@@@@2 ${prefs.getString(kMobile)}");
    print(objectId);
    role = prefs.getString(kUserData);
    print(role);
    number = await prefs.getString(kMobile);
    name = await prefs.getString(kname);
  }

  Future<void> setLanguage(Locale locale) async {
    language = await SharedPreferences.getInstance();
    print('@@@@${locale.languageCode}');
    await language.setString(kLangCode, locale?.languageCode ?? 'en');
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

  Locale get storedLocale => Locale(language?.getString(kLangCode) ?? 'en');

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
      String name,
      String address,
      String number,
      String objectId,
      String pincode,
      String shop,
      String storeT,
      String gstT,
      String gstNo,
      String landmark,
      String city,
      String state,
      var imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kMobileNum, number);
    await prefs.setString(kname, name);
    await prefs.setString(kpincode, pincode);
    await prefs.setString(kShopName, shop);
    await prefs.setString(kStoreType, storeT);
    await prefs.setString(kGstType, gstT);
    await prefs.setString(kGstNo, gstNo);
    await prefs.setString(kLandmark, landmark);
    await prefs.setString(kCity, city);
    await prefs.setString(kState, state);
    await prefs.setString(kAddress, address);
    await prefs.setString(kObjectId, objectId);
    await prefs.setString(kImageFile, imageFile);
    pincode = await prefs.getString(kpincode);
    print(pincode);
  }

  Future<String> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    number = await prefs.getString(kMobile);
    objectId = await prefs.getString(kObjectId);
    name = await prefs.getString(kname);
    pincode = await prefs.getString(kpincode);
    print(name);
  }

  void deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserData);
    await prefs.remove(kMobile);
    await prefs.remove(kname);
    await prefs.remove(kAddress);
    await prefs.remove(kMobileNum);
    await prefs.remove(kpincode);
    await prefs.remove(kOrderObjectId);
    print("@@@@@@ ${prefs.getString(kUserData)}");
    print("@@@@@@2 ${prefs.getString(kMobile)}");
    //objectId.value = null;
    name = null;
    print(objectId);
  }
}*/
