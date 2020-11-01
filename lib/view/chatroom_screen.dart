import 'dart:ui';

import 'package:chatfiretoreflutterapp/demo_ui/category_selector.dart';
import 'package:chatfiretoreflutterapp/demo_ui/drawer/chatroom_drawer.dart';
import 'package:chatfiretoreflutterapp/demo_ui/favorite_contacts.dart';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar.dart';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_navigation_bloc.dart';
import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/conversation_screen.dart';
import 'package:chatfiretoreflutterapp/view/search.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class ChatRoom extends StatefulWidget with NavigationStates{
  @override
  State<StatefulWidget> createState() => _ChatRoom();
}

class _ChatRoom extends State<ChatRoom> {
  String myName;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chats Room",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return ChatRoomTile(
                                snapshot
                                    .data.documents[index].data["chatroomId"],
                                myName);
                          }),
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  _buildAppbar(){
    return AppBar(
      backgroundColor: colorMain(),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {
          _drawerKey.currentState.openDrawer();
        },
      ),
      title:Text("Chats",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      actions: [
        GestureDetector(
          onTap: () {
            _eventLogOut();
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.exit_to_app)),
        ),
      ],
    );
  }

  getUserInfo() async {
    myName = await HelperFunctions.getUserNameInSharedPreference();
    databaseMethods.getChatRooms(myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain(),
    /*  key: _drawerKey,
      drawerEdgeDragWidth: 0,*/
      //appBar: _buildAppbar(),
      //drawer: ChatroomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20,),
              CategotySelector(),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      children: [
                        Container(child: FavoriteContacts()),
                        Container(child: chatRoomList()),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueGrey,
        backgroundColor: Colors.white,
        buttonBackgroundColor: colorMain(),
        height: 50,
        items: [
          Icon(Icons.verified_user,size: 20,color: Colors.white,),
          Icon(Icons.add,size: 20,color: Colors.white,),
          Icon(Icons.list,size: 20,color: Colors.white,),
        ],
        onTap: (index){
          print("Current Index is : $index");
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SeacrhScreen()));
        },
      ),
    );
  }

  _eventLogOut() {
    authMethods.signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Authenticate()));
  }
}

class ChatRoomTile extends StatelessWidget {
  String roomChatname;
  String myName;

  ChatRoomTile(this.roomChatname, this.myName);

  createChatroomAndStartConversation(String userName, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  chatRoomID: roomChatname,
                  userNameCurrent: userName,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildListChatroom(context);
  }

  _buildListChatroom(context) {
    return GestureDetector(
      onTap: () {
        createChatroomAndStartConversation(myName, context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                "${roomChatname.substring(0, 1).toUpperCase()}",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              child: Text(
                "Name :$roomChatname",
                style: mediumTextStyle(),
                /*Rút gọn text EX: buithanh...*/
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("5.50 PM",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  Container(
                      width: 40,
                      height: 20,
                      padding: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("NEW",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
