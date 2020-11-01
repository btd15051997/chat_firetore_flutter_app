import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar.dart';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_navigation_bloc.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: colorMain(),
      body: Stack(
        children: [
          Center(
            child: Text("Hello"),
          ),
        ],
      )
    );
  }

}