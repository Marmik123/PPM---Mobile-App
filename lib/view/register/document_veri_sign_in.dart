import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';

class SignInDocVeri extends StatefulWidget {
  const SignInDocVeri({Key key}) : super(key: key);

  @override
  _SignInDocVeriState createState() => _SignInDocVeriState();
}

class _SignInDocVeriState extends State<SignInDocVeri> {
  ClientController client = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Verification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Phoenix.rebirth(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: ParseLiveListWidget<ParseObject>(
            shrinkWrap: true,
            listenOnAllSubItems: true,
            lazyLoading: true,
            padding: const EdgeInsets.only(left: 8.0),
            query: client.isDocumentVerifiedAtSignIn(),
            /*query: QueryBuilder(ParseObject('UserMetadata'))
              ..whereEqualTo('objectId', 'zLJsADUFVI'),*/
            childBuilder: (context, snapshot) {
              print('!!!');
              print(snapshot.hasData);
              print(snapshot.loadedData);
              if (snapshot.failed) {
                return Text(S.of(context).warning);
              } else if (snapshot.hasData) {
                print(snapshot.loadedData.toString());
                print('IsVerified :: ' + snapshot.loadedData.get('isVerified'));
                if (snapshot.loadedData.get('isVerified') == 'No') {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.green,
                          size: 55,
                        ),
                        Text(
                          'Documents Verification In Progress',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.loadedData.get('isVerified') == 'Yes') {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          size: 55,
                          color: Colors.green,
                        ),
                        Text(
                          'Documents Verified Successfully',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: 25,
                              right: 25,
                            )),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListTileShimmer();
                }
              } else {
                return ListTileShimmer();
              }
            }),
      ),
    );
  }
}
