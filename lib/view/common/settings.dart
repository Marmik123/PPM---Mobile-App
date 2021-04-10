import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/widgets/change_language.dart';
import 'package:pcm/widgets/change_mobile.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Settings,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangeLanguage(),
                  );
                  // ).then((value) async {
                  //   if (value != null) {
                  //     setState(() {
                  //       sharedPresf = value;
                  //     });
                  //     await setLang(Locale(sharedPresf));
                  //     setState(() {});
                  //   }
                },
                leading: Icon(Icons.handyman),
                title: Text( S.of(context).change),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangeMobile(),
                  );
                  // ).then((value) async {
                  //   if (value != null) {
                  //     setState(() {
                  //       sharedPresf = value;
                  //     });
                  //     await setLang(Locale(sharedPresf));
                  //     setState(() {});
                  //   }
                },
                leading: Icon(Icons.handyman),
                title: Text( S.of(context).changeMob),
              ),
            ),
            // Card(
            //   child: ListTile(
            //     onTap: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) => ChangeMobile(),);
            //       // ).then((value) async {
            //       //   if (value != null) {
            //       //     setState(() {
            //       //       sharedPresf = value;
            //       //     });
            //       //     await setLang(Locale(sharedPresf));
            //       //     setState(() {});
            //       //   }
            //
            //     },
            //     leading: Icon(Icons.handyman),
            //     title: Text('Edit Profile'/*S.of(context).jobs*/),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
