import 'dart:async';
import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/view/chatroom_screen.dart';
import 'package:flutter/material.dart';

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
  State<StatefulWidget> createState() => _SplashView();
}

class _SplashView extends State<MyApp> {
  bool userIsLogged;
  dynamic navigateAfterSeconds;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLogged = value;
      });
      print("$userIsLogged loginnnnnnnnnnn");

      Timer(Duration(seconds: 2), () {

        if (userIsLogged != null) {
          if (userIsLogged == true) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => ChatRoom()));
          } else {
            print("$userIsLogged : jaakdhksbdlkjasndklasdljandalw");
            navigateAfterSeconds = Authenticate();
            CheckNamePageToRouter(navigateAfterSeconds);
          }
        } else {
          print("$userIsLogged : jaakdhksbdlkjasndklasdljandalw");
          navigateAfterSeconds = Authenticate();
          CheckNamePageToRouter(navigateAfterSeconds);
        }

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLoggedInState();

  }

  void CheckNamePageToRouter(dynamic navigateAfterSeconds2){
    /*Check router page*/
          if (navigateAfterSeconds2 is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(navigateAfterSeconds2);
      } else if (navigateAfterSeconds2 is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => navigateAfterSeconds2));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/send.png",
                height: 100,
                width: 100,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator()),
          ],
        ),
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
