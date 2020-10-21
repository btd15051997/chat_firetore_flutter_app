import 'dart:ui';

import 'package:chatfiretoreflutterapp/control/control.dart';
import 'package:chatfiretoreflutterapp/control/progress_snackbar.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/chatroom_screen.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _editingControllerEmail = TextEditingController();
  TextEditingController _editingControllerPass = TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  ShowProgressAndSnackBar showProgressAndSnackBar = new ShowProgressAndSnackBar();
  QuerySnapshot querySnapshot;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void SignInNow() {
    if (formKey.currentState.validate()) {

      setState(() {
        isLoading = true;
      });

      if(isLoading){
        showProgressAndSnackBar.showAlertDialog(context,"Loading...");
        authMethods
            .signInWithEmailAndPassword(_editingControllerEmail.text.trim(),
            _editingControllerPass.text.trim())
            .then((val) {
          /*Get email*/
          databaseMethods
              .getUserByUserEmail(_editingControllerEmail.text.toString())
              .then((value) {
            if(val != null){
              querySnapshot = value;
              /*Save info usser to sharedpreference*/
              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserEmailInSharedPreference(
                  querySnapshot.documents[0].data["email"]);
              HelperFunctions.saveUserNameInSharedPreference(
                  querySnapshot.documents[0].data["name"]);

              print("${HelperFunctions.saveUserNameInSharedPreference(
                  querySnapshot.documents[0].data["name"])} Name Signed ${HelperFunctions.saveUserEmailInSharedPreference(
                  querySnapshot.documents[0].data["email"])}");

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ChatRoom()));
            }else{


            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(context),
      body:Center(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        /*Cách lề trên*/
                        TextFormField(
                            validator: (value) {
                              return value.isEmpty ||
                                      !ValidRegExp.isValidEmail(value)
                                  ? "Please enter user email!"
                                  : null;
                            },
                            controller: _editingControllerEmail,
                            style: simpleTextStyle(),
                            decoration:
                                textFieldInputDecoration("Enter Email")),
                        SizedBox(height: 10),
                        /*Cách lề trên*/
                        TextFormField(
                            validator: (value) {
                              return value.isEmpty ||
                                      !ValidRegExp.isValidPassword(value)
                                  ? "Please enter password and length > 3 !"
                                  : null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: _editingControllerPass,
                            style: simpleTextStyle(),
                            decoration:
                                textFieldInputDecoration("Enter Password")),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            SignInNow();
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: LinearGradient(
                                    colors: [Colors.blue[400], Colors.blue])),
                            child: Text(
                              "Sign In",
                              style: mediumTextStyle(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: AlignmentDirectional.center,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: Text(
                            "Sign In with Google",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    "Register now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
