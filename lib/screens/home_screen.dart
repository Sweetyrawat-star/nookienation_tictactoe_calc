import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import '../Helper/string.dart';
import '../Helper/utils.dart';
import '../functions/dialoges.dart';
import '../functions/getCoin.dart';
import '../models/soundEffect.dart';
import '../widgets/selectLevelDialog.dart';
import 'finding_player.dart';
import 'pass_n_play.dart';
import 'splash.dart';

class HomeScreenActivity extends StatefulWidget {
  const HomeScreenActivity({Key? key}) : super(key: key);

  @override
  HomeScreenActivityState createState() => HomeScreenActivityState();
}

class HomeScreenActivityState extends State<HomeScreenActivity>
    with TickerProviderStateMixin {
  int _swiperIndex = 1;

  late AnimationController _animationController;
  Utils localValue = Utils();
  late String userSkin, opponentSkin;
  late AnimationController firstAnimationController;

  late String clickAudioUrl;

  late SoundEffect loadedSound;
  var coin;
  late bool canPlay;

  TextEditingController player1controller = TextEditingController();
  TextEditingController player2controller = TextEditingController();

  late Animation<Color?> topSwipeColor;

  late Animation<Color?> bottomSwipeColor;

  late Animation<double> topAngle;
  late Animation<double> bottomAngle;
  late Animation<double> centerTopAngle;
  late Animation<double> centerBottomAngle;

  late Animation<Alignment> topCenterContainerAlignment;

  late Animation<Alignment> centerBottomContainerAlignment;

  late Animation<Alignment> bottomCenterContainerAlignment;

  late Animation<Alignment> centerTopContainerAlignment;

  late Animation<double> topLastContainerOpacityAnimation;
  late Animation<double> lastTopContainerOpacityAnimation;

  late Animation<Offset> kittyAnimation;
  late Animation<Offset> leftAnimation;
  bool swipeUP = false;
  late AnimationController centerAnimationController;
  String? getlanguage;

  List<Item> itemList = [
    Item(
        icon: "offline_white",
        name: "OFFLINE PLAY",
        desc: "Play with the Clever Fox KITTY"),
    Item(
        icon: "play_random",
        name: "PLAY WITH RANDOM",
        desc: "Find your match around the world"),
    Item(
        icon: "passnplay_white",
        name: "PASS N PLAY",
        desc: "Pass N Play With your Friend"),
  ];

  @override
  void initState() {
    super.initState();
    initAnimation();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    centerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    kittyAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    leftAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    centerAnimationController.forward();
    _animationController.forward();
    getSkinvalues();
    _getSavedLanguage();
    coins();
    canP();
    deleteOldGames();
    Future.delayed(Duration(seconds: 0)).then((value) {
      itemList = [
        Item(
          icon: "offline_white",
          name: utils.getTranslated(context, "OFFLINE_PLAY"),
          desc: utils.getTranslated(context, "Play_with_the_Clever_Fox_KITTY"),
        ),
        Item(
            icon: "play_random",
            name: utils.getTranslated(context, "PLAY_WITH_RANDOM"),
            desc: utils.getTranslated(
                context, "Find_your_match_around_the_world")),
        Item(
          icon: "passnplay_white",
          name: utils.getTranslated(context, "PASS_N_PLAY"),
          desc: utils.getTranslated(context, "Pass_N_Play_With_your_Friend"),
        ),
      ];
    });
  }

  _getSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getlanguage = prefs.getString(LAGUAGE_CODE) ?? "";

    itemList = [
      Item(
        icon: "offline_white",
        name: utils.getTranslated(context, "OFFLINE_PLAY"),
        desc: utils.getTranslated(context, "Play_with_the_Clever_Fox_KITTY"),
      ),
      Item(
          icon: "play_random",
          name: utils.getTranslated(context, "PLAY_WITH_RANDOM"),
          desc:
              utils.getTranslated(context, "Find_your_match_around_the_world")),
      Item(
        icon: "passnplay_white",
        name: utils.getTranslated(context, "PASS_N_PLAY"),
        desc: utils.getTranslated(context, "Pass_N_Play_With_your_Friend"),
      ),
    ];

    if (mounted) setState(() {});
  }

  void initAnimation() {
    firstAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    topAngle =
        Tween<double>(begin: 9, end: 0).animate(firstAnimationController);
    bottomAngle =
        Tween<double>(begin: -9, end: 0).animate(firstAnimationController);

    centerTopAngle =
        Tween<double>(begin: 0, end: 9).animate(firstAnimationController);
    centerBottomAngle =
        Tween<double>(begin: 0, end: -9).animate(firstAnimationController);

    topSwipeColor = ColorTween(begin: lightWhite, end: secondaryColor)
        .animate(firstAnimationController);

    bottomSwipeColor = ColorTween(begin: secondaryColor, end: lightWhite)
        .animate(firstAnimationController);

    topCenterContainerAlignment =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.center)
            .animate(firstAnimationController);

    centerBottomContainerAlignment =
        AlignmentTween(begin: Alignment.center, end: Alignment.bottomCenter)
            .animate(firstAnimationController);

    bottomCenterContainerAlignment =
        AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.center)
            .animate(firstAnimationController);

    centerTopContainerAlignment =
        AlignmentTween(begin: Alignment.center, end: Alignment.topCenter)
            .animate(firstAnimationController);

    topLastContainerOpacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(firstAnimationController);
    lastTopContainerOpacityAnimation =
        Tween<double>(begin: 1, end: 0).animate(firstAnimationController);
  }

  void getSkinvalues() async {
    userSkin = await localValue.getSkinValue("user_skin");
    opponentSkin = await localValue.getSkinValue("opponent_skin");

    print("Opp Skin: $opponentSkin");
    print("User Skin: $userSkin");
  }

  canP() async {
    var b = await utils.getSfxValue();
    setState(() {
      canPlay = b;
    });
  }

  coins() async {
    var init;
    try {
      var ins = GetUserInfo();
      init = (await ins.getCoin());
      setState(() {
        coin = init;
      });
      await ins.detectChange("coin", (val) {
        if (mounted)
          setState(() {
            coin = val;
          });
      });
    } catch (err) {}
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getSkinvalues();
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Coin(),
        actions: [
          // getSvgImage(
          //   imageName: "circle_skin",
          //   height: 30,
          //   width: 30,
          //   fit: BoxFit.scaleDown,
          // ),
          Container(
            width: 60,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                //navigate to Leaderboard screen
                music.play(click);
                Navigator.pushNamed(context, "/leaderboard");
              },
              child: getSvgImage(
                imageName: 'leaderboard_dark',
                height: 20,
                width: 20,
                imageColor: secondarySelectedColor
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              //navigate to profile screen
              music.play(click);
              Navigator.pushNamed(context, "/profile").then((value) {
                _getSavedLanguage();
                getSkinvalues();
                setState(() {});
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10),
                child: Icon(Icons.dashboard,color:secondarySelectedColor,size: 16,),
              ),
            )
          ),
        ],
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
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight * 1.7),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlideTransition(
                          position: kittyAnimation,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset(
                                "assets/images/nookienationlogo.png",
                              //  "assets/images/Kitty.png",
                              ),
                            ),
                          ),
                        ),

                        SlideTransition(
                          position: kittyAnimation,
                          child: Image.asset(
                           // "assets/images/kittytext.png",
                              "assets/images/Kitty.png",
                            height: 130,
                            width: 191,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onVerticalDragUpdate: (details) async {
                    int sensitivity = 8;
                    if (details.delta.dy > sensitivity) {
                      //down swipe
                      Future.delayed(Duration(seconds: 0), () {
                        if (!firstAnimationController.isAnimating) {
                          setState(() {
                            swipeUP = false;
                          });
                          firstAnimationController
                              .forward(from: 0)
                              .then((value) {
                            centerAnimationController.reset();
                            centerAnimationController.forward();

                            initAnimation();
                            setState(() {
                              if (_swiperIndex == 1 || _swiperIndex == 2) {
                                _swiperIndex = _swiperIndex - 1;
                              } else {
                                _swiperIndex = 2;
                              }
                            });
                          });
                        }
                      });
                    } else if (details.delta.dy < -sensitivity) {
                      // Up Swipe

                      if (!firstAnimationController.isAnimating) {
                        setState(() {
                          swipeUP = true;
                        });
                        firstAnimationController.forward(from: 0).then((value) {
                          centerAnimationController.reset();
                          centerAnimationController.forward();

                          initAnimation();
                          setState(() {
                            if (_swiperIndex == 0 || _swiperIndex == 1) {
                              _swiperIndex = _swiperIndex + 1;
                            } else {
                              _swiperIndex = 0;
                            }
                          });
                        });
                      }
                    }
                  },
                  child: rtlLanguages.contains(getlanguage)
                      ? Transform(
                          alignment: AlignmentDirectional.topCenter,
                          transform: Matrix4.rotationY(math.pi),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: SlideTransition(
                                position: leftAnimation,
                                child: Stack(
                                  textDirection: Directionality.of(context),
                                  children: [
                                    ..._buildTopContainers(),
                                    _buildCenter(),
                                    ..._buildBottomContainers(),
                                  ],
                                )),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: SlideTransition(
                              position: leftAnimation,
                              child: Stack(
                                textDirection: Directionality.of(context),
                                children: [
                                  ..._buildTopContainers(),
                                  _buildCenter(),
                                  ..._buildBottomContainers(),
                                ],
                              )),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCenter() {
    return AnimatedBuilder(
      animation: firstAnimationController,
      builder: (context, child) {
        return Align(
            alignment: swipeUP
                ? centerTopContainerAlignment.value
                : centerBottomContainerAlignment.value,
            child: getCenterItem());
      },
    );
  }

  List<Widget> _buildTopContainers() {
    return [
      //2rd
      Align(
        alignment: Alignment.topCenter,
        child: FadeTransition(
            opacity: swipeUP
                ? lastTopContainerOpacityAnimation
                : topLastContainerOpacityAnimation,
            child: getFirstItem()),
      ),
      //1st
      swipeUP
          ? Container()
          : AnimatedBuilder(
              animation: firstAnimationController,
              builder: (context, child) {
                return Align(
                    alignment: topCenterContainerAlignment.value,
                    child: getFirstItem());
              },
            ),
    ];
  }

  List<Widget> _buildBottomContainers() {
    return [
      //2rd
      Align(
        alignment: Alignment.bottomCenter,
        child: FadeTransition(
            opacity: swipeUP
                ? topLastContainerOpacityAnimation
                : lastTopContainerOpacityAnimation,
            child: getThirdItem()),
      ),

      swipeUP
          ? AnimatedBuilder(
              animation: firstAnimationController,
              builder: (context, child) {
                return Align(
                    alignment: bottomCenterContainerAlignment.value,
                    child: getThirdItem());
              },
            )
          : Container(),
      //1st
    ];
  }

  selectAmountDialog() {
    int selected = multiplayerEntryAmount[0];

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
              title: Center(
                child: Text(
                  utils.getTranslated(context, "amountDial"),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: white),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChipGrid(
                    list: multiplayerEntryAmount,
                    avtar: true,
                    onChange: (int m) {
                      setState(() {
                        selected = m;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      utils.getTranslated(context, "winningMsg"),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: back),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              actions: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(secondarySelectedColor),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))))),
                    onPressed: () async {
                      music.play(click);
                      try {
                        await InternetAddress.lookup('google.com');
                        if (coin >= selected) {
                          //  Navigator.pushNamed(context, "/findplayer",arguments: selected);
                          Navigator.pop(context);
                          selectRoundDialog(selected);
                        } else {
                          Navigator.pop(context);
                          Dialoge.lessMoney(context);
                        }
                      } on SocketException catch (_) {
                        var dialoge = Dialoge();
                        dialoge.error(context);
                      }
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      utils.getTranslated(context, "next"),
                      style: TextStyle(color:Colors.white, fontSize: 12),
                    ))
              ],
            ));
  }

  void showSelectLevelDialog() {
    print("Opp Skin: $opponentSkin");
    print("User Skin: $userSkin");
    showDialog(
        context: context,
        builder: (_) =>
            SelectLevelDialog(opponentSkin: opponentSkin, userSkin: userSkin));
  }
  selectPassNPlayDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.white, width: 2.0),
        ),
        title:  Center(
          child: Text(
            utils.getTranslated(context, "passNplayDialoge"),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: white),
          ),
        ),// Set background color to transparent
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Your TextFields and other content
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                      ]),
                ),
                child: TextField(
                  controller: player1controller,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: getSvgImage(
                        imageName: userSkin,
                        height: 10,
                        width: 10,
                      ),
                    ),
                    border: InputBorder.none,
                    focusColor: white,
                    hintText: utils.getTranslated(context, "playerName"),
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                    ]),
              ),
              child: TextField(
                controller: player2controller,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: getSvgImage(
                      imageName: opponentSkin,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  hintText: utils.getTranslated(context, "playerName"),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(secondarySelectedColor),
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))))),
              onPressed: () async {
                music.play(click);
                if (player1controller.text.isNotEmpty &&
                    player2controller.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PassNPLay(
                              "${utils.limitChar(player1controller.text.toString(), 7)}",
                              "${utils.limitChar(player2controller.text.toString(), 7)}",
                              userSkin,
                              opponentSkin)));
                }
              },
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                utils.getTranslated(context, "start"),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ))
        ],
      ),
    );
  }


 /* selectPassNPlayDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Center(
                child: Text(
                  utils.getTranslated(context, "passNplayDialoge"),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: white),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                              ]),
                         ),
                      child: TextField(
                        controller: player1controller,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: getSvgImage(
                              imageName: userSkin,
                              height: 10,
                              width: 10,
                            ),
                          ),
                          border: InputBorder.none,
                          focusColor: white,
                          hintText: utils.getTranslated(context, "playerName"),
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                          ]),
                    ),
                    child: TextField(
                      controller: player2controller,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: getSvgImage(
                            imageName: opponentSkin,
                            height: 10,
                            width: 10,
                          ),
                        ),
                        hintText: utils.getTranslated(context, "playerName"),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: white,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(secondarySelectedColor),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))))),
                    onPressed: () async {
                      music.play(click);
                      if (player1controller.text.isNotEmpty &&
                          player2controller.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PassNPLay(
                                    "${utils.limitChar(player1controller.text.toString(), 7)}",
                                    "${utils.limitChar(player2controller.text.toString(), 7)}",
                                    userSkin,
                                    opponentSkin)));
                      }
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      utils.getTranslated(context, "start"),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ))
              ],
            ));
  }*/

  selectRoundDialog(int selected) {
    int round = noOfRoundDigit[0];

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
              title: Center(
                child: Text(
                  utils.getTranslated(context, "numberDial"),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: white),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: ChipGrid(
                      list: noOfRound,
                      avtar: false,
                      onChange: (int m) {
                        setState(() {
                          round = noOfRoundDigit[m];
                        });
                      },
                    ),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                ],
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(secondarySelectedColor),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))))),
                    onPressed: () async {
                      music.play(click);
                      try {
                        await InternetAddress.lookup('google.com');
                        if (coin >= selected) {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => FindingPlayerScreen(
                                  selected: selected,
                                  round: round,
                                ),
                              ));
                        } else {
                          Navigator.pop(context);
                          Dialoge.lessMoney(context);
                        }
                      } on SocketException catch (_) {
                        var dialoge = Dialoge();
                        dialoge.error(context);
                      }
                    },
                    child: Text(
                      utils.getTranslated(context, "start"),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ))
              ],
            ));
  }

  Widget getFirstItem() {
    int pos;

    if (_swiperIndex == 0) {
      pos = 2;
    } else {
      pos = _swiperIndex - 1;
    }

    return Container(
        transformAlignment: Alignment.bottomRight,
        transform: Matrix4.identity()
          ..rotateZ(
            topAngle.value * math.pi / 180,
          ),
        height: MediaQuery.of(context).size.height / 3.6,
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
                ]),
            border: Border.all(color: secondarySelectedColor,),
           // color: topSwipeColor.value,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, top: 10.0, bottom: 10.0, end: 10.0),
              child: rtlLanguages.contains(getlanguage)
                  ? Transform(
                      alignment: AlignmentDirectional.topCenter,
                      transform: Matrix4.rotationY(math.pi),
                      child: getFirstItemDetails(pos),
                    )
                  : getFirstItemDetails(pos),
            ),
          ),
        ));
  }

  Widget getFirstItemDetails(int pos) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSvgImage(
            imageName: itemList[pos].icon,
            imageColor:Colors.white,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                itemList[pos].name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              itemList[pos].desc,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white,),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              playButtonPressed(pos);
            },
            child: Text(utils.getTranslated(context, "playNow"),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: white)),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return secondaryColor;
                  return secondarySelectedColor;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  playButtonPressed(int pos) {
    music.play(click);
    if (pos == 0) {
      showSelectLevelDialog();
    } else if (pos == 1) {
      selectAmountDialog();
    } else {
      selectPassNPlayDialog();
    }
  }

  Widget getCenterItem() {
    return SlideTransition(
        position: centerAnimationController.drive(
            Tween(begin: Offset(0.0, 0.1), end: Offset(0.0, 0.0))
                .chain(CurveTween(curve: Curves.easeInOut))),
        child: Container(
            transformAlignment:
                swipeUP ? Alignment.bottomRight : Alignment.topRight,
            transform: Matrix4.identity()
              ..rotateZ(
                swipeUP
                    ? centerTopAngle.value * math.pi / 180
                    : centerBottomAngle.value * math.pi / 180,
              ),
            height: MediaQuery.of(context).size.height / 3.3,
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
                        ]),
                border: Border.all(color: secondarySelectedColor,),
                //color: bottomSwipeColor.value,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Center(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20.0, top: 10.0, bottom: 10.0, end: 10.0),
                  child: rtlLanguages.contains(getlanguage)
                      ? Transform(
                          alignment: AlignmentDirectional.topCenter,
                          transform: Matrix4.rotationY(math.pi),
                          child: getCenterItemDetails(),
                        )
                      : getCenterItemDetails(),
                ),
              ),
            )));
  }

  Widget getCenterItemDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage(
            imageName: itemList[_swiperIndex].icon,
            imageColor: topSwipeColor.value,
            height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              itemList[_swiperIndex].name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: topSwipeColor.value,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            itemList[_swiperIndex].desc,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: topSwipeColor.value),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            playButtonPressed(_swiperIndex);
          },
          child: Text(utils.getTranslated(context, "playNow"),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: white)),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return secondaryColor;
                return secondarySelectedColor;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget getThirdItem() {
    int pos;
    if (_swiperIndex == 2) {
      pos = 0;
    } else {
      pos = _swiperIndex + 1;
    }

    return Container(
        transformAlignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(bottomAngle.value * math.pi / 180),
        height: MediaQuery.of(context).size.height / 3.6,
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
                ]),
            border: Border.all(color: secondarySelectedColor,),
           // color: topSwipeColor.value,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20.0, bottom: 10.0, top: 10.0, end: 10.0),
              child: rtlLanguages.contains(getlanguage)
                  ? Transform(
                      alignment: AlignmentDirectional.topCenter,
                      transform: Matrix4.rotationY(math.pi),
                      child: getThirdItemDetails(pos),
                    )
                  : getThirdItemDetails(pos),
            ),
          ),
        ));
  }

  Widget getThirdItemDetails(int pos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage(
            imageName: itemList[pos].icon,
            imageColor: Colors.white,
            height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              itemList[pos].name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            itemList[pos].desc,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            playButtonPressed(pos);
          },
          child: Text(utils.getTranslated(context, "playNow"),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: white)),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return secondaryColor;
                return secondarySelectedColor;
              },
            ),
          ),
        )
      ],
    );
  }

  void deleteOldGames() async {
    Map? gameData = Map();

    FirebaseDatabase _ins = FirebaseDatabase.instance;
    DatabaseEvent _gameRef = await _ins.ref().child("Game").once();

    if (_gameRef.snapshot.value != null) {
      gameData = _gameRef.snapshot.value as Map;
      gameData.forEach((key, value) {
        //delete game if the game status is closed and still in the DB
        if (value["status"] == "closed") {
          Dialoge.removeChild("Game", key);
        }

        //delete game if the game is created before 15 minutes and still in the DB
        var timeDifferenceInMinutes = (DateTime.now()
            .difference(DateTime.parse(value["time"]))
            .inMinutes);
        if (timeDifferenceInMinutes > 15) {
          Dialoge.removeChild("Game", key);
        }
      });
    }
  }
}

class Coin extends StatefulWidget {
  Coin({Key? key}) : super(key: key);

  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  int coin = 0;
  String profilePic = guestProfilePic;
  final _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    coins.call();
  }

  coins() async {
    var init, profilePicture;
    try {
      var ins = GetUserInfo();

      init = await ins.getCoin();
      profilePicture = await ins.getProfilePic();
      setState(() {
        coin = init;
        profilePic = profilePicture;
      });

      await ins.detectChange("coin", (val) {
        if (mounted) {
          setState(() {
            coin = val;
          });
        }
      });

      await ins.detectChange("profilePic", (val) {
        if (mounted) {
          setState(() {
            profilePic = val;
          });
        }
      });
    } catch (err) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_auth.currentUser!.isAnonymous) {
        //  Navigator.pushNamed(context, "/shop");
        }
      },
      child: Chip(
        backgroundColor: secondarySelectedColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            getSvgImage(imageName: 'coin_symbol', height: 12),
            Text(
              " $coin",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        avatar: CircleAvatar(
          backgroundColor: secondaryColor,
          backgroundImage: NetworkImage(profilePic),
          radius: 15,
        ),
      ),
    );
  }
}

class Item {
  String icon, name, desc;

  Item({required this.icon, required this.name, required this.desc});
}

class ChipGrid extends StatefulWidget {
  final List list;
  final Function(int i) onChange;
  final bool avtar;

  const ChipGrid(
      {Key? key,
      required this.list,
      required this.onChange,
      required this.avtar})
      : super(key: key);

  @override
  _ChipGridState createState() => _ChipGridState();
}

class _ChipGridState extends State<ChipGrid> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).devicePixelRatio == 2.75 ? 120 : 95,
      child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
          ),
          itemCount: widget.list.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () async {
                music.play(dice);
                setState(() {
                  selectedIndex = i;
                });

                if (widget.avtar == false) {
                  widget.onChange(selectedIndex);
                } else {
                  widget.onChange(widget.list[selectedIndex]);
                }
              },
              child: Chip(
                backgroundColor:
                    selectedIndex == i ? secondarySelectedColor : back,
                label: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: widget.avtar ? 0 : 8.0),
                  child: Text(
                    widget.list[i].toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                avatar:
                    widget.avtar ? getSvgImage(imageName: 'coin_symbol') : null,
              ),
            );
          }),
    );
  }
}
