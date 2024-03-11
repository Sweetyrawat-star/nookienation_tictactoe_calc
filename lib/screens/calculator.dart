import 'dart:io';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:nookienation_tictactoe_calc/Helper/color.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var result = '';
  var inputUser = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RawMaterialButton(
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '0';
              });
            } else {
              buttonPressed(text1);
            }
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text1),
          child: Text(
            text1,
            style: TextStyle(
                color: getTextColor(text1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text2 == 'CE') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text2),
          child: Text(
            text2,
            style: TextStyle(
                color: getTextColor(text2),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            buttonPressed(text3);
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text3),
          child: Text(
            text3,
            style: TextStyle(
                color: getTextColor(text3),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          elevation: 2.0,
          fillColor: secondarySelectedColor,
          child: Text(
            text4,
            style: TextStyle(
                fontSize: 40, color: white, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Platform.isAndroid
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : BackButton(
                      color: primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
              Expanded(
                flex: 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            inputUser,
                            style: TextStyle(
                              color: grey,
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /*   Text(
                            '=',
                            style: TextStyle(
                              color: grey,
                              fontSize: 80,
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              result,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 65,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      getRow('AC', 'CE', '%', '/'),
                      getRow('1', '2', '3', 'x'),
                      getRow('4', '5', '6', '-'),
                      getRow('7', '8', '9', '+'),
                      getRow('00', '0', '.', '='),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isOprator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOprator(text)) {
      return grey;
    } else {
      return primaryColor;
    }
  }

  bool TextOprator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getTextColor(String text) {
    if (isOprator(text)) {
      return white;
    } else {
      return white;
    }
  }
}
