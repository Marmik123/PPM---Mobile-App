import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:get/get.dart';

import 'package:pcm/view/home/homes_screen_sales.dart';
import 'package:pcm/view/login.dart';

// import 'generated/l10n.dart';

const String parse_App_ID = '849F7316D6729D5A14451E65AF5E1';
const String parse_Masterkey = 'A2F3518273BE94F51A3BD44CBAC5E';
const String parse_App_url = 'https://cup.marketing.dharmatech.in/manage';
const String kParseLiveQueryUrl = 'wss://cup.marketing.dharmatech.in';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initPreferences();

  await Parse().initialize(
    parse_App_ID,
    parse_App_url,
    masterKey: parse_Masterkey,
    liveQueryUrl: kParseLiveQueryUrl,
    autoSendSessionId: true,
    debug: kDebugMode,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PCM',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
            elevation: 1,
            textTheme: TextTheme(
              headline6: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          textTheme: TextTheme(
            headline6: GoogleFonts.merriweather(),
          )),
      getPages: [
        GetPage(
          name: '/',
          page: () {
            return HomeScreen();
          },
        )
      ],
      debugShowCheckedModeBanner: false,

      // localizationsDelegates: [
      //   S.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: S.delegate.supportedLocales,
    );
  }
}
