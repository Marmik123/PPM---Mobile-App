import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
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
      ),
      body: Form(
          key: con.jobKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
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
                  onFieldSubmitted:
                      checkMobileNumber(con.mController.text.trim().toString()),
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
                          )),
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
                          )),
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
                          ))
                    ]),
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
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: con.sPController,
                  decoration: InputDecoration(
                    prefix: GestureDetector(
                      onTap: () async {
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
                                    onPressed: () async {
                                      await con.shopPhoto(ImageSource.camera);
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
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      await con.shopPhoto(ImageSource.gallery);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.upload_file),
                                        SizedBox(width: 10),
                                        Text('Gallery',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    ))
                              ],
                            ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 22,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: con.fileList().length,
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    Text(
                                      con.fileList()[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            con.fileList().removeAt(index);
                                            con
                                                .finalImageList()
                                                .removeAt(index);
                                            if (con.nameList()?.isNotEmpty) {
                                              con.nameList().removeAt(index);
                                            }
                                            print(
                                                "REMAINING ${con.fileList()}");
                                            print(
                                                "REMAINING ${con.nameList()}");
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.grey,
                                        ))
                                  ],
                                )),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.file_upload,
                          color: Colors.black,
                        )),
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
              controller: con.btnController,
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
                      con.uploadImg(
                          con.fileList[i].toString(), con.finalImageList[i]);
                    }
                  }
                }
                if (con.jobKey.currentState.validate() &&
                    con.isUploaded.value == true) {}
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  checkMobileNumber(String number) {
    login.checkMobileExist(number);
  }
}
