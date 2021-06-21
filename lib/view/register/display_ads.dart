import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/controller/register/ad_controller.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/common/feedback.dart';
import 'package:pcm/view/common/settings.dart';
import 'package:pcm/view/common/support.dart';
import 'package:pcm/view/home/home_screen_marketing.dart';

class DisplayAd extends StatefulWidget {
  @override
  _DisplayAdState createState() => _DisplayAdState();
}

class _DisplayAdState extends State<DisplayAd> {
  @override
  AdController adCtrl = Get.put(AdController());

  RepoController rCtrl = Get.put(RepoController());

  SupportController ctrl = Get.put(SupportController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          S.of(context).adsRegistered,
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ParseLiveListWidget(
            query: adCtrl.showAds(),
            lazyLoading: true,
            scrollPhysics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 8),
            childBuilder: (context, snapshot) {
              if (snapshot.failed) {
                return Text(S.of(context).warning);
              } else if (snapshot.hasData) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black54,
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.loadedData.get('adDescription')}' ?? '-',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${S.of(context).paymentR}:  ${snapshot.loadedData.get('paymentReceived')}' ??
                              '-',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      '${snapshot.loadedData.get('adName')}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black54,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://api.ppmstore.in/file/product/' +
                                      snapshot.loadedData
                                          .get('imageFileName')
                                          ?.first ??
                                  'https://picsum.photos/id/1/200/300',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return ListTileShimmer();
              }
            }),
      ),
    );
  }
}
