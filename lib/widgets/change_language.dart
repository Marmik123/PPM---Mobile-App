// import 'package:Rapair_desk/generated/l10n.dart';
import 'package:flutter/material.dart';

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
            Text('Change Language'/*S.of(context).changeLanguage*/),
            Divider(),
            ListTile(
              onTap: () {
                // Navigator.of(context).pop('en');
              },
              title: Text('English'),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).pop('fr');
              },
              title: Text('French'),
            ),
          ],
        ),
      ),
    );
  }
}