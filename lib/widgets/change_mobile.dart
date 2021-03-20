// import 'package:Rapair_desk/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/repository/user_repository.dart';

class ChangeMobile extends StatefulWidget {
  final ParseObject user;

  const ChangeMobile({Key key, this.user}) : super(key: key);
  @override
  _ChangeMobileState createState() => _ChangeMobileState();
}

class _ChangeMobileState extends State<ChangeMobile> {
  final RoundedLoadingButtonController _btnSubmit =
      new RoundedLoadingButtonController();
  final _passKey = GlobalKey<FormState>();
  void _submit() async {
    try {
      userParse.set('number', passResetController.text);

      ParseResponse response = await userParse.save();
      if (response.success) {
        _btnSubmit.success();
      }
    } catch (e) {
      print(e);
      _btnSubmit.error();
    } finally {
      Future.delayed(Duration(milliseconds: 1500))
          .then((value) => _btnSubmit.reset());
    }
  }

  //await ParseUser.
  TextEditingController passResetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,
            right: 10,
            top: 10),
        child: Form(
          key: _passKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                controller: passResetController,
                // validator: (value) {
                //   if (value.isEmpty && value.length < 6) {
                //     return 'enter valid Mobile no';
                //   }
                //   return null;
                // },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Mobile',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                // controller: passResetController,
                validator: (value) {
                  if (value.isEmpty && value.length < 11) {
                    return 'enter valid Mobile no';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundedLoadingButton(
                child: Text(
                  'submit',
                  style: TextStyle(color: Colors.white),
                ),
                borderRadius: 10,
                height: 40,
                width: 100,
                controller: _btnSubmit,
                onPressed: () {
                  _submit();
                },
                // () => _passKey.currentState.validate()
                // ? _submit()
                // : Scaffold.of(context).showSnackBar(
                // SnackBar(content: Text(S.of(context).passFail))),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
