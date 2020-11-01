import 'dart:ui';

import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(title: Text("Chats"),
    backgroundColor: colorMain(),
  );
}

InputDecoration textFieldInputDecoration(String hintText , isTextEmail){
  return InputDecoration(
    prefixIcon: isTextEmail ? Icon(Icons.email,color: colorMain(),) : Icon(Icons.paste_sharp,color: colorMain(),),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.black45),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
TextStyle simpleTextStyle (){
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
  }

TextStyle miniTextStyle (){
  return TextStyle(
      color: Colors.black,
      fontSize: 12
  );
}
Color colorMain(){
  return Color(0xFF262AAA);
}

TextStyle mediumTextStyle (){
  return TextStyle(
      color: Colors.black,
      fontSize: 12
  );
}