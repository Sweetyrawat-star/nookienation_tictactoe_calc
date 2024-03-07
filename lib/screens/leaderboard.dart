import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nookienation_tictactoe_calc/functions/advertisement.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import '../Helper/utils.dart';
import '../functions/getCoin.dart';
import 'splash.dart';

class LeaderBoardScreen extends StatefulWidget {
  LeaderBoardScreen({super.key});

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  int? yourRank = 0, yourScore = 0;
  String profilePic = guestProfilePic, username = "";
  var ins = GetUserInfo();

  @override
  void initState() {
    super.initState();
    Advertisement.loadAd();

    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    profilePic = await ins.getFieldValue(
      "profilePic",
    );
    username = await ins.getFieldValue(
      "username",
    );
    List<Map> result = [];
    //result = await (leaderBoard() as FutureOr<List<Map<dynamic, dynamic>>>);
    result = await (leaderBoard());
    int count = 1;
    result.forEach((element) {
      if (_auth.currentUser!.uid == element["userid"]) {
        if (mounted) {
          setState(() {
            yourRank = count;
            yourScore = element["score"];
          });
        }
      }
      count++;
    });
  }

  Future<List<Map>> leaderBoard() async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseEvent snapshot =
        await db.ref().child("users").orderByChild("score").once();
    Map map = snapshot.snapshot.value as Map;
    List<Map> result = [];
    map.keys.forEach((e) {
      if (map[e]["score"] != 0) {
        result.add(map[e]);
      }
    });
    result.sort((a, b) {
      return b['score'].compareTo(a['score']);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        music.play(click);
        //if (mounted) Advertisement.showAd();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
       /* appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getSvgImage(
                imageName: 'leaderboard_white',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(" ${utils.getTranslated(context, "leaderboard",)}",style: TextStyle(color: Colors.white),)
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showRankDescription(context);
                },
                icon: Icon(Icons.help,color: Colors.white,))
          ],
        ),*/
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
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
                              ]),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Platform.isAndroid
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                                    : IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: white,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getSvgImage(
                                  imageName: 'leaderboard_white',
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(" ${utils.getTranslated(context, "leaderboard",)}",style: TextStyle(color: Colors.white),)
                              ],
                            ),

                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showRankDescription(context);
                                    },
                                    icon: Icon(Icons.help,color: Colors.white,))
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: Text("${utils.limitChar(username)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: white,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 30.0, end: 30.0, bottom: 0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                yourScore != 0
                                    ? Text(
                                        yourRank.toString(),
                                        style: TextStyle(color: white),
                                      )
                                    : Text(
                                        "--",
                                        style: TextStyle(color: white),
                                      ),
                                Text(utils.getTranslated(context, "yourRank")),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  yourScore.toString(),
                                  style: TextStyle(color: white),
                                ),
                                Text(
                                  utils.getTranslated(context, "yourScore"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.only(top: 30.0),
                    child: FutureBuilder<List<Map>>(
                        future: leaderBoard(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Map> data = snapshot.data as List<Map>;
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  "No LeaderBoard.",
                                  style: TextStyle(color: primaryColor),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: ListView.builder(
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return data[i]["score"] != 0
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: ListTile(
                                            title: Text(
                                              data[i]["username"].toString(),
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: secondaryColor),
                                            ),
                                            leading: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    child: Center(
                                                      child: Text(
                                                        "${i + 1}",
                                                        style: TextStyle(
                                                            color:
                                                                secondaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  backgroundImage: NetworkImage(
                                                      data[i]["profilePic"] ==
                                                              null
                                                          ? guestProfilePic
                                                          : data[i]
                                                              ["profilePic"]),
                                                  radius: 25,
                                                ),
                                              ],
                                            ),
                                            trailing: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: const BorderRadius
                                                        .horizontal(
                                                    left: Radius.circular(50),
                                                    right: Radius.circular(50)),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                child: Center(
                                                  child: Text(
                                                    "${data[i]["score"]}",
                                                    style:
                                                        TextStyle(color: white),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                              ),
                            );
                          }
                          return Container(
                            child: Text(
                                utils.getTranslated(context, "noDataFound")),
                          );
                        }),
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23 - 50,
              left: MediaQuery.of(context).size.width / 2.5,
              child: Center(
                child: CircleAvatar(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profilePic),
                    radius: 35,
                  ),
                  backgroundColor: primaryColor,
                  radius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showRankDescription(BuildContext context) {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
      builder: (context) => Positioned.directional(
          textDirection: Directionality.of(context),
          end: 10,
          top: MediaQuery.of(context).size.height * .10,
          child: Container(
            width: MediaQuery.of(context).size.width * .50,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                utils.getTranslated(context, "lowScore"),
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    decoration: TextDecoration.none),
              ),
            ),
          )));

  Overlay.of(context).insert(overlayEntry);
  Timer(Duration(seconds: 3), () => overlayEntry.remove());
}
