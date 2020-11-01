import 'dart:ui';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatroomDrawer extends StatefulWidget {
  @override
  _ChatroomDrawerState createState() => _ChatroomDrawerState();
}

class _ChatroomDrawerState extends State<ChatroomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/send.png'),
                        fit: BoxFit.fill),
                  ),
                )),
              ),
              Expanded(child: _buildListChoosse()),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            child: Text("CopyRight :DatBT"),
          ),
        ),
      ],
    ));
  }

  _buildListChoosse() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SideBarLayout()));
              },
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.account_tree_outlined,
                      size: 30,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Click to SideBar Page",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 30,
                      ),
                      color: Theme.of(context).primaryColor,
                    )),
                Text(
                  "Message",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: IconButton(
                      icon: Icon(
                        Icons.vibration,
                        size: 30,
                      ),
                      color: Theme.of(context).primaryColor,
                    )),
                Text(
                  "Vibration",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
