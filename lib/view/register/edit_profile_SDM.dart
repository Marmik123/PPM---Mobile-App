import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Edit extends StatefulWidget {
  final String name;
  final String number;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String address;
  final imageFile;

  const Edit(
      {Key key,
      this.name,
      this.number,
      this.landmark,
      this.city,
      this.state,
      this.pincode,
      this.address,
      this.imageFile})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool isNameC = false;
  bool isNumC = false;
  bool isAddress = false;
  bool isCity = false;
  bool isState = false;
  bool isPincode = false;
  bool isLandmark = false;
  String NameC;
  String NumC;
  String Address;
  String City;
  String State;
  String Pincode;
  String Landmark;
  RepoController repoController = Get.put(RepoController());
  LoginController login = Get.put(LoginController());
  ClientController con = Get.put(ClientController());
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
  int gst = 0;
  int selectedType = 0;
  TextEditingController cController = TextEditingController();
  TextEditingController mController = TextEditingController();
  final jobKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnSubmit =
      new RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editProfile,
        ),
      ),
      body: Form(
          key: jobKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                TextFormField(
                  onTap: () {},
                  initialValue: widget.name.toString(),
                  onChanged: (value) {
                    isNameC = true;
                    NameC = value;
                  },
                  //controller: nController,
                  decoration: InputDecoration(
                    labelText: S.of(context).Name,
                    //enabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      btnSubmit.reset();
                      return S.of(context).errorName;
                    }
                    return null;
                  },
                  //if () {

                  // style: TextStyle(
                  //     color: client.get('flagged') ? Colors.red : Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.number,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    isNumC = true;
                    NumC = value;
                  },
                  //controller: mController,
                  onFieldSubmitted:
                      checkMobileNumber(mController.text.trim().toString()),
                  decoration: InputDecoration(
                    labelText: S.of(context).Number,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).errorNum;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),

                    //   border: BoxBorder(
                    //     // borderRadius: BorderRadius.circular(10),
                    //     // borderSide: BorderSide(color: Colors.blueGrey),
                    //   ),
                  ),
                  child: Column(
                    children: [
                      Text(S.of(context).Address),
                      TextFormField(
                        initialValue: widget.address,
                        onChanged: (value) {
                          isAddress = true;
                          Address = value;
                        },
                        //controller: aPController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorC;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: S.of(context).AddressL,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          isLandmark = true;
                          Landmark = value;
                        },
                        initialValue: widget.landmark,
                        //controller: lController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorC;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: S.of(context).Landmark,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: widget.pincode,
                        onChanged: (value) {
                          isPincode = true;
                          Pincode = value;
                        },
                        //controller: pincode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorC;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: S.of(context).pincode,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          isCity = true;
                          City = value;
                        },
                        // controller: cIController,
                        initialValue: widget.city,
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorC;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: S.of(context).City,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          isState = true;
                          State = value;
                        },
                        //controller: stController,
                        initialValue: widget.state,
                        validator: (value) {
                          if (value.isEmpty) {
                            return S.of(context).errorC;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: S.of(context).State,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // TextFormField(
                //   controller: cController,
                //   decoration: InputDecoration(
                //     labelText: S.of(context).comments,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color: Colors.blueGrey),
                //     ),
                //   ),
                //   maxLines: null,
                //   keyboardType: TextInputType.multiline,
                // ),
              ],
            ),
          )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RoundedLoadingButton(
                child: Text(S.of(context).Save),
                borderRadius: 10,
                height: 35,
                width: 100,
                controller: btnSubmit,
                onPressed: () {
                  submitSDM(
                    isNameC ? NameC : widget.name,
                    isNumC ? NumC : widget.number,
                    isAddress ? Address : widget.address,
                    isLandmark ? Landmark : widget.landmark,
                    isCity ? City : widget.city,
                    isState ? State : widget.state,
                    isPincode ? Pincode : widget.pincode,
                    widget.imageFile,
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void submitSDM(
      name, number, address, landmark, city, state, pincode, imageFile) async {
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('objectId', repoController.objectId);

      ParseResponse response = await userData.query();
      if (response.success) {
        ParseObject user = response.result[0]
          ..set('name', name)
          ..set('city', city)
          ..set('pincode', pincode)
          ..set('state', state)
          ..set('address1', address)
          ..set('landmark', landmark)
          ..set('imageFileName', imageFile)
          ..set('number', number);
        print(userData);
        ParseResponse result = await user.save();
        if (result.success) {
          btnSubmit.success();
        }
      }
    } catch (e) {
      print(e);
      btnSubmit.error();
    } finally {
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => btnSubmit.reset());
    }
  }

  void submitC(name, number, shopName, gstNo, address, landmark, gst, store,
      city, state) async {
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('role', 'Client')
            ..whereEqualTo('objectId', repoController.objectId);

      ParseResponse response = await userData.query();
      if (response.success) {
        ParseObject user = response.result[0]
          ..set('name', name)
          ..set('shopName', shopName)
          ..set('gstNumber', gstNo)
          ..set('gstType', gst)
          ..set('storeType', store)
          /*..set('city',city)
          ..set('state',state)*/
          ..set('address1', address)
          ..set('landmark', landmark)
          ..set('number', number);
        print(userData);
        ParseResponse result = await user.save();
        if (result.success) {
          btnSubmit.success();
        }
      }
    } catch (e) {
      print(e);
      btnSubmit.error();
    } finally {
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => btnSubmit.reset());
    }
  }

  checkMobileNumber(String number) {
    login.checkMobileExist(number);
  }
}
