import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/view/signin.dart';
import 'package:chatfiretoreflutterapp/view/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Authenticate();
}

class _Authenticate extends State<Authenticate> {

  /*Chạy vào SignIn(toggleView) thay đồi showSignIn = false, click singup sẽ chạy vào SignUp(toggleView) và ngược lại*/
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
