import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import '../Helper/utils.dart';
import '../functions/authentication.dart';
import 'login_with_email.dart';
import 'splash.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _AuthOptionsScreenState createState() => _AuthOptionsScreenState();
}

class _AuthOptionsScreenState extends State<Login> {
  Timer? t;

  Utils localValue = Utils();

  @override
  void initState() {
    super.initState();

    checkUserLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
    t?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 70),
        decoration: utils.gradBack(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                "assets/images/Kitty.png",
               //"assets/images/kittytext.png",
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 50,),
            /*
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Text(
                utils.getTranslated(context, "CalculateEveryMove"),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontFamily: 'DISPLATTER', color: white),
              ),
            ),*/
            Platform.isIOS
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return secondarySelectedColor;
                            return white;
                          },
                        ),
                      ),
                      onPressed: () async {
                        Auth.signin(context, false, "IOS");
                      },
                      icon: getSvgImage(imageName: 'apple_icon'),
                      label: Center(
                        child: Text(
                          utils.getTranslated(context, "signInApple"),
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return secondarySelectedColor;
                      return Color(0xff40a4d8);
                    },
                  ),
                ),
                onPressed: () async {
                 await  Auth.signin(context, false, "Android",
                      email: "", password: "");
                },
                icon: getSvgImage(imageName: "google_logo",imageColor: Colors.white),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInGoogle"),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return secondarySelectedColor;
                      return Color(0xffec5878);
                    },
                  ),
                ),
                onPressed: () async {
                  await Auth.anonymousSignin(context).then((value) {
                    t?.cancel();
                  });
                },
                icon: Icon(Icons.person_2_outlined,color: Colors.white,),
                //getSvgImage(imageName: 'play_guest'),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInGuest"),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.only(
                  start: 40.0, end: 40, bottom: 10),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return secondarySelectedColor;
                      return Color(0xff7b7eb5);
                    },
                  ),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => LoginWithEmail()));
                },
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInEmail"),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUserLoggedIn() async {
    bool value = await utils.getUserLoggedIn("isLoggedIn");

    if (value) {
      utils.replaceScreenAfter(context, "/home");
    }
  }
}
