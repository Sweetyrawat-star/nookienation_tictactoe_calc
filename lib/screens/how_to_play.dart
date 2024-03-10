import 'package:flutter/material.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import 'home_screen.dart';
import 'splash.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Coin(),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff4c3b6c),
                      Color(0xff584575),
                      Color(0xff4e3b6c),
                      Color(0xff6e416f),
                      Color(0xff754271),
                      Color(0xff794271),

                      /*secondaryColor,
      primaryColor,*/
                    ])),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/gifs/home_bac.gif', fit: BoxFit.cover),
            //   child: getSvgImage(imageName: "bg", fit: BoxFit.fill),
          ),
        /*  SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
            //getSvgImage(imageName: "bg", fit: BoxFit.fill),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height /4.78,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        utils.getTranslated(context, "howToPlayHeading"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          utils.getTranslated(context, "howToPlayContent"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: white,
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 5,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 5),
                            child: Text(
                              utils.getTranslated(context, "ok"),
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                  "assets/images/Kitty.png", width: 131, height: 146),
            ],
          ),
        ],
      ),
    );
  }
}
