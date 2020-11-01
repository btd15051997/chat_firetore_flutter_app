
import "package:bloc/bloc.dart";
import 'package:chatfiretoreflutterapp/view/chatroom_screen.dart';
import 'package:chatfiretoreflutterapp/view/forgetpassword.dart';
import 'package:chatfiretoreflutterapp/view/search.dart';
enum NavigationEvent{
  HomePageClickedEvent,
  SearchUsertClickedEvent,
  MyOrdersClickedEvent,
}
abstract class NavigationStates {

}

class SideBarNavigationBloc extends Bloc<NavigationEvent, NavigationStates>{
  @override
  // TODO: implement initialState
  NavigationStates get initialState => ChatRoom();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvent event)async* {
   switch(event){
     case NavigationEvent.HomePageClickedEvent :
       yield ChatRoom();
       break;

     case NavigationEvent.SearchUsertClickedEvent :
       yield SeacrhScreen();
       break;

     case NavigationEvent.MyOrdersClickedEvent :
       yield ForgotPass();
       break;
   }
  }
}