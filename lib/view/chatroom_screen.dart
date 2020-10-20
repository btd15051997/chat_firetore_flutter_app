import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/view/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _ChatRoom();
}

class _ChatRoom  extends State<ChatRoom>{

  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {

    print("SharedPreferences Emailuser ${HelperFunctions.getUserNameInSharedPreference().toString()} nameUser :${HelperFunctions.getUserNameInSharedPreference().toString()}");
    return Scaffold(
           appBar: AppBar(
             title: Image.asset("assets/images/logo.png",height: 50,),
             actions: [
               GestureDetector(
                 onTap: (){
                   authMethods.signOut();
                   HelperFunctions.saveUserLoggedInSharedPreference(false);
                   Navigator.pushReplacement(context, MaterialPageRoute(
                     builder: (context) => Authenticate()
                   ));
                 },
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 20),
                     child: Icon(Icons.exit_to_app_rounded)),
               ),
             ],
           ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SeacrhScreen()
          ));

        },
      ),
    );
  }
}