
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color.dart';
import '../Helper/constant.dart';
import '../Helper/utils.dart';
import '../screens/offline_play.dart';
import '../screens/splash.dart';

class SelectLevelDialog extends StatefulWidget {
  final String userSkin, opponentSkin;
  SelectLevelDialog(
      {super.key, required this.opponentSkin, required this.userSkin});

  @override
  State<SelectLevelDialog> createState() => _SelectLevelDialogState();
}

class _SelectLevelDialogState extends State<SelectLevelDialog> {
  int selectedLevelIndex = 0;

  Widget _buildLevelContainer(
      {required String levelName, required int levelIndex}) {
    return GestureDetector(
      onTap: () async {
        music.play(dice);
        setState(() {
          selectedLevelIndex = levelIndex;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: selectedLevelIndex == levelIndex
                ? secondarySelectedColor
                : back,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Center(
              child: Text(
                utils.getTranslated(context, levelName),
                style:selectedLevelIndex == levelIndex ?Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: white):Theme.of(context).textTheme.titleSmall,
              //  style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      title: Center(
        child: Text(
          utils.getTranslated(context, "selectLevel"),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: white),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: typeOfLevel
              .map((e) => _buildLevelContainer(
                  levelName: e, levelIndex: typeOfLevel.indexOf(e)))
              .toList(),
        ),
      ),
      actions: [
        ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(secondarySelectedColor),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))))),
            onPressed: () async {
              music.play(click);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => SinglePlayerScreenActivity(
                          widget.userSkin,
                          widget.opponentSkin,
                          selectedLevelIndex)));
            },
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              utils.getTranslated(context, "next"),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ))
      ],
    );
  }
}
