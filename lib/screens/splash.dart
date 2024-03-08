import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import '../Helper/utils.dart';

class SplashScreen extends StatefulWidget {

  static const routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Utils utils = new Utils();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration:BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/splashLogo.png"),fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                   "assets/images/nookienation.png",
                  width: 194,
                  height: 194,
                ),
                Image.asset(
                  "assets/images/kitty.png",
                  width: 194,
                  height: 194,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: Text(
              utils.getTranslated(context, "CalculateEveryMove"),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontFamily: 'DISPLATTER', color: white),
            ),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void navigateToNextPage() async {
    await MobileAds.instance.initialize();
    await UnityAds.init(
      gameId: gameID,
      testMode: true,
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    music.play(backMusic);

    Future.delayed(Duration(seconds: 3)).then((response) async {
      bool value = await utils.getUserLoggedIn("isLoggedIn");
      if (value) {
        utils.replaceScreenAfter(context, "/home");
      } else {
        utils.replaceScreenAfter(context, "/authscreen");
      }
    });
  }
}
