import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nookienation_tictactoe_calc/Helper/privacy_constant.dart';

/* If value of "wantGoogleAd" is true then it will show Google ad
*  If value of "wantGoogleAd" is false then it will show unity ad*/
final bool wantGoogleAd = true;

//admob/google ad settingz
//Example ids
// final String rewardedAdID = "ca-app-pub-3940256099942544/5224354917";
// final String interstitialAdID = "ca-app-pub-3940256099942544/1033173712";
//add your id here

final String rewardedAdID =
    Platform.isAndroid ? "pub-3707581644297685" : "ios reward ad id here";
final String interstitialAdID = Platform.isAndroid
    ? "pub-3707581644297685"
    : "ios  interstitial ad id here";

//unity ad setting
//final String gameID =  Platform.isAndroid ? "place your android ad gameID  here":"place your android ad gameID  here";

// Example of unity ad ids
final String gameID = Platform.isAndroid ? "4839511" : "4839510";

//rewarded video ad limit for one day
final int adLimit = 5;

//set which is set in adUnit
final int adRewardAmount = 50;

//set by default sound on or off
final bool byDefaultSoundOn = true;

final int winScore = 10;
final int loseScore = 4;
final int tieScore = 5;

//music setting
final String click = "click.mp3";
final String wingame = "wingame.mp3";
final String tiegame = "wingame.mp3";
final String losegame = "wingame.mp3";
final String dice = "click.mp3";
final String backMusic = "music.mp3";

const String appName = "Nookienation Tic Tac Toe Calc";

final guestProfilePic =
    "https://firebasestorage.googleapis.com/v0/b/tictact-a37a5.appspot.com/o/icons8-user-male-100.png?alt=media&token=15d0f5ad-aee6-4613-a8d1-e4417283c9ba";

final List multiplayerEntryAmount = [25, 50, 100, 200];
final List<String> typeOfLevel = ["Easy", "Medium", "Hard"];

final List noOfRound = ["ONE", "THREE", "FIVE", "SEVEN"];
final List noOfRoundDigit = [1, 3, 5, 7];

final countdowntime = 20;

//--Add custom default images to images/ folder
final defaultXskin = "cross_skin";

final defaultOskin = "circle_skin";

//-- Add your app store application id here
final String appStoreId = '6460890750';

final String appFind = "You can find our app from below url \nAndroid:";

//-- Add Android application package here (if published on Play Store)
final String packageName = 'com.nookienation_tictactoe_calc';
final String androidLink =
    'https://play.google.com/store/apps/details?id=$packageName';

//-- Add IOS application package & link here (if published on App Store)
final String iosPackage = 'com.nookienation_tictactoe_calc';
final String iosLink = 'https://apps.apple.com/id$appStoreId';

List<String> langCode = ["en", "es", "hi", "ar", "ru", "ja", "de"];

// final String privacyText = '''
// <p></p><h2><b>Privacy policy</b></h2><a href="https://www.google.com"> goooogllee</a>Lorem ipsum dolor sit amet,  molestie mollis nisl.<br><br> Donec molestie se iaculis imperdiet.<br><br>Ut ullamcorpeacircu nulla.<br><br>Proin mollis ullamcorper n sit amet. <br><br>Maecenas ut diam urnalorem.<br><br>Sed non placerat tellus scelerisque.</p>''';

final String privacyText = privacyConst;

final String termText =
    "<p></p><h2><b>Terms and conditions</b></h2>Lorem ipsum dolo nisl.<br><br> Donec molestie imperdiet.<br><br>Ut ullamcorper   Vivamus interdum, enim nec egestas vulputate, purus dui convallis velit, eu elementum massa nibh a arcu nulla.<br><br>Proin mollis  mollis lacus pharetra sit amet. <br><br>Maecenas ut diam lor at lorem.<br><br>Sed non placerat eracelerisque.</p>";

final String aboutText =
    "<p>Welcome to <b>Nookienation Tic Tac Toe Calc</b><br><br>Made by <b>NueStack Technologies</b></p>";

final String contactText =
    "<h2><strong>Contact Us</strong></h2> <p>For any kind of queries related to products, orders or services feel free to contact us on our official email address or phone number as given below :</p> <p>&nbsp;</p><p>Call <a href=tel:9876543210>9876543210</a></p><p>Email <a href=mailto:abc@gmail.com>abc@gmail.com</a></p></p>";

Widget getSvgImage({
  required String imageName,
  double? height,
  double? width,
  Color? imageColor,
  BoxFit fit = BoxFit.contain,
}) {
  return imageColor != null
      ? SvgPicture.asset(
          'assets/svgImages/$imageName.svg',
          height: height ?? 20,
          width: width ?? 20,
          colorFilter: ColorFilter.mode(imageColor, BlendMode.srcIn),
          fit: fit,
        )
      : SvgPicture.asset(
          'assets/svgImages/$imageName.svg',
          height: height ?? 20,
          width: width ?? 20,
          fit: fit,
        );
}
