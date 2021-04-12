import 'package:get_storage/get_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

String kUserData = "user_data";
ParseUser currentUser;

void setUserData(ParseUser user) {
  GetStorage storage = GetStorage();
  storage.write(kUserData, user);
  currentUser = user;
}

void loadUserData() {
  GetStorage storage = GetStorage();
  currentUser = storage.read(kUserData);
}
