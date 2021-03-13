import 'dart:io';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:loading_hud/loading_hud.dart';
// import 'package:loading_hud/loading_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pcm/repository/user_repository.dart';

class ClientController extends GetxController {
  TextEditingController nController = TextEditingController();

  TextEditingController sNController = TextEditingController();

  TextEditingController sPController = TextEditingController();

  TextEditingController aPController = TextEditingController();

  TextEditingController lController = TextEditingController();
  TextEditingController cIController = TextEditingController();

  TextEditingController aController = TextEditingController();

  TextEditingController stController = TextEditingController();
  TextEditingController slController = TextEditingController();

  TextEditingController cController = TextEditingController();
  TextEditingController mController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  final jobKey = GlobalKey<FormState>();
  Position position;
  RxBool role = false.obs;

  PickedFile pickedFile;

  Future<void> clientRegister() async {
    try {
      ParseObject userData = ParseObject('UserMetadata')
        ..set('name', nController.text)
        ..set('number', mController.text)
        ..set('address1', aPController.text)
        ..set('landmark', lController.text)
        ..set('city', cIController.text)
        ..set('state', stController.text)
        ..set('role', role.value ? 'Distributor' : 'Client');
      // ..set('status',
      //     widget.jobsData != null ? widget.jobsData.get('status') : 0)
      // ..set('client', client)
      ParseResponse resultUser = await userData.create();

      // ParseObject shopData = ParseObject('Shop')
      //   ..set('shopName', sNController.text)
      //   ..set('shopPhoto', ParseFile(File(pickedFile.path)))
      //   ..set('address1', aPController.text)
      //   ..set('landmark', lController.text)
      //   ..set('city', cIController.text)
      //   ..set('state', stController.text)
      //   ..set('user', resultUser.results)
      //   ..set(
      //       'shopLocation',
      //       ParseGeoPoint(
      //           latitude: position.latitude, longitude: position.longitude));
      //
      // ParseResponse resultShop = await shopData.create();

      if (resultUser.success //&& resultShop.success
          ) {
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
        // Get.back();
      }
    } catch (e) {
      btnController.error();
      print(e);
    } finally {
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => btnController.reset());
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
      print(position.latitude);
    }
  }
}
