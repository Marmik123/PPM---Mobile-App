import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:pcm/widgets/tinted_title.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ClientRegister extends StatefulWidget {
  @override
  _ClientRegisterState createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<ClientRegister> {
  RepoController repoController = Get.put(RepoController());
  LoginController login = Get.put(LoginController());
  ClientController con = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).client,
        ),
        elevation: 5,
        shadowColor: Colors.black26,
      ),
      body: Form(
        key: con.jobKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey.shade50,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black26,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'ppm_logo',
                        child: Image.asset(
                          'images/LOGO-02.png',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onTap: () {},
                        controller: con.nController,
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
                            con.btnController.reset();
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
                        keyboardType: TextInputType.number,
                        controller: con.mController,
                        onFieldSubmitted: checkMobileNumber(
                            con.mController.text.trim().toString()),
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
                        controller: con.sNController,
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
                        value: con.selectedType,
                        onChanged: (value) {
                          setState(() {
                            con.selectedType = value;
                          });
                        },
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelText: S.of(context).type,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
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
                            ),
                          ),
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
                            ),
                          ),
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
                            ),
                          ),
                          DropdownMenuItem(
                            value: 6,
                            child: Text(
                              S.of(context).Hotel,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 7,
                            child: Text(
                              S.of(context).Other,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        value: con.gst,
                        onChanged: (value) {
                          setState(() {
                            con.gst = value;
                          });
                        },
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelText: S.of(context).gstType,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
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
                            ),
                          ),
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
                            ),
                          ),
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
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      con.gst == 0 || con.gst == 1
                          ? TextFormField(
                              controller: con.gstCon,
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
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select ID proof';
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          setState(() {});
                          con.isUploaded.value = false;
                          return Get.defaultDialog(
                            title: 'Choose from',
                            titleStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            content: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    con.shopPhoto(ImageSource.camera);
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
                                  onPressed: () {
                                    con.shopPhoto(ImageSource.gallery);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.upload_file),
                                      SizedBox(width: 10),
                                      Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        readOnly: true,
                        controller: con.sPController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.file_upload,
                            color: Colors.black,
                          ),
                          labelText: S.of(context).photo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                          // suffix: con.pickedFile ==null
                          //     ?SizedBox.shrink()
                          //     :Container(
                          //   height: 25,
                          //   width: 25,
                          //   child: ClipRRect(
                          //
                          //     child: Image.file(
                          //       con.pickedFile,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                        ),

                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return S.of(context).entVAmount;
                        //   }
                        //   return null;
                        // },
                        //keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: con.pickedFile != null ? 10 : 0,
                      ),
                      GetBuilder<ClientController>(
                        builder: (_) {
                          return con.pickedFile != null
                              ? InkWell(
                                  onTap: () {
                                    con.pickPhoto();
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shadowColor: Colors.black54,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.white,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return buildSmallLoader(
                                              color: Colors.green,
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(
                                                snapshot.data,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else {
                                            return SizedBox.shrink();
                                          }
                                        },
                                        future: con.pickedFile.readAsBytes(),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black26,
                elevation: 5,
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: con.aPController,
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
                            controller: con.lController,
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
                            controller: con.pincode,
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
                            // controller: con.cIController,
                            initialValue: S.of(context).surat,
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
                            //controller: con.stController,
                            initialValue: S.of(context).Gujarat,
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
              //   controller: con.cController,
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
      bottomNavigationBar: Container(
        color: Colors.green.shade100,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: RoundedLoadingButton(
            child: Text(
              S.of(context).Save,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            borderRadius: 10,
            height: 35,
            width: 100,
            controller: con.btnController,
            color: Colors.green,
            onPressed: () {
              /* if (con.isUploaded.value == false) {
                    con.btnController.reset();
                    Get.snackbar(
                        'No ID Document Uploaded', 'Please upload the ID Proof',
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
                  }*/
              if (con.jobKey.currentState.validate()) {
                if (con.fileList.isNotEmpty) {
                  for (var i = 0; i < con.fileList()?.length; i++) {
                    print('Starting with client registration');
                    con.uploadImg(
                        con.fileList[i].toString(), con.finalImageList[i]);
                  }
                } else {
                  con.btnController.reset();
                }
              } else {
                con.btnController.reset();
              }
              /*if (con.jobKey.currentState.validate() &&
                  con.isUploaded() == true) {}*/
            },
          ),
        ),
      ),
    );
  }

  checkMobileNumber(String number) {
    login.checkMobileExist(number);
  }
}
