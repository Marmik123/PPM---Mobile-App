import 'package:flutter/material.dart' show Locale;
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

SharedPreferences pref;
const String kLang = 'locale';
String langCode = savedLocale.languageCode;

initPreferences() async {
  pref = await SharedPreferences.getInstance();
}

setLang(Locale locale) async {
  await pref.setString(kLang, locale.languageCode);
  S.load(locale);
  print(S.load(locale));
}

Locale get savedLocale => Locale(pref.getString(kLang) ?? "en");
