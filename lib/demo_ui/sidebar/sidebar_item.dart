import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  IconData icon;
  String title;
  Function onTap;
  MenuItem({this.icon,this.title,this.onTap});
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: Colors.cyan,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
