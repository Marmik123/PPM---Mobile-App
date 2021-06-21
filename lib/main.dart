import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/utils/shared_preferences.dart';
import 'package:pcm/view/auth/login_mobile.dart';
import 'package:pcm/view/home/home_screen_client.dart';
import 'package:pcm/view/home/home_screen_delivery.dart';
import 'package:pcm/view/home/home_screen_marketing.dart';
import 'package:pcm/view/home/homes_screen_sales.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String parse_App_ID = '849F7316D6729D5A14451E65AF5E1';
const String parse_Masterkey = 'A2F3518273BE94F51A3BD44CBAC5E';
const String parse_App_url = 'https://api.ppmstore.in/parse';
const String kParseLiveQueryUrl = 'wss://api.ppmstore.in';
SharedPreferences prefs;

RepoController ctrl;
//RepoController ctrl = Get.put(RepoController());
Future<void> initSPreference() async {
  ctrl = Get.put(RepoController());
  prefs = await SharedPreferences.getInstance();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  //await initPreferences();
  await initSPreference();
  //print(ctrl.savedLocale());

  await S.load(Locale(prefs.getString('languageCode') ?? 'en'));
  await Firebase.initializeApp();
  await Parse().initialize(
    parse_App_ID,
    parse_App_url,
    masterKey: parse_Masterkey,
    liveQueryUrl: kParseLiveQueryUrl,
    autoSendSessionId: true,
    debug: kDebugMode,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );

  runApp(Phoenix(child: MyApp()));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //RepoController rCtrl = Get.put(RepoController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PCM',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade50,
        accentColor: Colors.green,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.green,
          elevation: 5,
          shadowColor: Colors.black26,
          textTheme: TextTheme(
            headline6: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          headline6: GoogleFonts.merriweather(),
        ),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () {
            return prefs.getString(ctrl.kUserData) == 'Client'
                ? HomeScreenClient()
                : prefs.getString(ctrl.kUserData) == 'DeliveryBoy'
                    ? HomeScreenDelivery()
                    : prefs.getString(ctrl.kUserData) == 'SalesPerson'
                        ? HomeScreen()
                        : prefs.getString(ctrl.kUserData) == 'Marketing'
                            ? HomeScreenM()
                            : SignIn();
          },
        ),
      ],
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      fallbackLocale: Locale('en'),
      locale: Locale(prefs.getString('languageCode') ?? 'en'),
      defaultTransition: Transition.cupertino,
    );
  }
}
