// import 'package:Rapair_desk/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences_utils.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).change),
            Divider(),
            ListTile(
              onTap: () {
                
                Navigator.of(context).pop('en');

            
              },
              title: Text(S.of(context).English),
            ),
            ListTile(
              onTap: () {
               
                Navigator.of(context).pop('gu');

               
              },
              title: Text(S.of(context).Gujarati),
            ),
            ListTile(
              onTap: () {
                
                Navigator.of(context).pop('hi');

               
              },
              title: Text(S.of(context).Hindi),
            )
          ],
        ),
      ),
    );
  }
}
