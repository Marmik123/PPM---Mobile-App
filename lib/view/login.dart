import 'package:flutter/material.dart';
import 'package:pcm/controller/login_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  LoginController loginCon = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[50],
        body: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black12,
                      Colors.blue[100],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.7],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        // color: Colors.transparent,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Form(
                            key: loginCon.key,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    readOnly:
                                        loginCon.isLoading.value ? true : false,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile No',
                                      // S.of(context).user,
                                      prefixIcon: Icon(Icons.people),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                    ),
                                    controller: loginCon.userController,
                                    onSaved: null,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Valid Mobile Number';
                                        // S.of(context).entUName;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    readOnly:
                                        loginCon.isLoading.value ? true : false,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      // S.of(context).password,
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                    ),
                                    obscureText: true,
                                    controller: loginCon.passController,
                                    onSaved: null,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Password';
                                        // S.of(context).entPass;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      color: Theme.of(context).accentColor,
                                      child: loginCon.isLoading.value
                                          ? SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ))
                                          : Text('Login',
                                              // S.of(context).login,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                      onPressed: () {
                                        loginCon.login(
                                          loginCon.userController.text,
                                          loginCon.passController.text,
                                        );
                                        // Navigator.of(context)
                                        //     .pushReplacementNamed(Tabs.routeName);
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
