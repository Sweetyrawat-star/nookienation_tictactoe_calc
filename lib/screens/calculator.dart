/*
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


  Widget getRow(
      String text1,
      String text2,
      String text3,
      String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
                fontWeight: FontWeight.bold
            ),
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
                fontWeight: FontWeight.bold
            ),
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
                fontWeight: FontWeight.bold
            ),
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
              double eval = expression.evaluate(EvaluationType.REAL, contextModel);
              // Check if the result is an integer
              if (eval % 1 == 0) {
                // If it's an integer, convert it to an integer
                result = eval.toInt().toString();
              } else {
                // If it's not an integer, display it as a double
                result = eval.toString();
              }

              setState(() {
                // Set the result based on the condition
                result = result;
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
              fontSize: 40,
              color: white,
              fontWeight: FontWeight.bold,
            ),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                fontSize:  inputUser.length<15?40:inputUser.length <=25?16:12,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            result,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 75,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 5,),
                      getRow('AC', 'CE', '%', '÷'),
                      getRow('1', '2', '3', '×'),
                      getRow('4', '5', '6', '-'),
                      getRow('7', '8', '9', '+'),
                      getRow('00', '0', '.', '='),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
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
}*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:nookienation_tictactoe_calc/Helper/color.dart';

const operatorcolor = Color(0xff272727);
const buttonColor = Color(0xff191919);
const orangecolor = Color(0xffD9802E);

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //Variables
  double firstnumber = 0.0;
  double secondnumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    //if value is AC
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == 'CE') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('X', '*'); // Replace 'X' with '*'
        userInput = userInput.replaceAll('÷', '/'); // Replace '÷' with '/'
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        hideInput = true;
        outputSize = 52.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
            //Input and output area
            Expanded(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            //   hideInput ? '' :
                            input,
                            style: TextStyle(
                              fontSize: input.length < 65
                                  ? 40
                                  : input.length < 125
                                      ? 16
                                      : 12,
                              //48,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            output,
                            style: TextStyle(
                              fontSize: outputSize,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ))),
            Row(children: [
              button(text: 'AC', buttonBGcolor: grey, tColor: white),
              button(text: 'CE', buttonBGcolor: grey, tColor: white),
              button(text: '%', buttonBGcolor: grey, tColor: white),
              button(text: '÷', buttonBGcolor: grey, tColor: white),
            ]),
            Row(children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: 'X', buttonBGcolor: grey, tColor: white),
            ]),
            Row(children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', buttonBGcolor: grey, tColor: white),
            ]),
            Row(children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', buttonBGcolor: grey, tColor: white),
            ]),
            Row(children: [
              button(text: '00'),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', buttonBGcolor: orangecolor),
            ]),
          ],
        ),
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBGcolor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: buttonBGcolor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          )),
    ));
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String text) {
    setState(() {
      if (text == 'AC') {
        _expression = '';
        _result = '';
      } else if (text == 'CE') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          if (_result.endsWith(".0")) {
            setState(() {
              _result = _result.substring(0, _result.length - 2);
            });
          }
          setState(() {
            _result = _result.substring(0, _result.length - 1);
          });
        }
      } else if (text == '=') {
        _evaluateExpression();
      } else {
        _expression += text;
        _updateResult();
      }
    });
  }

  void _evaluateExpression() {
    // Replace % with /100 to handle percentages directly
    String modifiedExpression = _expression.replaceAll('%', '/100');
    Parser p = Parser();
    Expression exp = p.parse(modifiedExpression);
    ContextModel cm = ContextModel();
    double evalResult = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _result = evalResult.toString();
    });
  }

  void _updateResult() {
    try {
      String modifiedExpression = _expression.replaceAll('%', '/100');
      Parser p = Parser();
      Expression exp = p.parse(modifiedExpression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);
      _result = evalResult.toString();
    } catch (e) {
      _result = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 24.0, color: Colors.black,),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _result,
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                ],
              ),
            ),
          ),
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                'AC', 'CE', '%', '/',
                '7', '8', '9', '*',
                '4', '5', '6', '-',
                '1', '2', '3', '+',
                '00', '0', '.', '=', // Moved '=' to the last position
              ]
                  .map((text) => Expanded(
                          child: Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: buttonColor,
                              padding: const EdgeInsets.all(22),
                            ),
                            onPressed: () => _onButtonPressed(text),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )))
                  .toList())
        ],
      ),
    );
  }
}
