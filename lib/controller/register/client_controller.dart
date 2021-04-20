import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:loading_hud/loading_hud.dart';
// import 'package:loading_hud/loading_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pcm/repository/user_repository.dart';

class ClientController extends GetxController {
  TextEditingController nController = TextEditingController();

  TextEditingController sNController = TextEditingController();

  TextEditingController sPController = TextEditingController();

  TextEditingController aPController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController gst = TextEditingController();

  TextEditingController lController = TextEditingController();
  TextEditingController cIController = TextEditingController();

  TextEditingController aController = TextEditingController();

  TextEditingController stController = TextEditingController();
  TextEditingController slController = TextEditingController();

  TextEditingController cController = TextEditingController();
  TextEditingController mController = TextEditingController();
  RepoController repo = Get.put(RepoController());
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  final jobKey = GlobalKey<FormState>();
  Position position;
  RxBool role = false.obs;

  PickedFile pickedFile;
  RxInt clientCount = 0.obs;
  RxInt distributorCount = 0.obs;
  ParseObject userData;
  Future<void> clientRegister(String name, String gstType, String store) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      userData = ParseObject('UserMetadata')
        ..set('name', nController.text)
        ..set('number', mController.text)
        ..set('address1', aPController.text)
        ..set('landmark', lController.text)
        ..set('city', cIController.text)
        ..set('state', stController.text)
        ..set('pincode', pincode.text)
        ..set('gstNumber', gst.text)
        ..set('gstType', gstType)
        ..set('storeType', store)
        ..set('registeredBy', name)
        ..set('salesNumber', preferences.getString(repo.kMobile))
        ..set('role', 'Client');
      // ..set('status',
      //     widget.jobsData != null ? widget.jobsData.get('status') : 0)
      // ..set('client', client)
      ParseResponse resultUser = await userData.create();

      ParseObject shopData = ParseObject('Shop')
        ..set('shopName', sNController.text)
        ..set('shopPhoto', ParseFile(File(pickedFile.path)))
        ..set('address1', aPController.text)
        ..set('landmark', lController.text)
        ..set('city', cIController.text)
        ..set('state', stController.text)
        ..set('user', resultUser.result)
        ..set(
            'shopLocation',
            ParseGeoPoint(
                latitude: position.latitude, longitude: position.longitude));

      ParseResponse resultShop = await shopData.create();
      print(resultUser.result);
      if (resultUser.success && resultShop.success) {
        btnController.success();
        nController.clear();
        sNController.clear();
        sPController.clear();
        aPController.clear();
        lController.clear();
        cIController.clear();
        aController.clear();
        stController.clear();
        slController.clear();
        cController.clear();
        mController.clear();
        if (role.value) {
          distributorCount.value++;
        } else {
          clientCount.value++;
        }
      }
    } catch (e) {
      btnController.error();
      print(e);
    } finally {
      /*Future.delayed(Duration(milliseconds: 1500))
          .then((value) => btnController.reset());*/
      Get.back();
    }
  }

  Future<void> shopPhoto(ImageSource source) async {
    final picker = ImagePicker();

    pickedFile = await picker.getImage(source: source, imageQuality: 50);
    print(pickedFile);
    _determinePosition();
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    } else {
      print('location available');
      position = await Geolocator.getCurrentPosition();
      //print(position.latitude);
    }
  }

  void counts(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    QueryBuilder<ParseObject> clientCountData =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..whereEqualTo('role', 'Client')
          ..whereEqualTo('registeredBy', preferences.getString(repo.kname))
          ..whereEqualTo('salesNumber', preferences.getString(repo.kMobile));
    ParseResponse clientResponse = await clientCountData.count();
    if (clientResponse.success && clientResponse != null) {
      print('clientresponse.results ${clientResponse.results}');
      print('clientResponse.result[0] ${clientResponse.result[0]}');
      clientCount.value = clientResponse.result[0] ?? 0;
    }
    QueryBuilder<ParseObject> distributorCountData =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..whereEqualTo('role', 'Distributor');
    ParseResponse distributorResponse = await distributorCountData.count();
    if (distributorResponse.success && distributorResponse != null) {
      distributorCount.value = distributorResponse.result[0];
    }
    final LiveQuery liveQuery = LiveQuery();
    Subscription subscription =
        await liveQuery.client.subscribe(clientCountData);
    subscription.on(LiveQueryEvent.update, (value) {
      print('clientCount updating ${clientCount.value} ');
      clientCount.value++;
      print('clientCount updated ${clientCount.value} ');
    });
    subscription.on(LiveQueryEvent.create, (value) {
      print('clientCount updating ${clientCount.value} ');
      clientCount.value++;
      print('clientCount updated ${clientCount.value} ');
    });

    subscription.on(LiveQueryEvent.delete, (value) {
      clientCount.value--;
    });
  }

  QueryBuilder showClients() {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      QueryBuilder<ParseObject> clients =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..orderByDescending('createdAt')
            ..whereEqualTo('salesNumber', repo.number)
            ..whereEqualTo('registeredBy', repo.name);

      return clients;
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    counts(repo.name);
    repo.loadUserData();
    update();
  }
}
