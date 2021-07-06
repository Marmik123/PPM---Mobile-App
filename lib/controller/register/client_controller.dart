import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as p;
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/register/document_verification.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:pcm/repository/shared_preferences.dart';

class ClientController extends GetxController {
  LoginController login = Get.put(LoginController());
  TextEditingController nController = TextEditingController();

  TextEditingController sNController = TextEditingController();

  TextEditingController sPController = TextEditingController();

  TextEditingController aPController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController gstCon = TextEditingController();

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
  RxBool isLoading = false.obs;
  RxBool isUploaded = false.obs;
  PickedFile pickedFile;
  RxList nameList = [].obs;
  RxList fileList = [].obs;
  RxList finalImageList = [].obs;
  RxList registeredDetails = [].obs;
  int selectedType = 0;
  int gst = 0;
  Uint8List selectedImage;
  RxInt clientCount = 0.obs;
  RxInt distributorCount = 0.obs;
  RxString filename = ''.obs;
  ParseObject userData;
  RepoController repoController = Get.put(RepoController());

  Future<void> clientRegister(String name, String gstType, String store,
      String city, String state) async {
    var preferences = await SharedPreferences.getInstance();
    try {
      userData = ParseObject('UserMetadata')
        ..set('name', nController.text)
        ..set('number', mController.text)
        ..set('address1', aPController.text)
        ..set('landmark', lController.text)
        ..set('city', 'Surat')
        ..set('state', 'Gujarat')
        ..set('shopName', sNController.text)
        ..set('pincode', pincode.text)
        ..set('gstNumber', gstCon.text)
        ..set('gstType', gstType)
        ..set('storeType', store)
        ..set('registeredBy', name)
        ..set('imageFileName',
            List.generate(nameList()?.length, (index) => nameList()[index]))
        ..set('isVerified', name == 'Direct' ? 'No' : 'Yes')
        ..set('salesNumber', preferences.getString(repo.kMobile))
        ..set('role', 'Client');
      // ..set('status',
      //     widget.jobsData != null ? widget.jobsData.get('status') : 0)
      // ..set('client', client)
      var resultUser = await userData.create();

      var shopData = ParseObject('Shop')
        ..set('shopName', sNController.text)
        ..set('shopPhoto', ParseFile(File(pickedFile.path)))
        ..set('address1', aPController.text)
        ..set('landmark', lController.text)
        ..set('city', cIController.text)
        ..set('state', stController.text)
        ..set('user', resultUser.result);
      // ..set(
      //     'shopLocation',
      //     ParseGeoPoint(
      //         latitude: position.latitude, longitude: position.longitude));

      var resultShop = await shopData.create();
      print(resultUser.result);
      registeredDetails.add(resultUser.result);
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
        gstCon.clear();
        fileList.clear();
        nameList.clear();
        finalImageList.clear();
        pincode.clear();
        pickedFile = null;
        update();
        salesReport();
        // name == 'Direct' ? Get.to(() => DocumentVerification()) : Get.back();
        /* Get.defaultDialog(
          title: 'Documents Are Under Verification',
          barrierDismissible: false,
          content: SingleChildScrollView(child: DocumentVerification()),
        );*/
        if (role.value) {
          distributorCount.value++;
        } else {
          clientCount.value++;
        }
        btnController.reset();
        await Get.back(result: true);
      }
    } catch (e) {
      print('ERROR ERROR');
      btnController.error();
      print(e);
      await Future.delayed(Duration(milliseconds: 300))
          .then((value) => btnController.reset());
    }
  }

  Future<void> salesReport() async {
    print('called sales report');
    var sPref = await SharedPreferences.getInstance();
    try {
      var userData = QueryBuilder<ParseObject>(ParseObject('SalesMetadata'))
        //ParseObject userData = ParseObject('UserMetadata')
        ..whereEqualTo('salesPName', sPref.getString(repo.kname))
        ..whereEqualTo('number', sPref.getString(repo.kMobile));

      var response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print('no user exist creating new one');
          var newClient = ParseObject('SalesMetadata')
            ..set<String>('salesPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set<int>('clientsRegistered', clientCount.value);

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
            ..set('salesPName', sPref.getString(repo.kname))
            ..set('number', sPref.getString(repo.kMobile))
            ..set('clientsRegistered', clientCount.value);

          var reportResult = await client.save();
        }
      }
    } catch (e) {
      print(e);
    }
  }

/*
  Future<void> chooseFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
      allowCompression: true,
    );
    try {
      print("picked file $pickedFile");
      if (pickedFile != null) {
        PlatformFile file = pickedFile.files.first;
        print(file.name);
        filename.value = file.name;
        print(file.bytes.length);
        selectedImage = file.bytes;
        finalImageList.add(selectedImage);
        nameList().add(filename.value);
        print(finalImageList.length.toString());
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      return e;
    }
  }
*/

  void pickPhoto() {
    isUploaded.value = false;
    Get.defaultDialog(
      title: 'Choose from',
      titleStyle: GoogleFonts.montserrat(
        fontSize: 15,
      ),
      content: Column(
        children: [
          TextButton(
            onPressed: () async {
              await shopPhoto(
                ImageSource.camera,
              );
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(width: 10),
                Text(
                  'Camera',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await shopPhoto(ImageSource.gallery);
            },
            child: Row(
              children: [
                Icon(Icons.upload_file),
                SizedBox(width: 10),
                Text('Gallery', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> shopPhoto(ImageSource source) async {
    final picker = ImagePicker();

    pickedFile = await picker.getImage(source: source, imageQuality: 50);
    print(pickedFile);
    if (pickedFile != null) Get.back();

    filename.value = p.basename(pickedFile.path);
    sPController.text = filename();
    selectedImage = await pickedFile.readAsBytes();
    finalImageList.add(selectedImage);
    fileList().add(filename.value);
    print(fileList());
    update();
    //_determinePosition();
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
        isUploaded.value = true;
        print(repoController.name);
        /*Get.snackbar(
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
        );*/
        await clientRegister(
            repoController.name ?? 'Direct',
            gst == 0
                ? 'Regular GST'
                : gst == 1
                    ? 'Composition GST'
                    : 'Without GST',
            selectedType == 0
                ? 'Stationary'
                : selectedType == 1
                    ? 'Kirana'
                    : selectedType == 2
                        ? 'Dairy'
                        : selectedType == 3
                            ? 'Vegetable'
                            : selectedType == 4
                                ? 'Provision'
                                : selectedType == 5
                                    ? 'Medical'
                                    : selectedType == 6
                                        ? 'Hotel'
                                        : 'Other',
            cIController.text ?? 'Surat',
            stController.text ?? 'Gujarat');
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

/*
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
*/

  void counts(String name) async {
    print('Name passed from RepoContr ::: $name');
    var preferences = await SharedPreferences.getInstance();
    var clientCountData = QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
      ..whereEqualTo('role', 'Client')
      ..whereEqualTo('registeredBy', preferences.getString(repo.kname))
      ..whereEqualTo('salesNumber', preferences.getString(repo.kMobile));
    var clientResponse = await clientCountData.count();
    if (clientResponse.success &&
        clientResponse != null &&
        clientResponse.result != null) {
      // print('clientresponse.results ${clientResponse.results}');
      // print('clientResponse.result[0] ${clientResponse.result[0]}');
      clientCount.value = clientResponse.result[0] ?? 0;
    }
    var distributorCountData =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..whereEqualTo('role', 'Distributor');
    var distributorResponse = await distributorCountData.count();
    if (distributorResponse.success &&
        distributorResponse != null &&
        distributorResponse.result != null) {
      distributorCount.value = distributorResponse.result[0];
    }
    final liveQuery = LiveQuery();
    var subscription = await liveQuery.client.subscribe(clientCountData);
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

  QueryBuilder isDocumentVerifiedAtSignIn() {
    try {
      print('####');
      print(login.oldData[0][0]['objectId']);
      var doc = QueryBuilder(ParseObject('UserMetadata'))
        ..orderByDescending('updatedAt')
        ..whereEqualTo('objectId', login.oldData[0][0]['objectId']);
      return doc;
    } catch (e) {
      print(e);
      Get.snackbar(S.of(Get.context).errorOc, '');
    }
  }

  QueryBuilder isDocumentVerified() {
    print('####');
    print(registeredDetails[0]['objectId']);
    try {
      var doc = QueryBuilder(ParseObject('UserMetadata'))
        ..orderByDescending('updatedAt')
        ..whereEqualTo('objectId', registeredDetails[0]['objectId']);
      return doc;
    } catch (e) {
      print(e);
    }
  }

  QueryBuilder showClients() {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var clients = QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
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
