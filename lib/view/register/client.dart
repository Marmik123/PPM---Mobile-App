import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ClientRegister extends StatefulWidget {
  @override
  _ClientRegisterState createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<ClientRegister> {
  int selectedType = 0;

  ClientController con = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          con.role.value ? 'Register Distributor' : 'Register Client',
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
                  labelText: 'Name',
                  //enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Name';
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
                  labelText: 'Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Number';
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
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Shop Name';
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
                      return 'Enter Shop Name';
                    }
                    return null;
                  },
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.cyan,
                  decoration: InputDecoration(
                    labelText: "Enter Type of Store",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 0,
                        child: Text(
                          "Stationary",
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
                          "Kirana",
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
                          "Dairy",
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
                          "Vegetable",
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
                          "Provision",
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
                          "Medical",
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
              TextFormField(
                readOnly: true,
                onTap: () async => await con.shopPhoto(ImageSource.camera),
                controller: con.sPController,
                decoration: InputDecoration(
                  labelText: 'Shop photo',
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
                    Text(
                      'Address',
                    ),
                    TextFormField(
                      controller: con.aPController,
                      decoration: InputDecoration(
                        labelText: 'Address Line 1',
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
                        labelText: 'Landmark',
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
                      controller: con.cIController,
                      decoration: InputDecoration(
                        labelText: 'City',
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
                      controller: con.stController,
                      decoration: InputDecoration(
                        labelText: 'State',
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
            child: Text('Save'),
            borderRadius: 10,
            height: 35,
            width: 100,
            controller: con.btnController,
            onPressed: () {
              con.clientRegister();
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
