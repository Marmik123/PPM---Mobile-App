import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/client_controller.dart';
import 'package:pcm/generated/l10n.dart';

class DocumentVerification extends StatefulWidget {
  const DocumentVerification({Key key}) : super(key: key);

  @override
  _DocumentVerificationState createState() => _DocumentVerificationState();
}

class _DocumentVerificationState extends State<DocumentVerification> {
  ClientController client = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Verification"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Phoenix.rebirth(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ParseLiveListWidget(
                  shrinkWrap: true,
                  listenOnAllSubItems: true,
                  lazyLoading: true,
                  query: client.isDocumentVerified(),
                  childBuilder: (context, snapshot) {
                    print("!!!");
                    print(snapshot.hasData);
                    print(snapshot.loadedData);
                    if (snapshot.failed) {
                      return Text(S.of(context).warning);
                    } else if (snapshot.hasData) {
                      if (snapshot.loadedData.get('isVerified') == "No") {
                        print(snapshot.loadedData.get('isVerified'));
                        return Column(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.cyan,
                              size: 55,
                            ),
                            Text(
                              'Documents Verification In Progress',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )
                          ],
                        );
                      } else if (snapshot.loadedData.get('isVerified') ==
                          'Yes') {
                        return Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 55,
                              color: Colors.green,
                            ),
                            Text('Documents Verified Successfully',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20))
                          ],
                        );
                      }
                    } else {
                      return ListTileShimmer();
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
