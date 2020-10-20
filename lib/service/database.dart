
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future getUserByUsername(String username) async{
    return  await Firestore.instance.collection('users').where("name", isEqualTo: username).getDocuments();
  }
  Future getUserByUserEmail(String useremail) async{
    return  await Firestore.instance.collection('users').where("email", isEqualTo: useremail).getDocuments();
  }


  static uploadUserInfo(userMap){
    Firestore.instance
        .collection("users")
        .document(userMap);
  }
  Future<void> addUserToFiretore(String name, String email) {
    CollectionReference users = Firestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': name, // John Doe
      'email': email, // Stokes and Sons/ 42
    }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));
  }
  Future createChatRoom(String chatRoomId,  users) async {
    return  await Firestore.instance.collection('ChatRoom').document(chatRoomId).setData(users).catchError((e){print(e);});
  }

}