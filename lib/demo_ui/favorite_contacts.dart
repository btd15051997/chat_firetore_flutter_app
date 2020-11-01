
import 'dart:ui';
import 'package:chatfiretoreflutterapp/demo_ui/chat_screen_demo.dart';
import 'package:chatfiretoreflutterapp/demo_ui/contact_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteContacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteContacts();
}

class _FavoriteContacts extends State<FavoriteContacts> {
  int selectedIndex = 0;
  final List<String> categories = [
    'Message',
    'Online',
    'Groups',
    'Account',
    'MyHome'
  ];
  void _showPopupMenu() async {
    await showMenu(
      context: context,
      /*RelativeRect.fromLTRB(double left, double top, double right, double bottom)*/
      position: RelativeRect.fromLTRB(100, 100, 50, 100),
      items: [
        PopupMenuItem<String>(
            child: const Text('Contacts 1'), value: 'Doge'),
        PopupMenuItem<String>(
            child: const Text('Contacts 2'), value: 'Lion'),
      ],
      elevation: 8.0,
    );
  }
  final List<UserContact> listsFavorite = UserContact.createArrayUser();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Expanded(
                   child: Text(
                "Favorite Contacts",
                style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
              ),
                 ),
                Container(
                  child: IconButton(
                     icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                       _showPopupMenu();
                  },
              ),
                )
            ],
          )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            height: 110.0,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 5),
                itemCount: listsFavorite.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DemoChatScreen(name: listsFavorite[index].name,)
                          )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage(listsFavorite[index].imageUrl),
                          ),
                          SizedBox(height: 5,),
                          Text(listsFavorite[index].name,style: TextStyle(color: Colors.blueGrey,fontSize: 13.0,fontWeight: FontWeight.bold ),),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
