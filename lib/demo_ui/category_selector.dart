import 'dart:ui';

import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategotySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategotySelector();
}

class _CategotySelector extends State<CategotySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Message', 'Online', 'Groups','Account','MyHome'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: colorMain(),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    categories[index],
                    style: TextStyle(color: index == selectedIndex ? Colors.white : Colors.white54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  )),
            );
          }),
    );
  }
}
