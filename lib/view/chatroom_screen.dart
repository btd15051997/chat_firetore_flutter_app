import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/conversation_screen.dart';
import 'package:chatfiretoreflutterapp/view/search.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
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
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      snapshot.data.documents[index].data["chatroomId"],myName);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    myName = await HelperFunctions.getUserNameInSharedPreference();
    databaseMethods.getChatRooms(myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "SharedPreferences Emailuser ${HelperFunctions.getUserNameInSharedPreference().toString()} nameUser :${HelperFunctions.getUserNameInSharedPreference().toString()}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.exit_to_app_rounded)),
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SeacrhScreen()));
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  String roomChatname;
  String myName;
  ChatRoomTile(this.roomChatname,this.myName);

  createChatroomAndStartConversation(String userName,context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomID: roomChatname,userNameCurrent: userName,)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        createChatroomAndStartConversation(myName, context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
              child: Text("${roomChatname.substring(0, 1).toUpperCase()}",textAlign: TextAlign.center,),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Name :$roomChatname",
              style: mediumTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
