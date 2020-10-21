import 'dart:ui';

import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(title: Image.asset('assets/images/logo.png',height: 50,width: 50,),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green, //this has no effect
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
TextStyle simpleTextStyle (){
  return TextStyle(
    color: Colors.white,
    fontSize: 16
  );
  }

TextStyle miniTextStyle (){
  return TextStyle(
      color: Colors.white,
      fontSize: 12
  );
}

TextStyle mediumTextStyle (){
  return TextStyle(
      color: Colors.white,
      fontSize: 17
  );
}