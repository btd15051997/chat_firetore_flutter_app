import 'dart:ui';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/conversation_screen.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeacrhScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SeacrhScreen();
}

class _SeacrhScreen extends State<SeacrhScreen> {
  var databaseMethods = DatabaseMethods();
  var _searchEdittingController = TextEditingController();
  QuerySnapshot searchSnapshot;
  String myName ="";

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    myName = await HelperFunctions.getUserNameInSharedPreference();
  }

  void initiateSearch() {
    String searchname = _searchEdittingController.text.toString();
    databaseMethods.getUserByUsername(searchname).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }
  /*create chatroom, send user to conversation screen, pushreplacement*/
  createChatroomAndStartConversation(String userName) {
   if(userName != myName){
     String chatroomID = getChatRoomId(userName,myName);
     List<String> users = [userName,myName];
     print("Check neeee $myName : check neee2 $userName");
     Map<String, dynamic> chatRoomMap =
     {"users": users, "chatroomId": chatroomID};

     DatabaseMethods().createChatRoom(chatroomID, chatRoomMap).then((value) {
       if(value !=null){
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => ConversationScreen()));
       }
     });

   }else{
     print("you cannot send message to yourself");
   }
  }
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                username: searchSnapshot.documents[index].data["name"],
                useremail: searchSnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }
  Widget SearchTile({String username, String useremail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name :" + username,
                style: simpleTextStyle(),
                textAlign: TextAlign.start,
              ),
              Text(
                "Email :" + useremail,
                style: simpleTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(username);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Messing"),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _searchEdittingController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Seacrh UserName...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      /*Get username from database firetore*/
                      initiateSearch();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: CircleAvatar(
                            child:
                                Image.asset("assets/images/search_white.png"))),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.compareTo(b)>0) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
