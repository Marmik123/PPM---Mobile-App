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
              onTap: () async {
                // setState(() {
                //   langCode = 'en';
                // });
                // await setLang(Locale(langCode));
                // // Navigator.of(context).pop();
                // setState(() {});
                Navigator.of(context).pop('en');

                // setState(() {});
              },
              title: Text(S.of(context).English),
            ),
            ListTile(
              onTap: () async {
                // setState(() {
                //   langCode = 'gu';
                // });
                // await setLang(Locale(langCode));

                // setState(() {});
                Navigator.of(context).pop('gu');

                // setState(() {});
              },
              title: Text(S.of(context).Gujarati),
            ),
            ListTile(
              onTap: () async {
                // setState(() {
                //   langCode = 'hi';
                // });
                // await setLang(Locale(langCode));
                // setState(() {});
                Navigator.of(context).pop('hi');

                // setState(() {});
              },
              title: Text(S.of(context).Hindi),
            )
          ],
        ),
      ),
    );
  }
}
