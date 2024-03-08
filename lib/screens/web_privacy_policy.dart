import 'package:flutter/material.dart';
import 'package:nookienation_tictactoe_calc/Helper/constant.dart';

import '../Helper/color.dart';
import '../Helper/string.dart';

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
        home: Demo()
    );
    ;
  }

}
class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,80),
        child: AppBar(
            elevation: 3,
            centerTitle: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0,),
              child: Image.asset(
                "assets/images/nookienation.png",
                height: 344,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(appName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
      ),
      body: ListView(
        padding: EdgeInsets.only(left:20,right: 20,top: 20),
        children: [
          Text(
            privacyPolicy,
            textAlign: TextAlign.justify,
            style: TextStyle(color: primaryColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}