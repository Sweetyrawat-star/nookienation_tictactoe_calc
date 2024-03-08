import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nookienation_tictactoe_calc/firebase_options.dart';
import 'package:nookienation_tictactoe_calc/routes/routes.dart';
import 'package:nookienation_tictactoe_calc/screens/privacy_policy.dart';
import 'package:nookienation_tictactoe_calc/screens/splash.dart';
import 'package:nookienation_tictactoe_calc/widgets/life_cycle_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/color.dart';
import 'Helper/constant.dart';
import 'Helper/demo_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ///
  // if (Firebase.apps.isNotEmpty) {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // } else {
  //   await Firebase.initializeApp();
  // }

  //await MobileAds.instance.initialize();

  if (kIsWeb) {
    runApp(MyAppPrivacyUrl());
  } else {
    runApp(MyApp());
  }
}

class MyAppPrivacyUrl extends StatefulWidget {
  const MyAppPrivacyUrl({super.key});

  @override
  State<MyAppPrivacyUrl> createState() => _MyAppPrivacyUrlState();
}

class _MyAppPrivacyUrlState extends State<MyAppPrivacyUrl> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      // initialRoute: SplashScreen.routeName,
      home: PrivacyPolicy(),
      // routes: {
      //   PrivacyPolicy.routeName: (context) => PrivacyPolicy(),
      // },
    );
    ;
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  late SharedPreferences sharedPreferences;

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted)
      setState(() {
        _locale = locale;
      });
  }

  @override
  void didChangeDependencies() {
    utils.getLocale().then((locale) {
      if (mounted)
        setState(() {
          this._locale = locale;
        });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LifeCycleManager(
        child: MaterialApp(
          locale: _locale,
          supportedLocales: [
            Locale("en", "US"),
            Locale("es", "ES"),
            Locale("hi", "IN"),
            Locale("ar", "DZ"),
            Locale("ru", "RU"),
            Locale("ja", "JP"),
            Locale("de", "DE")
          ],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          title: appName,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: ThemeData(
            fontFamily: 'Poppins',
            textTheme: TextTheme(
              bodyLarge: TextStyle(),
              bodyMedium: TextStyle(),
            ).apply(
              bodyColor: white,
              displayColor: white,
            ),
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            primaryColor: primaryColor,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
          ),
          routes: Routes.data,
        ),
      ),
    );
  }
}

@override
State<StatefulWidget> createState() {
  throw UnimplementedError();
}
