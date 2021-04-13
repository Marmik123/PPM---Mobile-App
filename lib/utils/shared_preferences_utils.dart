import 'package:flutter/material.dart' show Locale;
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

SharedPreferences pref;
const String kLang = 'locale';
String langCode = savedLocale.languageCode;

initPreferences() async => pref = await SharedPreferences.getInstance();

setLang(Locale locale) async {
  await pref.setString(kLang, locale.languageCode);
  await S.load(locale);
  print('this is where language load ${S.load(locale).toString()}');
}

Locale get savedLocale => Locale(pref.getString(kLang) ?? "en");
