import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/register/edit_profile.dart';
import 'package:pcm/view/register/edit_profile_SDM.dart';
import 'package:pcm/widgets/change_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String langCode;
  RepoController ctrl = Get.put(RepoController());
  LoginController login = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {});
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
          S.of(context).Settings,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangeLanguage(),
                  ).then((value) async {
                    if (value != null) {
                      print('this is the value $value');
                      setState(() {
                        langCode = value;
                      });
                      print(langCode);
                      await ctrl.setLanguage(Locale(langCode));
                      setState(() {});
                    }
                  });
                },
                leading: Icon(Icons.language),
                title: Text(S.of(context).change),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  var role = pref.getString(ctrl.kUserData);
                  var address = pref.getString(ctrl.kAddress);
                  var number = await pref.getString(ctrl.kMobile);
                  var name = await pref.getString(ctrl.kname);
                  var pincode = await pref.getString(ctrl.kpincode);
                  var landmark = await pref.getString(ctrl.kLandmark);
                  var city = await pref.getString(ctrl.kCity);
                  var state = await pref.getString(ctrl.kState);
                  var gstType = await pref.getString(ctrl.kGstType);
                  var gstNo = await pref.getString(ctrl.kGstNo);
                  var storeT = await pref.getString(ctrl.kStoreType);
                  var shopN = await pref.getString(ctrl.kShopName);
                  var imageFile = await pref.getString(ctrl.kImageFile);
                  role == 'Client'
                      ? Get.to(() => EditProfile(
                            address: address,
                            city: city,
                            gstNo: gstNo,
                            gstType: gstType,
                            landmark: landmark,
                            name: name,
                            number: number,
                            pincode: pincode,
                            shop: shopN,
                            state: state,
                            storeT: storeT,
                            imageFile: imageFile,
                          ))
                      : Get.to(() => Edit(
                            imageFile: imageFile,
                            state: state,
                            pincode: pincode,
                            number: number,
                            name: name,
                            landmark: landmark,
                            city: city,
                            address: address,
                          ));
                  /*showModalBottomSheet(
                      context: context, builder: (context) => EditProfile());*/
                  // ).then((value) async {
                  //   if (value != null) {
                  //     setState(() {
                  //       sharedPresf = value;
                  //     });
                  //     await setLang(Locale(sharedPresf));
                  //     setState(() {});
                  //   }
                },
                leading: Icon(Icons.person),
                title: Text(S.of(context).editProfile),
              ),
            ),
            /* Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangeMobile(),
                  );
                  // ).then((value) async {
                  //   if (value != null) {
                  //     setState(() {
                  //       sharedPresf = value;
                  //     });
                  //     await setLang(Locale(sharedPresf));
                  //     setState(() {});
                  //   }
                },
                leading: Icon(Icons.mobile_friendly),
                title: Text(S.of(context).changeMob),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangeName(),
                  ).then((value) async {
                    if (value != null) {
                      print('this is the value $value');
                      setState(() {
                        langCode = value;
                      });
                      print(langCode);
                      //await setLang(Locale(langCode));

                      setState(() {});
                    }
                  });
                },
                leading: Icon(Icons.person),
                title: Text(S.of(context).changeN),
              ),
            )*/
            // Card(
            //   child: ListTile(
            //     onTap: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) => ChangeMobile(),);
            //       // ).then((value) async {
            //       //   if (value != null) {
            //       //     setState(() {
            //       //       sharedPresf = value;
            //       //     });
            //       //     await setLang(Locale(sharedPresf));
            //       //     setState(() {});
            //       //   }
            //
            //     },
            //     leading: Icon(Icons.handyman),
            //     title: Text('Edit Profile'/*S.of(context).jobs*/),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
