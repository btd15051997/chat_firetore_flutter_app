import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar.dart';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_navigation_bloc.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocProvider<SideBarNavigationBloc>(
        create: (context) => SideBarNavigationBloc(),
        child: Stack(
          children: [
            BlocBuilder<SideBarNavigationBloc,NavigationStates>(
              builder: (context,navigationState){
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
