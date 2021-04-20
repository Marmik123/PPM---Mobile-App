import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcm/controller/register/ad_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/repository/user_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AdRegister extends StatefulWidget {
  @override
  _AdRegisterState createState() => _AdRegisterState();
}

class _AdRegisterState extends State<AdRegister> {
  int selectedType = 0;
  RepoController repoController = Get.put(RepoController());
  AdController adCtrl = Get.put(AdController());
  final adKey = GlobalKey<FormState>();
  bool payment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Advertisement" /*S.of(context).client*/,
        ),
      ),
      body: Form(
          key: adKey,
          child: ListView(
            padding: EdgeInsets.all(10),
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
                  labelText: "Enter Ad Description" /*S.of(context).sName*/,
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
                onTap: () async => await adCtrl.adPhoto(ImageSource.camera),
                controller: adCtrl.sPController,
                decoration: InputDecoration(
                  labelText: "Enter Ad Photo" /*S.of(context).photo*/,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
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
                    activeColor: Colors.cyan,
                  ),
                  Text(
                    "Payment Received",
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
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
