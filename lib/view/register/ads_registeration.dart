import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/register/ad_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/widgets/circular_loader.dart';
import 'package:pcm/widgets/tinted_title.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AdRegister extends StatefulWidget {
  @override
  _AdRegisterState createState() => _AdRegisterState();
}

class _AdRegisterState extends State<AdRegister> {
  int selectedType = 0;
  RepoController repoController = Get.put(RepoController());
  AdController adCtrl = Get.find<AdController>();
  final adKey = GlobalKey<FormState>();
  bool payment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).registerAd,
        ),
      ),
      body: Form(
        key: adKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  TintedTitle(
                    title: 'Advertisement Details',
                    icon: Icons.add_to_photos_outlined,
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
                          controller: adCtrl.nController,
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: adCtrl.adDesc,
                          decoration: InputDecoration(
                            labelText: S.of(context).adDesc,
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
                        TextFormField(
                          readOnly: true,
                          onTap: () => adCtrl.adPhoto(ImageSource.gallery),
                          controller: adCtrl.sPController,
                          decoration: InputDecoration(
                            labelText: S.of(context).adPhoto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: adCtrl.pickedFile != null ? 10 : 0,
                        ),
                        GetBuilder<AdController>(
                          builder: (_) {
                            return adCtrl.pickedFile != null
                                ? InkWell(
                                    onTap: () =>
                                        adCtrl.adPhoto(ImageSource.gallery),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                          future:
                                              adCtrl.pickedFile.readAsBytes(),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: payment,
                              onChanged: (bool newValue) {
                                setState(() {
                                  payment = newValue;
                                  print(payment);
                                });
                              },
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text(
                              S.of(context).paymentR,
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedLoadingButton(
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
            controller: adCtrl.btnController,
            onPressed: () {
              adCtrl.registerAd(repoController.name, repoController.number,
                  payment == true ? 'Yes' : 'No');
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
