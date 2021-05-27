import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdController extends GetxController {
  RxInt adCount = 0.obs;
  RxBool isLoading = false.obs;
  PickedFile pickedFile;
  TextEditingController nController = TextEditingController();
  TextEditingController adDesc = TextEditingController();
  TextEditingController sPController = TextEditingController();
  RepoController repo = Get.put(RepoController());
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  Future<void> marketingReport() async {
    print("called marketing report");
    SharedPreferences sPref = await SharedPreferences.getInstance();
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('MarketingMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('markPName', sPref.getString(repo.kname))
            ..whereEqualTo('number', sPref.getString(repo.kMobile));

      ParseResponse response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print("no user exist creating new one");
          ParseObject newClient = ParseObject('MarketingMetadata')
            ..set<String>('markPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set<int>('adsRegistered', adCount.value);

          ParseResponse reportResult = await newClient.create();
          if (reportResult.success) {
            //rCtrl.setOrdersMetadataObjectId(reportResult.result['objectId']);
            //print(reportResult.result['objectId']);
            //rCtrl.loadObjId();
            //SharedPreferences preference =
            //  await SharedPreferences.getInstance();
            // print("@@@${preference.getString(rCtrl.kOrderObjectId)}");
          }
        } else {
          print("user already there updating purchaseCount");
          ParseObject client = response.result[0]
            ..set('markPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set('adsRegistered', adCount.value);

          ParseResponse reportResult = await client.save();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerAd(String name, String number, String paymentR) async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      ParseObject adData = ParseObject('Advertisement')
        ..set('adName', nController.text.trim().toString())
        ..set('adDescription', adDesc.text.trim().trim().toString())
        ..set<ParseFile>('adPhoto', ParseFile(File(pickedFile.path)))
        ..set('registeredBy', preferences.getString(repo.kname))
        ..set('number', preferences.getString(repo.kMobile))
        ..set('paymentReceived', paymentR);
      ParseResponse adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        btnController.success();

        nController.clear();
        adDesc.clear();
        sPController.clear();
        counts();
        Get.back();
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            S.of(Get.context).errorOc,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      btnController.error();
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          S.of(Get.context).errorOc,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }

  QueryBuilder showAds() {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      QueryBuilder<ParseObject> adData =
          QueryBuilder<ParseObject>(ParseObject('Advertisement'))
            ..orderByDescending('createdAt')
            ..whereEqualTo('number', repo.number)
            ..whereEqualTo('registeredBy', repo.name);

      return adData;
    } catch (e) {
      print(e);
    }
  }

  void counts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    QueryBuilder<ParseObject> adCountData =
        QueryBuilder<ParseObject>(ParseObject('Advertisement'))
          ..whereEqualTo('number', preferences.getString(repo.kMobile))
          ..whereEqualTo('registeredBy', preferences.getString(repo.kname));
    ParseResponse adResponse = await adCountData.count();
    if (adResponse.success && adResponse != null) {
      print('clientresponse.results ${adResponse.results}');
      print('adResponse.result[0] ${adResponse.results[0]}');
      adCount.value = adResponse.results[0] ?? 1;
      print("#!#!#!#!!#${adCount.value}");
    }

    final LiveQuery liveQuery = LiveQuery();
    Subscription subscription = await liveQuery.client.subscribe(adCountData);
    subscription.on(LiveQueryEvent.update, (value) {
      print('clientCount updating ${adCount.value} ');
      adCount.value++;
      print('adCount updated ${adCount.value} ');
    });
    subscription.on(LiveQueryEvent.create, (value) {
      print('adCount updating ${adCount.value} ');
      adCount.value++;
      print('adCount updated ${adCount.value} ');
    });
    subscription.on(LiveQueryEvent.delete, (value) {
      adCount.value--;
    });
    marketingReport();
  }

  Future<void> adPhoto(ImageSource source) async {
    final picker = ImagePicker();
    pickedFile = await picker.getImage(source: source, imageQuality: 50);
    print(pickedFile);
  }

  @override
  void onInit() {
    super.onInit();
    repo.loadUserData();
    counts();
    update();
  }
}
