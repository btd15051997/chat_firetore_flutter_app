import 'dart:async';
import 'dart:ui';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_item.dart';
import 'package:chatfiretoreflutterapp/demo_ui/sidebar/sidebar_navigation_bloc.dart';
import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {

  AnimationController _animationController;
  AuthMethods authMethods = new AuthMethods();
  String nameUser,emailUser;

  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfoCurrentUser();

    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSideBarOpenedSink = isSidebarOpenedStreamController.sink;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();

    isSideBarOpenedSink.close();
    isSidebarOpenedStreamController.close();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
      print("Check 1");
    } else {
      print("Check 2");
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }
  _eventLogOut() {
    authMethods.signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Authenticate()));
  }
  _buildListileMenuSidebar(){
    return ListTile(
      title: Text(nameUser.isEmpty?
       "Name: User Empty!":"Name : $nameUser",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(emailUser.isEmpty ? "Email: User Empty!":"Email : $emailUser",style: TextStyle(color: Colors.white54,
          fontSize: 12,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),),
      leading: CircleAvatar(
        child: Icon(Icons.perm_identity,color: Colors.white,),
        radius: 40,
      ),
    );
  }
  _getInfoCurrentUser()async{
     await HelperFunctions.getUserNameInSharedPreference().then((value) {
      setState(() {
        nameUser = value;
      });
    });
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        emailUser = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 40,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorMain(),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              _buildListileMenuSidebar(),
                              /*Widget tạo đường kẽ*/
                              Divider(
                                height: 50,
                                thickness: 0.5,
                                color: Colors.white54,
                                indent: 16,
                                endIndent: 16,
                              ),
                              MenuItem(
                                icon: Icons.home,
                                title: "Home",
                                onTap: (){
                                  BlocProvider.of<SideBarNavigationBloc>(context).add(NavigationEvent.HomePageClickedEvent);
                                  onIconPressed();
                                },
                              ),
                              MenuItem(
                                icon: Icons.person,
                                title: "My Account",
                              ),
                              MenuItem(
                                icon: Icons.person_search,
                                title: "Search User",
                                onTap: (){

                                  BlocProvider.of<SideBarNavigationBloc>(context).add(NavigationEvent.SearchUsertClickedEvent);
                                  onIconPressed();

                                },
                              ),
                              MenuItem(
                                icon: Icons.card_giftcard,
                                title: "Wishlist",
                              ),
                              Divider(
                                height: 50,
                                thickness: 0.5,
                                color: Colors.white54,
                                indent: 16,
                                endIndent: 16,
                              ),
                              MenuItem(
                                icon: Icons.settings,
                                title: "Settings",
                              ),
                              GestureDetector(
                                onTap: (){
                                  _eventLogOut();
                                },
                                child: MenuItem(
                                  icon: Icons.exit_to_app,
                                  title: "Logout",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Text("By : DatBT",style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),)
                        )
                      ],
                    )
                ),
              ),
              Align(
                alignment: Alignment(0, 0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35.0,
                      height: 110.0,
                      alignment: Alignment.center,
                      color: colorMain(),
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
/* //Điểm control, tới điểm end :quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)*/
class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    print("width : ${size.width} + height : ${size.height}");

/*
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width - (size.width/4), size.height, size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height - (size.height - 20));
    path.quadraticBezierTo(size.width - (size.width/4), 0.0, size.width/2, 0.0);
    path.quadraticBezierTo(size.width/4, 0.0, 0.0, size.height - (size.height - 20));
*/

    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}
