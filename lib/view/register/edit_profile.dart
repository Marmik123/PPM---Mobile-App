import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/widgets/tinted_title.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String number;
  final String shop;
  final String gstType;
  final String gstNo;
  final String storeT;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String address;
  final imageFile;

  const EditProfile(
      {Key key,
      this.name,
      this.number,
      this.shop,
      this.gstType,
      this.gstNo,
      this.storeT,
      this.landmark,
      this.city,
      this.state,
      this.pincode,
      this.address,
      this.imageFile})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  RepoController repoController = Get.put(RepoController());
  LoginController login = Get.put(LoginController());
  ClientController con = Get.put(ClientController());
  TextEditingController nController = TextEditingController();
  bool isNameC = false;
  bool isNumC = false;
  bool isGstT = false;
  bool isGstN = false;
  bool isShopN = false;
  bool isStoreT = false;
  bool isAddress = false;
  bool isCity = false;
  bool isState = false;
  bool isPincode = false;
  bool isLandmark = false;
  String NameC;
  String NumC;
  String GstT;
  String GstN;
  String ShopN;
  String StoreT;
  String Address;
  String City;
  String State;
  String Pincode;
  String Landmark;
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
  String initialNumber;
  final jobKey = GlobalKey<FormState>();
  RepoController rCtrl = Get.put(RepoController());
  final RoundedLoadingButtonController btnSubmit =
      new RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNameC = false;
    isNumC = false;
    isGstT = false;
    isGstN = false;
    isShopN = false;
    isStoreT = false;
    isAddress = false;
    isCity = false;
    isState = false;
    isPincode = false;
    isLandmark = false;
  }

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
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: Colors.black26,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TintedTitle(
                      title: 'Details',
                      icon: Icons.format_list_numbered_rounded,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
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
                            onFieldSubmitted: checkMobileNumber(
                                mController.text.trim().toString()),
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
                          TextFormField(
                            initialValue: widget.shop,
                            onChanged: (value) {
                              isShopN = true;
                              ShopN = value;
                            },
                            //controller: sNController,
                            decoration: InputDecoration(
                              labelText: S.of(context).sName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).errorS;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                              isExpanded: true,
                              value: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  isStoreT = true;
                                  selectedType = value;
                                });
                              },
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.green,
                              decoration: InputDecoration(
                                labelText: S.of(context).type,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      S.of(context).stat,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      S.of(context).Kirana,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      S.of(context).Dairy,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 3,
                                    child: Text(
                                      S.of(context).Vegetable,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 4,
                                    child: Text(
                                      S.of(context).Provision,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 5,
                                    child: Text(
                                      S.of(context).Medical,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ))
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                              isExpanded: true,
                              value: gst,
                              onChanged: (value) {
                                setState(() {
                                  isGstT = true;
                                  gst = value;
                                });
                              },
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.green,
                              decoration: InputDecoration(
                                labelText: S.of(context).gstType,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      S.of(context).regGst,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      S.of(context).compGst,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      S.of(context).woGst,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          gst == 0 || gst == 1
                              ? TextFormField(
                                  initialValue: widget.gstNo,
                                  onChanged: (value) {
                                    isGstN = true;
                                    GstN = value;
                                  },
                                  //controller: gstCon,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return S.of(context).errorNum;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: S.of(context).gstNo,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: Colors.black26,
                /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),

                    //   border: BoxBorder(
                    //     // borderRadius: BorderRadius.circular(10),
                    //     // borderSide: BorderSide(color: Colors.blueGrey),
                    //   ),
                  ),*/
                child: Column(
                  children: [
                    TintedTitle(
                      title: S.of(context).Address,
                      icon: Icons.add_location_alt_outlined,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
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
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RoundedLoadingButton(
                color: Colors.green,
                child: Text(
                  S.of(context).Save,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                borderRadius: 10,
                height: 35,
                width: 100,
                controller: btnSubmit,
                onPressed: () {
                  submitC(
                      isNameC ? NameC : widget.name,
                      isNumC ? NumC : widget.number,
                      isShopN ? ShopN : widget.shop,
                      isGstN ? GstN : widget.gstNo,
                      isAddress ? Address : widget.address,
                      isLandmark ? Landmark : widget.landmark,
                      isGstT
                          ? (gst == 0
                              ? 'Regular GST'
                              : gst == 1
                                  ? 'Composition GST'
                                  : 'Without GST')
                          : widget.gstType,
                      isStoreT
                          ? (selectedType == 0
                              ? 'Stationary'
                              : selectedType == 1
                                  ? 'Kirana'
                                  : selectedType == 2
                                      ? 'Dairy'
                                      : selectedType == 3
                                          ? 'Vegetable'
                                          : selectedType == 4
                                              ? 'Provision'
                                              : 'Medical')
                          : widget.storeT,
                      isCity ? City : widget.city,
                      isState ? State : widget.state,
                      widget.imageFile);
                }),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void submitC(name, number, shopName, gstNo, address, landmark, gst, store,
      city, state, imageFile) async {
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
          ..set('imageFileName', imageFile)
          ..set('city', city)
          ..set('state', state)
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
