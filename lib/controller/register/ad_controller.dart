import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdController extends GetxController {
  RxInt adCount = 0.obs;
  RxBool isLoading = false.obs;
  PickedFile pickedFile;
  int gst = 0;
  bool payment = false;
  RxString filename = ''.obs;
  RxList nameList = [].obs;
  RxList fileList = [].obs;
  RxList finalImageList = [].obs;
  TextEditingController nController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController gstTypeController = TextEditingController();
  TextEditingController adDesc = TextEditingController();
  TextEditingController sPController = TextEditingController();
  RepoController repo = Get.put(RepoController());
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  Future<void> marketingReport() async {
    print('called marketing report');
    var sPref = await SharedPreferences.getInstance();
    try {
      var userData = QueryBuilder<ParseObject>(ParseObject('MarketingMetadata'))
        //ParseObject userData = ParseObject('UserMetadata')
        ..whereEqualTo('markPName', sPref.getString(repo.kname))
        ..whereEqualTo('number', sPref.getString(repo.kMobile));

      var response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print('no user exist creating new one');
          var newClient = ParseObject('MarketingMetadata')
            ..set<String>('markPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set<int>('adsRegistered', adCount.value);

          var reportResult = await newClient.create();
          if (reportResult.success) {
            //rCtrl.setOrdersMetadataObjectId(reportResult.result['objectId']);
            //print(reportResult.result['objectId']);
            //rCtrl.loadObjId();
            //SharedPreferences preference =
            //  await SharedPreferences.getInstance();
            // print("@@@${preference.getString(rCtrl.kOrderObjectId)}");
          }
        } else {
          print('user already there updating purchaseCount');
          ParseObject client = response.result[0]
            ..set('markPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set('adsRegistered', adCount.value);

          var reportResult = await client.save();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerAd(String name, String number, String paymentR) async {
    isLoading.value = true;
    var preferences = await SharedPreferences.getInstance();
    try {
      var adData = ParseObject('Advertisement')
        ..set('adName', nController.text.trim().toString())
        ..set('adDescription', adDesc.text.trim().trim().toString())
        ..set<ParseFile>('adPhoto', ParseFile(File(pickedFile.path)))
        ..set('registeredBy', preferences.getString(repo.kname))
        ..set('number', preferences.getString(repo.kMobile))
        ..set('imageFileName',
            List.generate(nameList()?.length, (index) => nameList()[index]))
        ..set('gstNo', preferences.getString(gstNoController.text.trim()))
        ..set('paymentReceived', paymentR);
      var adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        btnController.success();
        nController.clear();
        gstNoController.clear();
        gstTypeController.clear();
        adDesc.clear();
        sPController.clear();
        nameList.clear();
        fileList.clear();
        finalImageList.clear();
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
      print('default error---' + e.toString());
      final snackBar = SnackBar(
        content: Text(
          S.of(Get.context).errorOc,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print('Finally executed');
    }
  }

  QueryBuilder showAds() {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var adData = QueryBuilder<ParseObject>(ParseObject('Advertisement'))
        ..orderByDescending('createdAt')
        ..whereEqualTo('number', repo.number)
        ..whereEqualTo('registeredBy', repo.name);
      print('#@#$adData');
      counts();
      return adData;
    } catch (e) {
      print(e);
    }
  }

  void counts() async {
    var preferences = await SharedPreferences.getInstance();
    var adCountData = QueryBuilder<ParseObject>(ParseObject('Advertisement'))
      ..whereEqualTo('number', preferences.getString(repo.kMobile))
      ..whereEqualTo('registeredBy', preferences.getString(repo.kname));
    var adResponse = await adCountData.count();
    if (adResponse.success && adResponse != null) {
      print('clientresponse.results ${adResponse.results}');
      print('adResponse.result[0] ${adResponse.results[0]}');
      adCount.value = adResponse.results[0] ?? 1;
      print('#!#!#!#!!#${adCount.value}');
    }

    final liveQuery = LiveQuery();
    var subscription = await liveQuery.client.subscribe(adCountData);
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
    print(pickedFile.path);

    sPController.text = basename(pickedFile.path);
    filename(basename(pickedFile.path));
    fileList.add(filename);
    nameList.clear();
    finalImageList.add(await pickedFile.readAsBytes());
    if (fileList.isNotEmpty) {
      for (var i = 0; i < fileList()?.length; i++) {
        print('Starting with client registration');
        uploadImg(fileList[i].toString(), finalImageList[i]);
      }
    }
    update();
  }

  Future<void> uploadImg(String filename, selectedImage) async {
    isLoading.value = true;

    try {
      var url = 'https://api.ppmstore.in/product/upload/image';
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      var multipartFile = http.MultipartFile.fromBytes('image', selectedImage,
          filename: filename,
          contentType: MediaType('application', 'octet-stream'));
      request.files.add(multipartFile);

      var result = await http.Response.fromStream(await request.send());
      print('Result: ${result.statusCode}');
      print(result.body.trArgs());
      print(result.body);
      var json = jsonDecode(result.body);
      print(json);
      print(json['file']);
      nameList().add(json['file']);
      if (result.statusCode != 200) {
        isLoading.value = false;
        print('FILE UPLOAD FAILED');
        Get.snackbar(
          S.of(Get.context).errorOc,
          S.of(Get.context).fileUploadFail,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(5),
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: MediaQuery.of(Get.context).size.width,
          isDismissible: true,
          dismissDirection: SnackDismissDirection.VERTICAL,
          colorText: Colors.white,
          icon: Icon(Icons.cancel),
        );
      } else {
        print('FILE UPLOAD SUCCESS');
        isLoading.value = false;
        //isUploaded.value = true;
        print(repo.name);
        Get.snackbar(
          S.of(Get.context).photoSuccess,
          S.of(Get.context).actionS,
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(5),
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: MediaQuery.of(Get.context).size.width,
          isDismissible: true,
          dismissDirection: SnackDismissDirection.VERTICAL,
          colorText: Colors.white,
          icon: Icon(Icons.check_circle),
        );
      }
    } catch (e) {
      isLoading.value = false;
      print('Error while uploding Image $e');
      Get.snackbar(S.of(Get.context).errorOc, '',
          backgroundColor: Colors.cyan,
          margin: const EdgeInsets.all(5),
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: MediaQuery.of(Get.context).size.width,
          isDismissible: true,
          dismissDirection: SnackDismissDirection.VERTICAL,
          colorText: Colors.white,
          icon: Icon(Icons.cancel),
          backgroundGradient:
              LinearGradient(colors: [Colors.teal, Colors.cyan]));
    }
  }

  @override
  void onInit() {
    super.onInit();
    repo.loadUserData();
    counts();
    update();
  }
}
