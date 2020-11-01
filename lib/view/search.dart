import 'dart:ui';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_navigation_bloc.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/conversation_screen.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeacrhScreen extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() => _SeacrhScreen();
}

class _SeacrhScreen extends State<SeacrhScreen> {
  var databaseMethods = DatabaseMethods();
  var _searchEdittingController = TextEditingController();
  QuerySnapshot searchSnapshot;
  String myName = "";
  bool _folder = true;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
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
    if (userName != myName) {
      String chatroomID = getChatRoomId(userName, myName);
      List<String> users = [myName, userName];
      print("Check neeee $myName : check neee2 $userName");
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomID
      };

      DatabaseMethods().createChatRoom(chatroomID, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    chatRoomID: chatroomID,
                    userNameCurrent: myName,
                  )));
    } else {
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

  Widget SearchTile({String username, String useremail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[6],
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name : " + username,
                style: simpleTextStyle(),
                textAlign: TextAlign.start,
              ),
              Text(
                "Email : " + useremail,
                style: TextStyle(color: Colors.black45,fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(username);
              print("Click to conversation");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colorMain(),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Messing",style: TextStyle(fontSize: 12,color: Colors.white,fontStyle: FontStyle.italic),),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorMain(),
      body: Container(
        margin: EdgeInsets.only(top: height / 9),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0)),
          color: Colors.white,
          //  gradient: _buildGradientWidget(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Center(
                /*     Expanded(
                        child: TextField(
                      controller: _searchEdittingController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Seacrh UserName...",
                        hintStyle: TextStyle(color: Colors.blue),
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Get username from database firetore
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
                              borderRadius: BorderRadius.circular(25)),
                          child: CircleAvatar(
                              child:
                                  Image.asset("assets/images/search_white.png"))),
                    )
*/
                child: _buildWidgetAnimationSearch(height),
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }

  _buildWidgetAnimationSearch(height) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folder ? 60 : height/2,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child:  GestureDetector(
                      child: TextField(
                        controller: _searchEdittingController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ,
            ),
          ),
          Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _folder ? Container() : Flexible(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      child: GestureDetector(
                        onTap: () {
                          initiateSearch();
                        },
                        child: Container(
                          height: _folder ? 0 : 40,
                          width: _folder ? 0 : 40,
                          child: Icon(
                            _folder ? null : Icons.search,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _folder = !_folder;
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Icon(
                          _folder ? Icons.search : Icons.close,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.compareTo(b) > 0) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
