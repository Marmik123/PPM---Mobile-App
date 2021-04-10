// import 'package:Rapair_desk/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences_utils.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String langCode = savedLocale.languageCode;
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
                setState(() {
                  langCode = 'en';
                });
                await setLang(Locale(langCode));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                setState(() {});
                setState(() {});
              },
              title: Text(S.of(context).English),
            ),
            ListTile(
              onTap: () async {
                setState(() {
                  langCode = 'gu';
                });
                await setLang(Locale(langCode));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                setState(() {});
                setState(() {});
              },
              title: Text(S.of(context).Gujarati),
            ),
            ListTile(
              onTap: () async {
                setState(() {
                  langCode = 'hi';
                });
                await setLang(Locale(langCode));
                Navigator.of(context).pop();
                setState(() {});
                setState(() {});
              },
              title: Text(S.of(context).Hindi),
            )
          ],
        ),
      ),
    );
  }
}
