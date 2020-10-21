import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class ConversationScreen extends StatefulWidget {
  String chatRoomID, userNameCurrent;

  ConversationScreen({this.chatRoomID, this.userNameCurrent});

  @override
  State<StatefulWidget> createState() => _ConversationScreen();
}

class _ConversationScreen extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController _textEditingController = TextEditingController();
  Stream chatMessageStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] ==
                          widget.userNameCurrent);
                },
              )
            : Center(
                child: Text("Conversation is Empty !"),
              );
      },
    );
  }

  getDateTimeNow() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    Text('$formattedDate');
  }

  /*StreamBuilder is a Widget that can convert a stream of user defined objects, to widgets. This takes two arguments
A stream
A builder, that can convert the elements of the stream to widgets*/

  sendMessages() {
    if (_textEditingController.text.isNotEmpty &&
        widget.userNameCurrent.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _textEditingController.text.toString(),
        "sendBy": widget.userNameCurrent,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      print("$messageMap : ${widget.userNameCurrent}");
      databaseMethods.sendMessagesToDatabase(widget.chatRoomID, messageMap);
      _textEditingController.text = "";
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseMethods.getConvertionMessage(widget.chatRoomID).then((value) {
      if (value != null) {
        setState(() {
          chatMessageStream = value;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Stack(
        children: [
          ChatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Message ...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      sendMessages();
                      print("Click to send message");
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
                            child: Image.asset("assets/images/send.png"))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 16, right: isSendByMe ? 16 : 0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.blueAccent, Colors.blueGrey]
                    : [Color(0x1AFFFFFF), Color(0x1AFFFFFF)]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(
          "$message",
          style: mediumTextStyle(),
        ),
      ),
    );
  }
}
