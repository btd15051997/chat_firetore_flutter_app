import 'dart:async';
import 'package:chatfiretoreflutterapp/view/signup.dart';
import 'package:flutter/material.dart';

import 'control/control_splash.dart';
void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Color(0xff1F1F1F),
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_SplashView();

}

class _SplashView extends State <MyApp> {

  dynamic navigateAfterSeconds = SignUp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () {
          if (navigateAfterSeconds is String) {
            // It's fairly safe to assume this is using the in-built material
            // named route component
            Navigator.of(context).pushReplacementNamed(navigateAfterSeconds);

          } else if (navigateAfterSeconds is Widget) {

            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => navigateAfterSeconds));

          } else {

            throw new ArgumentError(

                'widget.navigateAfterSeconds must either be a String or Widget'
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        alignment: Alignment.center,
         child: CircularProgressIndicator()
      ),
    );
  }

  /*  return SplashScreen(
      seconds: 3,
      backgroundColor: Colors.blue,
      loaderColor: Colors.white,
      photoSize: 150.0,
      navigateAfterSeconds: SignUp(),
    );*/
}

