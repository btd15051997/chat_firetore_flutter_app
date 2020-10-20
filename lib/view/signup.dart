
import 'package:chatfiretoreflutterapp/control/control.dart';
import 'package:chatfiretoreflutterapp/control/progress_snackbar.dart';
import 'package:chatfiretoreflutterapp/helper/authenticate.dart';
import 'package:chatfiretoreflutterapp/helper/helperfunctions.dart';
import 'package:chatfiretoreflutterapp/service/auth.dart';
import 'package:chatfiretoreflutterapp/service/database.dart';
import 'package:chatfiretoreflutterapp/view/chatroom_screen.dart';
import 'package:chatfiretoreflutterapp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false ;
  dynamic navigateAfterSeconds = Authenticate();
  AuthMethods authMethods = new AuthMethods();
  ShowProgressAndSnackBar showProgressAndSnackBar = ShowProgressAndSnackBar();

  final formKey = GlobalKey<FormState>();
  TextEditingController _editingControllerEmail = TextEditingController();
  TextEditingController _editingControllerPass = TextEditingController();
  TextEditingController _editingControllerName = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  signUpNow(){

  if(formKey.currentState.validate()){
    setState(() {
      isLoading = true;
    });

    if(isLoading){
      showProgressAndSnackBar.showAlertDialog(context,"Loading...");

      /*Save info usser to sharedpreference*/
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameInSharedPreference(_editingControllerName.text.toString());
      HelperFunctions.saveUserEmailInSharedPreference(_editingControllerEmail.text.toString());

      /*Add to database Firetore*/
      authMethods.signUpWithEmailAndPassword(_editingControllerEmail.text.trim(), _editingControllerPass.text.trim())
          .then((val) {
        if(val.toString() != null){
          /*Get uid*/
          databaseMethods.addUserToFiretore(_editingControllerName.text.toString(), _editingControllerEmail.text.toString());
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));

        }
      });

    }
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: isLoading ? Container(

          child: Center(child: CircularProgressIndicator()),

        ) : SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      /*Cách lề trên*/
                      TextFormField(
                          validator: (value){
                            return value.isEmpty ? "Please enter user name!": null;
                          },
                          controller: _editingControllerName,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("User name")),
                      SizedBox(height: 10),
                      /*Cách lề trên*/
                      TextFormField(
                          validator: (value){
                            return value.isEmpty || !ValidRegExp.isValidEmail(value) ?  "Please enter user email!" : null;
                          },

                          controller: _editingControllerEmail,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("User email")),
                      SizedBox(height: 10),
                      /*Cách lề trên*/
                      TextFormField(
                          validator: (value){
                            return value.isEmpty || !ValidRegExp.isValidPassword(value)? "Please enter password and length > 3 !" : null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: _editingControllerPass,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Enter Password")),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    signUpNow();
                    print('Sign Up :');
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            colors: [Colors.blue[400], Colors.blue])),
                    child: Text(
                      "Sign Up",
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: Text(
                    "Sign Up with Google",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "SignIn now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
