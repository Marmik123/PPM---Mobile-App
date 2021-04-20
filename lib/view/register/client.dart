import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ClientRegister extends StatefulWidget {
  @override
  _ClientRegisterState createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<ClientRegister> {
  int selectedType = 0;
  int gst = 0;
  RepoController repoController = Get.put(RepoController());
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
                  value: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).sName;
                    }
                    return null;
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
                      gst = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).sName;
                    }
                    return null;
                  },
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.cyan,
                  decoration: InputDecoration(
                    labelText: "Enter Type of GST" /*S.of(context).type*/,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 0,
                        child: Text(
                          "Regular GST" /*S.of(context).stat*/,
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
                          "Composition GST" /*S.of(context).Kirana*/,
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
                          "Without GST" /*S.of(context).Dairy*/,
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
                      controller: con.gst,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "GST Number" /* S.of(context).City*/,
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
                onTap: () async => await con.shopPhoto(ImageSource.camera),
                controller: con.sPController,
                decoration: InputDecoration(
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Pincode" /* S.of(context).City*/,
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
                      initialValue: "Surat",
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
                      initialValue: "Gujarat",
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
          )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedLoadingButton(
            child: Text(S.of(context).Save),
            borderRadius: 10,
            height: 35,
            width: 100,
            controller: con.btnController,
            onPressed: () {
              con.clientRegister(
                  repoController.name,
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
                                      : 'Medical');
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
