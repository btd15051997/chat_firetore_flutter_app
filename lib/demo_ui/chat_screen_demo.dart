
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoChatScreen extends StatefulWidget{

  String name;

  DemoChatScreen({this.name});

  @override
  State<StatefulWidget> createState() => _DemoChatScreen();
}

class _DemoChatScreen  extends State<DemoChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: Text(widget.name),
        backgroundColor: Colors.redAccent,
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.videogame_asset)),
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
          color: Colors.white,
        ),
      ),
    );
  }

}